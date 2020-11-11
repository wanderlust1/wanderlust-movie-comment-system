package service

import dao.UserDao
import entity.Login
import entity.Register
import entity.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class UserServiceImpl: UserService {

    @Autowired
    lateinit var mUserDao: UserDao

    override fun login(user: User): Int {
        return if (mUserDao.queryUser(user)?.userId == user.userId) {
            Login.SUCC
        } else {
            Login.FAIL
        }
    }

    override fun register(user: User): Int {
        return if (mUserDao.insertUser(user) == 1) {
            Register.SUCC
        } else {
            Register.FAIL
        }
    }

}