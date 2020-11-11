package entity

class Register {
    companion object {
        const val SUCC = 0
        const val EXISTED = 1
        const val FAIL = 2
    }

    data class Rsp(
        val code: Int,
        val msg: String
    )

}