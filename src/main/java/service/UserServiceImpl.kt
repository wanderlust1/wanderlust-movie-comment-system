package service

import dao.UserDao
import entity.User
import event.UserEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.io.File
import java.util.*
import javax.imageio.stream.FileImageOutputStream

@Service
class UserServiceImpl: UserService {

    @Autowired
    lateinit var mUserDao: UserDao

    override fun login(user: User): UserEvent.LoginQueryRsp {
        val queryUser = mUserDao.queryUser(user)
        return if (queryUser?.userId == user.userId) {
            UserEvent.LoginQueryRsp(queryUser, UserEvent.SUCC)
        } else {
            UserEvent.LoginQueryRsp(null, UserEvent.FAIL)
        }
    }

    override fun register(user: User): Int {
        return when (mUserDao.insertUser(user)) {
            1    -> UserEvent.SUCC
            -2   -> UserEvent.EXISTED
            else -> UserEvent.FAIL
        }
    }

    override fun modifyPassword(id: String, newPassword: String): Int {
        return if (mUserDao.updatePassword(id, newPassword) == 1) {
            UserEvent.SUCC
        } else {
            UserEvent.FAIL
        }
    }

    override fun modifyNickname(id: String, newNickname: String): Int {
        return if (mUserDao.updateNickname(id, newNickname) == 1) {
            UserEvent.SUCC
        } else {
            UserEvent.FAIL
        }
    }

    override fun modifyHeader(id: String, newHeader: String, newHeaderName: String, oldHeader: String?, imageStream: ByteArray): Int {
        return if (mUserDao.updateHeader(id, newHeaderName) == 1) { //先更新数据库信息，再写入头像文件
            val imageOutput = FileImageOutputStream(File(newHeader))
            if (imageStream.size < 3) return UserEvent.FAIL
            return try {
                imageOutput.write(imageStream, 0, imageStream.size)
                File(oldHeader ?: "").deleteFile()
                UserEvent.SUCC
            } catch (e: Exception) {
                UserEvent.FAIL
            } finally {
                imageOutput.close()
            }
        } else {
            UserEvent.FAIL
        }
    }

    private fun File.deleteFile(): Boolean {
        return if (isFile && exists()) {
            delete()
            true
        } else false
    }

}