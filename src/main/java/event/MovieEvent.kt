package event

import com.google.gson.annotations.SerializedName
import entity.Movie
import entity.MovieDetail

interface MovieEvent {

    data class MovieDetailRsp(@SerializedName("data") val item: MovieDetail? = null)

    data class MovieListRsp (@SerializedName("data") var list: List<Movie> = mutableListOf(), var count: Int = 0, var total: Int = 0) {
        init {
            count = list.size // count是当前页的电影条数
            total = if (list.isNotEmpty()) list[0].total else 0 // total是在当前筛选条件的电影总条数
        }
    }

}