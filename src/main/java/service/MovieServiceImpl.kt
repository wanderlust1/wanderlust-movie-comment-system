package service

import dao.MovieDao
import entity.Movie
import entity.MovieDetail
import entity.MovieFilter
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

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

}