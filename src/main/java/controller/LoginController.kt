package controller

import com.google.gson.Gson
import entity.User
import event.UserEvent
import org.apache.ibatis.exceptions.IbatisException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import service.UserService
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession

/**
 * @author Wanderlust 2020.10.17
 */
@Controller
class LoginController {

    @Autowired
    lateinit var mUserService: UserService

    @RequestMapping("/login")
    fun login(req: HttpServletRequest, rsp: HttpServletResponse, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        val queryRsp = mUserService.login(Gson().fromJson(req.getParameter("login_req"), User::class.java))
        val msg = when (queryRsp.code) {
            UserEvent.SUCC -> {
                session.setAttribute("user_id", queryRsp.user?.userId)
                session.setAttribute("nick_name", queryRsp.user?.nickName)
                session.setAttribute("header", queryRsp.user?.header)
                "登录成功"
            }
            UserEvent.FAIL -> "登录失败，账号或密码错误"
            else -> "登录失败，未知错误"
        }
        rsp.writer.write(Gson().toJson(UserEvent.LoginRsp(queryRsp.code, msg)))
    }

    @RequestMapping("/register")
    fun register(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val request = Gson().fromJson(req.getParameter("register_req"), User::class.java)
        val result = when (mUserService.register(request)) {
            UserEvent.SUCC ->
                UserEvent.RegisterRsp(UserEvent.SUCC, "注册成功")
            UserEvent.EXISTED ->
                UserEvent.RegisterRsp(UserEvent.EXISTED, "注册失败，该账号已存在")
            else ->
                UserEvent.RegisterRsp(UserEvent.FAIL, "注册失败，未知错误")
        }
        rsp.writer.write(Gson().toJson(result))
    }

    @RequestMapping("/logout")
    fun logout(req: HttpServletRequest, rsp: HttpServletResponse, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        session.removeAttribute("user_id")
        session.removeAttribute("nick_name")
        session.removeAttribute("header")
        rsp.writer.write(Gson().toJson(1))
    }

}