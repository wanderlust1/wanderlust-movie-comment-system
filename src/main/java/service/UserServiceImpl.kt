package service

import dao.UserDao
import entity.User
import event.UserEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.io.File
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
        return if (mUserDao.insertUser(user) == 1) {
            UserEvent.SUCC
        } else {
            UserEvent.FAIL
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

    override fun saveHeaderImage(path: String, bytes: ByteArray): Int {
        val imageOutput = FileImageOutputStream(File(path))
        if (bytes.size < 3) return UserEvent.FAIL
        return try {
            imageOutput.write(bytes, 0, bytes.size)
            UserEvent.SUCC
        } catch (e: Exception) {
            UserEvent.FAIL
        } finally {
            imageOutput.close()
        }
    }

}