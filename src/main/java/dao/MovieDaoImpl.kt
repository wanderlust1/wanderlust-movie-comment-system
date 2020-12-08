package dao

import entity.Movie
import entity.MovieDetail
import entity.MovieFilter
import org.springframework.stereotype.Repository

/**
 * @author Wanderlust 2020.10.17
 */
@Repository("MovieDaoImpl")
class MovieDaoImpl: MovieDao, BaseDao() {

    override fun queryAllMovieDetail(): List<MovieDetail> {
        return query("dao.MovieDaoImpl.queryAllMovieDetail")
    }

    override fun queryMovieDetailById(id: String): MovieDetail? {
        val result = query<MovieDetail>("dao.MovieDaoImpl.queryMovieDetailBySearch", id)
        return if (result.isNotEmpty()) result[0] else null
    }

    override fun queryAllMovies(params: MovieFilter): List<Movie> {
        return query("dao.MovieDaoImpl.queryAllMovies", params)
    }

    override fun queryMoviesBySearch(search: String): List<Movie> {
        return query("dao.MovieDaoImpl.queryMoviesBySearch", search)
    }

    override fun insertMovie(movie: MovieDetail): Int {
        return insert("dao.MovieDaoImpl.insertMovie", movie)
    }

}

