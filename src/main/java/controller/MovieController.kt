package controller

import com.google.gson.Gson
import event.MovieEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import service.MovieService
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

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
        val data = MovieEvent.MovieListRsp(mMovieService.getMoviesBySearch(req.getParameter("search")))
        rsp.writer.write(Gson().toJson(data))
    }

}