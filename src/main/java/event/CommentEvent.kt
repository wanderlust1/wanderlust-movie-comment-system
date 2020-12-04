package event

import com.google.gson.annotations.SerializedName
import entity.Comment

interface CommentEvent {

    companion object {
        const val SUCC = 0
        const val FAIL = 1
        const val LIKE = 10
        const val DISLIKE = 11
    }

    class CommentListRsp(val entityList: List<Comment>) {
        var code: Int = 0
        var count: Int = 0

        @SerializedName("data")
        var list: List<Comment> = mutableListOf()

        init {
            list = entityList
            count = entityList.size
        }
    }

    data class AddCommentRsp(val code: Int = 1)

    data class LikeCommentReq(
        @SerializedName("comment_id") val commentId: String = "",
        @SerializedName("user_id") val userId: String = "",
        @SerializedName("like_code") val likeCode: Int = 0
    )

    data class LikeCommentRes(@SerializedName("result_code") val resultCode: Int = 1)

}