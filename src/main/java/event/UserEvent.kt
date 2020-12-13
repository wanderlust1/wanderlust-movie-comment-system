package event

import entity.User

interface UserEvent {

    companion object {
        const val SUCC = 0
        const val FAIL = 1
        const val EXISTED = 2
    }

    data class LoginRsp(val code: Int, val msg: String)

    data class LoginQueryRsp(val user: User?, val code: Int)

    data class RegisterRsp(val code: Int, val msg: String)

    data class UploadImageRsp(val code: Int)

    data class ModifyInfoReq(val id: String, val newValue: String)

    data class ModifyInfoRsp(val code: Int)

}