package dao

import entity.Movie
import entity.MovieDetail
import org.springframework.stereotype.Repository

/**
 * @author Wanderlust 2020.10.17
 */
@Repository("MovieDaoImpl")
class MovieDaoImpl: MovieDao, BaseDao() {

    override fun queryAllMovieDetail(): List<MovieDetail> {
        return getListByTemplatedMapper("dao.MovieDaoImpl.queryAllMovieDetail")
    }

    override fun queryMovieDetailById(id: String): MovieDetail {
        return getListByTemplatedMapper<MovieDetail>("dao.MovieDaoImpl.queryMovieDetailBySearch", id)[0]
    }

    override fun queryAllMovies(): List<Movie> {
        return getListByTemplatedMapper("dao.MovieDaoImpl.queryAllMovies")
    }

    override fun queryMoviesBySearch(search: String): List<Movie> {
        return getListByTemplatedMapper("dao.MovieDaoImpl.queryMoviesBySearch", search)
    }

    override fun insertMovie(movie: MovieDetail): Int {
        openSession()
        val result = session?.insert("dao.MovieDaoImpl.insertMovie", movie)
        session?.commit()
        return result ?: -1
    }

}

