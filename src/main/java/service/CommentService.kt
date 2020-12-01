package service

import entity.Comment

/**
 * @author Wanderlust 2020.12.1
 */
interface CommentService {

    fun getCommentListByMovieId(id: String): List<Comment>

}