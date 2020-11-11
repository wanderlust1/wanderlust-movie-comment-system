package controller

import com.google.gson.Gson
import entity.Hero
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import service.HeroService
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * @author Wanderlust 2020.10.17
 */
@Controller
class HeroController {

    @Autowired
    lateinit var mHeroService: HeroService

    @RequestMapping("/getAllHero")
    fun getAllHero(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = Hero.Rsp(mHeroService.getAllHero())
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/getHero")
    fun getHero(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = Hero.Rsp(mHeroService.getHero(req.getParameter("search")))
        rsp.writer.write(Gson().toJson(data))
    }

}