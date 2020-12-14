package service

import entity.Comment
import entity.Like
import event.CommentEvent

/**
 * @author Wanderlust 2020.12.1
 */
interface CommentService {

    fun getCommentListByMovieId(movieId: String, userId: String): List<Comment>

    fun addComment(comment: Comment): Int

    fun setLike(event: CommentEvent.LikeCommentReq): Int

    fun getCommentRecordById(id: String): List<Comment>

    fun getLikeRecordById(id: String): List<Like>

    fun deleteComment(id: String): Int

}