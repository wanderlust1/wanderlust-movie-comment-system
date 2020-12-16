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
        return query<Movie>("dao.MovieDaoImpl.queryAllMovies", params)
    }

    override fun queryMoviesBySearch(search: String, currPage: String, pageSize: String): List<Movie> {
        val params = mapOf(Pair("key", search), Pair("currPage", currPage.toInt()), Pair("pageSize", pageSize.toInt()))
        return query("dao.MovieDaoImpl.queryMoviesBySearch", params)
    }

    override fun insertMovie(movie: MovieDetail): Int {
        return insert("dao.MovieDaoImpl.insertMovie", movie)
    }

    override fun insertFavour(user_id: String, movie_id: String): Int {
        val params = mapOf(Pair("user_id", user_id), Pair("movie_id", movie_id))
        return insert("dao.MovieDaoImpl.insertFavour", params)
    }

    override fun deleteFavour(user_id: String, movie_id: String): Int {
        val params = mapOf(Pair("user_id", user_id), Pair("movie_id", movie_id))
        return insert("dao.MovieDaoImpl.deleteFavour", params)
    }

    override fun queryFavourList(user_id: String): List<Movie> {
        return query("dao.MovieDaoImpl.queryFavourList",user_id)
    }

    override fun queryFavourStatus(userId: String, movieId: String): Boolean {
        val params = mapOf(Pair("user_id", userId), Pair("movie_id", movieId))
        return query<Any>("dao.MovieDaoImpl.queryFavourStatus", params).isNotEmpty()
    }

}

