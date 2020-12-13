package entity

import com.google.gson.annotations.SerializedName
import java.text.SimpleDateFormat

/**
 * 点赞实体类
 * @author Wanderlust 2020.12.13
 */
data class Like (

    @SerializedName("movie_id")
    var movieId: String = "",

    @SerializedName("movie_name")
    var movieName: String = "",

    @SerializedName("comment_id")
    var commentId: String = "",

    @SerializedName("content")
    var commentContent: String = "",

    @SerializedName("name")
    var commentUserName: String = "", //评论用户的昵称

    @SerializedName("header")
    var commentUserHeader: String = "", //评论用户的头像

    var time: String = "",

    var rate: String = ""

): Comparable<Like> {

    //可根据日期排序
    override fun compareTo(other: Like): Int {
        val format = SimpleDateFormat("yyyy.MM.dd hh:mm:ss")
        val date1 = format.parse(this.time)
        val date2 = format.parse(other.time)
        return if (date1.after(date2)) 1 else -1
    }

}