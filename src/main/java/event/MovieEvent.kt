package event

import com.google.gson.annotations.SerializedName
import entity.Movie
import entity.MovieDetail

interface MovieEvent {

    data class MovieDetailRsp(@SerializedName("data") val item: MovieDetail? = null)

    class MovieListRsp(val entityList: List<Movie>) {
        var code: Int = 0
        var count: Int = 0
        var msg: String = ""

        @SerializedName("data")
        var list: List<Movie> = mutableListOf()

        init {
            list = entityList
            count = entityList.size
        }
    }

}