package dao

import entity.Comment

interface CommentDao {

    fun queryCommentByMovieId(id: String): List<Comment>

}