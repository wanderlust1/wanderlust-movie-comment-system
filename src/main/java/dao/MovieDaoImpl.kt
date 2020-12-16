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
        val a = query<Movie>("dao.MovieDaoImpl.queryAllMovies", params)
        println(a)
        return a
    }

    override fun queryMoviesBySearch(search: String, currPage: String, pageSize: String): List<Movie> {
        val params = mapOf(Pair("key", search), Pair("currPage", currPage.toInt()), Pair("pageSize", pageSize.toInt()))
        val a =  query<Movie>("dao.MovieDaoImpl.queryMoviesBySearch", params)
        println(a)
        return a
    }

    override fun insertMovie(movie: MovieDetail): Int {
        return insert("dao.MovieDaoImpl.insertMovie", movie)
    }

    override fun setFavour(user_id: String, movie_id: String): Int {
        val params = mapOf(Pair("user_id", user_id), Pair("movie_id", movie_id))
        return insert("dao.MovieDaoImpl.setFavour", params)
    }

    override fun getFavourList(user_id: String): List<Movie> {
        return query("dao.MovieDaoImpl.getFavourList",user_id)
    }

    override fun getFavourStatus(user_id: String, movie_id: String): Boolean {
        val params = mapOf(Pair("user_id", user_id), Pair("movie_id", movie_id))
        return query<Any>("dao.MovieDaoImpl.getFavourStatus", params).isNotEmpty()
    }

}

