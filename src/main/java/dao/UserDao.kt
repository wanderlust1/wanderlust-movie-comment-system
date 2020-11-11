package dao

import entity.User

interface UserDao {

    fun queryUser(user: User): User?

    fun insertUser(user: User): Int

}