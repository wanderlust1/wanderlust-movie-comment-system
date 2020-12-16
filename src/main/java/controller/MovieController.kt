package controller

import com.google.gson.Gson
import event.MovieEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import service.MovieService
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession

/**
 * @author Wanderlust 2020.10.17
 */
@Controller
class MovieController {

    @Autowired
    lateinit var mMovieService: MovieService

    @RequestMapping("/getMovieDetailById")
    fun getMovieDetailById(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = MovieEvent.MovieDetailRsp(mMovieService.getMovieDetailById(req.getParameter("id")))
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/getAllMovies")
    fun getAllMovies(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = MovieEvent.MovieListRsp(mMovieService.getAllMovies(req.parameterMap))
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/getMoviesBySearch")
    fun getMoviesBySearch(req: HttpServletRequest, rsp: HttpServletResponse) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = MovieEvent.MovieListRsp(mMovieService.getMoviesBySearch(
                req.getParameter("search"),
                req.getParameter("curr_page"),
                req.getParameter("page_size"),
        ))
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/setFavour")
    fun setFavour(req: HttpServletRequest, rsp: HttpServletResponse, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = MovieEvent.SetFavourRsp(mMovieService.setFavour(
                session.getAttribute("user_id") as String,
                req.getParameter("movie_id"),
                req.getParameter("set_favour").toInt()
        ))
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/getFavourList")
    fun getFavourList(req: HttpServletRequest, rsp: HttpServletResponse, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = MovieEvent.GetFavourListRsp(list = mMovieService.getFavourList(
                session.getAttribute("user_id") as String
        ))
        rsp.writer.write(Gson().toJson(data))
    }

    @RequestMapping("/getFavourStatus")
    fun getFavourStatus(req: HttpServletRequest, rsp: HttpServletResponse, session: HttpSession) {
        rsp.contentType = "text/html;charset=UTF-8"
        val data = MovieEvent.GetFavourStatusRsp(mMovieService.getFavourStatus(
                session.getAttribute("user_id") as String,
                req.getParameter("movie_id")
        ))
        rsp.writer.write(Gson().toJson(data))
    }
}