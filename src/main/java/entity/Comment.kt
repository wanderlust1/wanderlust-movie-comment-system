package entity

import com.google.gson.annotations.SerializedName
import java.lang.Exception

data class Comment(

    var id: String = "",

    var count: String = "",

    var username: String = "",

    @SerializedName("user_id")
    var userId: String = "",

    var time: String = "",

    var content: String = "",

    var rate: String = ""

): Comparable<Comment> {

    //可根据日期排序
    override fun compareTo(other: Comment): Int {
        val date1 = this.time.split("/")
        val date2 = other.time.split("/")
        return try {
            if (date1.isNullOrEmpty() || date2.isNullOrEmpty()) {
                0
            } else if (date2[0] != date1[0]) {
                date1[0].toInt() - date2[0].toInt()
            } else if (date2[1] != date1[1]) {
                date1[1].toInt() - date2[1].toInt()
            }  else if (date2[2] != date1[2]) {
                date1[2].toInt() - date2[2].toInt()
            }  else {
                0
            }
        } catch (e: Exception) {
            0
        }
    }

}