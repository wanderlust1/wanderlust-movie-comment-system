package service

import entity.User
import event.UserEvent

interface UserService {

    fun login(user: User): UserEvent.LoginQueryRsp

    fun register(user: User): Int

}