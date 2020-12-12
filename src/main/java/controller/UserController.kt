package controller

import com.google.gson.Gson
import entity.Comment
import event.UserEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.multipart.MultipartFile
import service.UserService
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession

/**
 * @author Wanderlust 2020.12.11
 */
@Controller
class UserController {

    @Autowired
    lateinit var mUserService: UserService

    @RequestMapping("/modifyPassword")
    fun modifyPassword(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val request = Gson().fromJson(req.getParameter("req"), UserEvent.ModifyInfoReq::class.java)
        val data = UserEvent.ModifyInfoRsp(mUserService.modifyPassword(request.id, request.newValue))
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/modifyNickname")
    fun modifyNickname(req: HttpServletRequest, rsp: HttpServletResponse, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        val request = Gson().fromJson(req.getParameter("req"), UserEvent.ModifyInfoReq::class.java)
        val result = mUserService.modifyNickname(request.id, request.newValue)
        val data = UserEvent.ModifyInfoRsp(result)
        if (result == UserEvent.SUCC) {
            session.setAttribute("nick_name", request.newValue)
        }
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/uploadHeader")
    fun uploadHeader(req: HttpServletRequest, rsp: HttpServletResponse, file: MultipartFile, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        val headerPath = session.servletContext.getRealPath("/") + "header\\${req.getParameter("user_id")}.jpg"
        rsp.writer.write(Gson().toJson(UserEvent.UploadImageRsp(mUserService.saveHeaderImage(headerPath, file.bytes))))
    }

}