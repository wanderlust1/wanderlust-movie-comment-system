package service

import dao.MovieDao
import entity.Movie
import entity.MovieDetail
import entity.MovieFilter
import event.CommentEvent
import event.MovieEvent
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat

/**
 * @author Wanderlust 2020.10.17
 */
@Service("MovieServiceImpl")
class MovieServiceImpl: MovieService {

    @Autowired
    lateinit var mMovieDao: MovieDao

    override fun getAllMovieDetail(): List<MovieDetail> {
        return mMovieDao.queryAllMovieDetail()
    }

    override fun getMovieDetailById(id: String): MovieDetail? {
        return mMovieDao.queryMovieDetailById(id)
    }

    @ExperimentalStdlibApi
    override fun getAllMovies(oriParams: Map<Any?, Any?>): List<Movie> {
        val params = buildMap<String, String> {
            oriParams.forEach {
                put(it.key as String, (it.value as Array<*>)[0].toString())
            }
        }
        //过滤条件
        val filter = MovieFilter()
        filter.sort = params["sort"] ?: ""
        filter.style = MovieFilter.filter(params["style"] ?: "")
        filter.area = MovieFilter.filter(params["area"] ?: "").split(" ")
        filter.year = MovieFilter.filter(params["year"] ?: "")
        filter.currPage = params["curr_page"]?.toInt() ?: 0
        filter.pageSize = params["page_size"]?.toInt() ?: 0
        return mMovieDao.queryAllMovies(filter)
    }

    override fun getMoviesBySearch(search: String, currPage: String, pageSize: String): List<Movie> {
        return mMovieDao.queryMoviesBySearch(search, currPage, pageSize)
    }

    override fun setFavour(userId: String, movieId: String, operation: Int): Int {
        return if (operation == MovieEvent.ADD_FAVOUR) {
            if (mMovieDao.insertFavour(userId, movieId) == 1) {
                MovieEvent.SUCC
            } else {
                MovieEvent.FAIL
            }
        } else if (operation == MovieEvent.DEL_FAVOUR) {
            if (mMovieDao.deleteFavour(userId, movieId) == 1) {
                MovieEvent.SUCC
            } else {
                MovieEvent.FAIL
            }
        } else {
            CommentEvent.FAIL
        }
    }

    override fun getFavourList(userId: String): List<Movie> {
        return mMovieDao.queryFavourList(userId)
    }

    override fun getFavourStatus(userId: String, movieId: String): Int {
        return if (mMovieDao.queryFavourStatus(userId, movieId)) {
            MovieEvent.ADD_FAVOUR //已收藏
        } else {
            MovieEvent.DEL_FAVOUR //未收藏
        }
    }

}