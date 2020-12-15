package entity

/**
 * 电影实体类
 * @author Wanderlust 2020.11.12
 */
data class Movie(

    var id: String = "",

    var title: String = "",

    var rate: String = "",

    var total: Int = 0, //当前筛选条件中的电影总数量

)