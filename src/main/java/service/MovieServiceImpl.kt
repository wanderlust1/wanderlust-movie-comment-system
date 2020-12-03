package service

import dao.MovieDao
import entity.Movie
import entity.MovieDetail
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

    override fun getAllMovies(): List<Movie> {
        return mMovieDao.queryAllMovies()
    }

    override fun getMoviesBySearch(search: String): List<Movie> {
        return mMovieDao.queryMoviesBySearch(search)
    }

}