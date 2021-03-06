package dao

import entity.Movie
import entity.MovieDetail
import entity.MovieFilter

/**
 * @author Wanderlust 2020.10.17
 */
interface MovieDao {

    fun queryAllMovieDetail(): List<MovieDetail>

    fun queryMovieDetailById(id: String): MovieDetail?

    fun queryAllMovies(params: MovieFilter): List<Movie>

    fun queryMoviesBySearch(search: String, currPage: String, pageSize: String): List<Movie>

    fun insertMovie(movie: MovieDetail): Int

    fun insertFavour(user_id: String, movie_id: String): Int

    fun deleteFavour(user_id: String, movie_id: String): Int

    fun queryFavourList(user_id:String): List<Movie>

    fun queryFavourStatus(userId: String, movieId: String): Boolean

}