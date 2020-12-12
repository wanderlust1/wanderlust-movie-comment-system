package dao

import entity.User

interface UserDao {

    fun queryUser(user: User): User?

    fun insertUser(user: User): Int

    fun updatePassword(id: String, newPassword: String): Int

    fun updateNickname(id: String, newNickname: String): Int

    fun updateHeader(id: String, newHeader: String): Int

}