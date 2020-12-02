package service

import dao.CommentDao
import entity.Comment
import event.CommentEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

/**
 * @author Wanderlust 2020.12.1
 */
@Service("CommentServiceImpl")
class CommentServiceImpl: CommentService {

    @Autowired
    lateinit var mCommentDao: CommentDao

    override fun getCommentListByMovieId(id: String): List<Comment> {
        return mCommentDao.queryCommentByMovieId(id).sorted()
    }

    override fun addComment(comment: Comment): Int {
        return if (mCommentDao.insertComment(comment) == 1) {
            CommentEvent.SUCC
        } else {
            CommentEvent.FAIL
        }
    }

}