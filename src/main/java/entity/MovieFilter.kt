package entity

data class MovieFilter (

    var sort: String = "",

    var style: String = "",

    var area: List<String> = mutableListOf(),

    var year: String = ""

) {
    companion object {

        val sParamsMapper = mapOf(
            Pair("all", ""),
            Pair("xj", "喜剧"),
            Pair("jq", "剧情"),
            Pair("dz", "动作"),
            Pair("aq", "爱情"),
            Pair("dh", "动画"),
            Pair("js", "惊悚"),
            Pair("dl", "大陆"),
            Pair("gat", "香港 澳门 台湾"),
            Pair("om", "美国 英国 法国 加拿大 意大利 葡萄牙 西班牙 澳大利亚 俄罗斯"),
            Pair("rb", "日本"),
            Pair("hg", "韩国"),
            Pair("2020", "2020"),
            Pair("2019", "2019")
        )

        fun filter(param: String): String = sParamsMapper[param] ?: ""

    }
}