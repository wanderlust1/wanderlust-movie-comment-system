package dao

import entity.Comment
import entity.Like

interface CommentDao {

    fun queryCommentByMovieId(movieId: String, userId: String): List<Comment>

    fun insertComment(comment: Comment): Int

    fun insertLike(commentId: String, userId: String, time: String): Int

    fun deleteLike(commentId: String, userId: String): Int

    fun queryCommentRecordById(id: String): List<Comment>

    fun queryLikeRecordById(id: String): List<Like>

}