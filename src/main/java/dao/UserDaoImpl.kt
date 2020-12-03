package dao

import entity.User
import org.springframework.stereotype.Repository

@Repository("UserDaoImpl")
class UserDaoImpl: UserDao, BaseDao() {

    override fun queryUser(user: User): User? {
        val result = query<User>("dao.UserDaoImpl.queryUser", user)
        return if (result.isNotEmpty()) result[0] else null
    }

    override fun insertUser(user: User): Int {
        return insert("dao.UserDaoImpl.insertUser", user)
    }

}