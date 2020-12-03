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

/**
 * @author Wanderlust 2020.10.17
 */
@Controller
class LoginController {

    @Autowired
    lateinit var mUserService: UserService

    //登录后保存全局user
    private var gUser: User? = null

    @RequestMapping("/login")
    fun login(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val queryRsp = mUserService.login(Gson().fromJson(req.getParameter("login_req"), User::class.java))
        gUser = queryRsp.user
        val msg = when (queryRsp.code) {
            UserEvent.SUCC -> "登录成功"
            UserEvent.FAIL -> "登录失败，账号或密码错误"
            else -> "登录失败，未知错误"
        }
        rsp.writer.write(Gson().toJson(UserEvent.LoginRsp(queryRsp.code, msg)))
    }

    @RequestMapping("/register")
    fun register(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val request = Gson().fromJson(req.getParameter("register_req"), User::class.java)
        val result = try {
            if (mUserService.register(request) == UserEvent.SUCC) {
                UserEvent.RegisterRsp(UserEvent.SUCC, "注册成功")
            } else {
                UserEvent.RegisterRsp(UserEvent.FAIL, "注册失败，未知错误")
            }
        } catch (e: IbatisException) {
            UserEvent.RegisterRsp(UserEvent.EXISTED, "注册失败，该账号已存在")
        } catch (e: Exception) {
            UserEvent.RegisterRsp(UserEvent.FAIL, "注册失败，未知错误")
        }
        rsp.writer.write(Gson().toJson(result))
    }

    @RequestMapping("/getUserProfile")
    fun getUserProfile(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        rsp.writer.write(Gson().toJson(gUser))
    }

}