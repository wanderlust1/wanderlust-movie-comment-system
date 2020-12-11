package event

import entity.User

interface UserEvent {

    companion object {
        const val SUCC = 0
        const val FAIL = 1
        const val EXISTED = 1
    }

    data class LoginRsp(val code: Int, val msg: String)

    data class LoginQueryRsp(val user: User?, val code: Int)

    data class RegisterRsp(val code: Int, val msg: String)

    data class UploadImageRsp(val code: Int)

}