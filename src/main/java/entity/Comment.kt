package entity

import com.google.gson.annotations.SerializedName
import java.text.SimpleDateFormat

/**
 * 评论实体类
 * @author Wanderlust 2020.12.13
 */
data class Comment(

    var id: String = "", //评论ID

    var count: String = "", //点赞数

    var username: String = "",

    @SerializedName("user_id")
    var userId: String = "",

    var time: String = "",

    var content: String = "",

    var rate: String = "",

    @SerializedName("movie_id")
    var movieId: String = "",

    @SerializedName("is_like")
    var isLike: Int = 0,

    var header: String = "",

    @SerializedName("movie_name")
    var movieName: String = ""

): Comparable<Comment> {

    //可根据日期排序
    override fun compareTo(other: Comment): Int {
        val time1 = if (!this.time.contains(" ")) {
            this.time + " 00:00:00"
        } else {
            this.time
        }
        val time2 = if (!other.time.contains(" ")) {
            other.time + " 00:00:00"
        } else {
            other.time
        }
        val format = SimpleDateFormat("yyyy/MM/dd hh:mm:ss")
        val date1 = format.parse(time1)
        val date2 = format.parse(time2)
        return if (date1.after(date2)) 1 else -1
    }

}