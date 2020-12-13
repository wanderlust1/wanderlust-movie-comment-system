package event

import com.google.gson.annotations.SerializedName
import entity.Comment
import entity.Like

interface CommentEvent {

    companion object {
        const val SUCC = 0
        const val FAIL = 1
        const val LIKE = 10
        const val DISLIKE = 11
    }

    data class CommentListRsp(val data: List<Comment> = mutableListOf(), var code: Int = 0, var count: Int = 0) {
        init { count = data.size }
    }

    data class AddCommentRsp(val code: Int = 1)

    data class LikeCommentReq(

        @SerializedName("comment_id")
        val commentId: String = "",

        @SerializedName("user_id")
        val userId: String = "",

        @SerializedName("like_code")
        val likeCode: Int = 0

    )

    data class LikeCommentRes(@SerializedName("result_code") val resultCode: Int = 1)

    data class LikeRecordRes(val list: List<Like> = mutableListOf(), var count: Int = 0) {
        init { count = list.size }
    }

    data class CommentRecordRes(val list: List<Comment> = mutableListOf(), var count: Int = 0) {
        init { count = list.size }
    }

}