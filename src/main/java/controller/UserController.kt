package controller

import com.google.gson.Gson
import event.UserEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.multipart.MultipartFile
import service.UserService
import java.util.*
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
        val id = req.getParameter("user_id")
        val basePath = session.servletContext.getRealPath("/") + "header\\"
        val newHeaderName = buildString { //生成一串随机字符，替换之前的头像文件，防止页面缓存导致头像不更新
            append(id)
            for (i in 1..10) {
                append(Random().nextInt(10))
            }
        }
        val oldHeaderName = session.getAttribute("header") as String?
        val oldHeader = if (oldHeaderName != null) "$basePath$oldHeaderName.jpg" else null
        val newHeader = "$basePath$newHeaderName.jpg"
        val result = mUserService.modifyHeader(id, newHeader, newHeaderName, oldHeader, file.bytes)
        if (result == UserEvent.SUCC) {
            session.setAttribute("header", newHeaderName)
        }
        rsp.writer.write(Gson().toJson(UserEvent.UploadImageRsp(result)))
    }

}