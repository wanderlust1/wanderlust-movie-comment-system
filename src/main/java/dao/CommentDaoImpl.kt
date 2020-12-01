package dao

import entity.Comment
import org.springframework.stereotype.Repository

/**
 * @author Wanderlust 2020.10.17
 */
@Repository("CommentDaoImpl")
class CommentDaoImpl: CommentDao, BaseDao() {

    override fun queryCommentByMovieId(id: String): List<Comment> {
        return getListByTemplatedMapper("dao.CommentDaoImpl.queryCommentByMovieId", id)
    }

}