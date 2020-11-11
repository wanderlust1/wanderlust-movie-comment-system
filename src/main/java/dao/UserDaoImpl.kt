package dao

import entity.User
import org.springframework.stereotype.Repository

@Repository("UserDaoImpl")
class UserDaoImpl: UserDao, BaseDao() {

    override fun queryUser(user: User): User? {
        openSession()
        println("hahaha")
        return session?.selectOne("dao.UserDaoImpl.queryUser", user) as User?
    }

    override fun insertUser(user: User): Int {
        openSession()
        val result = session?.insert("dao.UserDaoImpl.insertUser", user)
        session?.commit()
        return result ?: -1
    }

}