package service

import entity.Movie
import entity.MovieDetail

/**
 * @author Wanderlust 2020.10.17
 */
interface MovieService {

    /**
     * 查询所有电影详情数据
     * @return JSON格式的电影详情列表数据
     */
    fun getAllMovieDetail(): List<MovieDetail>

    /**
     * 查询含指定关键词的电影详情数据
     * @param search 查询关键词
     * @return 符合搜索条件的JSON格式的电影详情列表数据
     */
    fun getMovieDetailById(id: String): MovieDetail?

    /**
     * 查询所有电影数据
     * @return JSON格式的电影列表数据
     */
    fun getAllMovies(): List<Movie>

    /**
     * 查询含指定关键词的电影数据
     * @param search 查询关键词
     * @return 符合搜索条件的JSON格式的电影列表数据
     */
    fun getMoviesBySearch(search: String): List<Movie>

}