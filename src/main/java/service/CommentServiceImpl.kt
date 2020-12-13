package service

import dao.CommentDao
import entity.Comment
import entity.Like
import event.CommentEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat

/**
 * @author Wanderlust 2020.12.1
 */
@Service("CommentServiceImpl")
class CommentServiceImpl: CommentService {

    @Autowired
    lateinit var mCommentDao: CommentDao

    override fun getCommentListByMovieId(movieId: String, userId: String): List<Comment> {
        return mCommentDao.queryCommentByMovieId(movieId, userId).sorted()
    }

    override fun addComment(comment: Comment): Int {
        return if (mCommentDao.insertComment(comment) == 1) {
            CommentEvent.SUCC
        } else {
            CommentEvent.FAIL
        }
    }

    override fun setLike(event: CommentEvent.LikeCommentReq): Int {
        return if (event.likeCode == CommentEvent.LIKE) {
            val time = SimpleDateFormat("yyyy.MM.dd hh:mm:ss")
            if (mCommentDao.insertLike(event.commentId, event.userId, time.format(System.currentTimeMillis())) == 1) {
                CommentEvent.SUCC
            } else {
                CommentEvent.FAIL
            }
        } else if (event.likeCode == CommentEvent.DISLIKE) {
            if (mCommentDao.deleteLike(event.commentId, event.userId) == 1) {
                CommentEvent.SUCC
            } else {
                CommentEvent.FAIL
            }
        } else {
            CommentEvent.FAIL
        }
    }

    override fun getCommentRecordById(id: String): List<Comment> {
        return mCommentDao.queryCommentRecordById(id).sorted()
    }

    override fun getLikeRecordById(id: String): List<Like> {
        return mCommentDao.queryLikeRecordById(id).sorted()
    }

}