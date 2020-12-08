package event

import com.google.gson.annotations.SerializedName
import entity.Movie
import entity.MovieDetail

interface MovieEvent {

    data class MovieDetailRsp(@SerializedName("data") val item: MovieDetail? = null)

    data class MovieListRsp (@SerializedName("data") var list: List<Movie> = mutableListOf(), var count: Int = 0) {
        init { count = list.size }
    }

}