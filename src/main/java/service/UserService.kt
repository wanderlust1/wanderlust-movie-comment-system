package service

import entity.User

interface UserService {

    fun login(user: User): Int

    fun register(user: User): Int

}