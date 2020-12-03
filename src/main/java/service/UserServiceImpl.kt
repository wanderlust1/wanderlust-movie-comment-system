package service

import dao.UserDao
import entity.User
import event.UserEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

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

}