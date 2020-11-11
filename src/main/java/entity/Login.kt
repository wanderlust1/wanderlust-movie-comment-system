package entity

class Login {
    companion object {
        const val SUCC = 0
        const val FAIL = 1
    }

    data class Rsp(
        val code: Int,
        val msg: String
    )
}