package dao

import entity.Comment

interface CommentDao {

    fun queryCommentByMovieId(movieId: String, userId: String): List<Comment>

    fun insertComment(comment: Comment): Int

    fun insertLike(commentId: String, userId: String): Int

    fun deleteLike(commentId: String, userId: String): Int

}