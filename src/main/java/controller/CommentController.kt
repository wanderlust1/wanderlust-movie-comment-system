package controller

import com.google.gson.Gson
import entity.Comment
import entity.User
import event.CommentEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import service.CommentService
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * @author Wanderlust 2020.12.1
 */
@Controller
class CommentController {

    @Autowired
    lateinit var mCommentService: CommentService

    @RequestMapping("/getCommentByMovieId")
    fun getCommentByMovieId(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        println(Gson().toJson(req.getParameter("movie_id") + "  " + req.getParameter("user_id")))
        val data = mCommentService.getCommentListByMovieId(req.getParameter("movie_id"), req.getParameter("user_id"))
        rsp.writer.write(Gson().toJson(CommentEvent.CommentListRsp(data)))
        println(Gson().toJson(CommentEvent.CommentListRsp(data)))
    }

    @RequestMapping("/addComment")
    fun addComment(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val request = Gson().fromJson(req.getParameter("add_comment_req"), Comment::class.java)
        rsp.writer.write(Gson().toJson(CommentEvent.AddCommentRsp(mCommentService.addComment(request))))
    }

    @RequestMapping("/setCommentLike")
    fun setCommentLike(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val request = Gson().fromJson(req.getParameter("like_req"), CommentEvent.LikeCommentReq::class.java)
        rsp.writer.write(Gson().toJson(CommentEvent.LikeCommentRes(mCommentService.setLike(request))))
    }

}