package dao

import entity.Comment
import entity.Like
import org.springframework.stereotype.Repository

/**
 * @author Wanderlust 2020.10.17
 */
@Repository("CommentDaoImpl")
class CommentDaoImpl: CommentDao, BaseDao() {

    override fun queryCommentByMovieId(movieId: String, userId: String): List<Comment> {
        val params = mapOf(Pair("movie_id", movieId), Pair("user_id", userId))
        return query("dao.CommentDaoImpl.queryCommentByMovieId", params)
    }

    override fun insertComment(comment: Comment): Int {
        return insert("dao.CommentDaoImpl.insertComment", comment)
    }

    override fun insertLike(commentId: String, userId: String, time: String): Int {
        val params = mapOf(Pair("comment_id", commentId), Pair("user_id", userId), Pair("time", time))
        return insert("dao.CommentDaoImpl.insertLike", params)
    }

    override fun deleteLike(commentId: String, userId: String): Int {
        val params = mapOf(Pair("comment_id", commentId), Pair("user_id", userId))
        return delete("dao.CommentDaoImpl.deleteLike", params)
    }

    override fun deleteComment(id: String): Int {
        return delete("dao.CommentDaoImpl.deleteComment", id)
    }

    override fun queryCommentRecordById(id: String): List<Comment> {
        return query("dao.CommentDaoImpl.queryCommentRecordById", id)
    }

    override fun queryLikeRecordById(id: String): List<Like> {
        return query("dao.CommentDaoImpl.queryLikeRecordById", id)
    }

}