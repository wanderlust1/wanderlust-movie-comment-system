package service

import entity.User
import event.UserEvent

interface UserService {

    fun login(user: User): UserEvent.LoginQueryRsp

    fun register(user: User): Int

    fun modifyPassword(id: String, newPassword: String): Int

    fun modifyNickname(id: String, newNickname: String): Int

    fun modifyHeader(id: String, newHeader: String, newHeaderName: String, oldHeader: String?, imageStream: ByteArray): Int

}