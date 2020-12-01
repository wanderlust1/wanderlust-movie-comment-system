package event

import com.google.gson.annotations.SerializedName
import entity.Comment

interface CommentEvent {

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

}