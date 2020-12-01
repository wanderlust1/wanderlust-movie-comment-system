package dao

import entity.Movie
import entity.MovieDetail

/**
 * @author Wanderlust 2020.10.17
 */
interface MovieDao {

    fun queryAllMovieDetail(): List<MovieDetail>

    fun queryMovieDetailById(id: String): MovieDetail

    fun queryAllMovies(): List<Movie>

    fun queryMoviesBySearch(search: String): List<Movie>

    fun insertMovie(movie: MovieDetail): Int

    fun closeSession()

}