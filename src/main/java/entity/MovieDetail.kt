package entity

data class MovieDetail(

    var movieId: String = "0",

    var movieName: String = "",

    var director: String = "",

    var scriptwriter: String = "",

    var actors: String = "",

    var movieType: String = "",

    var movieArea: String = "",

    var movieLang: String = "",

    var movieDate: String = "",

    var movieSize: String = "",

    var movieAlias: String = "",

    var movieIMDb: String = "",

    var movieDesc: String = "",

    var rate: String = "0.0", //评分

    var rateCount: String = "", //评分人数

    var ratePer: String = "" //1-5星的占比，用空格隔开

)