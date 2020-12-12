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

    override fun updatePassword(id: String, newPassword: String): Int {
        val params = mapOf(Pair("id", id), Pair("new_password", newPassword))
        return update("dao.UserDaoImpl.updatePassword", params)
    }

    override fun updateNickname(id: String, newNickname: String): Int {
        val params = mapOf(Pair("id", id), Pair("new_nickname", newNickname))
        return update("dao.UserDaoImpl.updateNickname", params)
    }

}