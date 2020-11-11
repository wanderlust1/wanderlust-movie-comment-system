package entity

import com.google.gson.annotations.SerializedName

/**
 * @author Wanderlust 2019.11.16
 */
data class Hero (

    var title: String? = "",
    var alias: String? = "",
    var name: String? = "",
    var tags: String? = "",
    var lines: String? = ""

) {
    class Rsp(val entityList: List<Hero>) {
        var code: Int = 0
        var count: Int = 0
        var msg: String = ""

        @SerializedName("data")
        var list: List<Hero> = mutableListOf()

        init {
            list = entityList
            count = entityList.size
        }
    }
}