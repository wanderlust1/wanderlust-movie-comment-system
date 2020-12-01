package utils

import com.google.gson.Gson
import dao.MovieDaoImpl
import entity.MovieDetail
import org.jsoup.Jsoup
import java.io.File
import java.util.*


var ua = arrayOf("Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36 OPR/37.0.2178.32",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586",
        "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko",
        "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)",
        "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)",
        "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0)",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 BIDUBrowser/8.3 Safari/537.36",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36 Core/1.47.277.400 QQBrowser/9.4.7658.400",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 UBrowser/5.6.12150.8 Safari/537.36",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36 SE 2.X MetaSr 1.0",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36 TheWorld 7",
        "Mozilla/5.0 (Windows NT 6.1; W…) Gecko/20100101 Firefox/60.0")

data class ProxyRes(
        var code: Int = 0, var msg: List<Ip> = listOf()
)

data class Ip(
        var port: String = "", var ip: String = ""
)

fun getProxyIp(): List<Ip> {
    val doc = Jsoup
            .connect("http://piping.mogumiao.com/proxy/api/get_ip_bs?appKey=22b1201fe67442058419f6be607d1e78&count=5&expiryDate=0&format=1&newLine=2")
            .get()
    return Gson().fromJson(doc.text(), ProxyRes::class.java).msg
}

fun main() {
    /*val proxyIpList = getProxyIp()
    val ip = proxyIpList[Random().nextInt(proxyIpList.size - 1)]
    println(proxyIpList)
    val proxy = Proxy(Proxy.Type.HTTP, InetSocketAddress(ip.ip, ip.port.toInt()))
    val doc = Jsoup.connect("https://www.bilibili.com/bangumi/play/ss34353?theme=movie")
            .timeout(5000)
            //.proxy(proxy)
            .userAgent(ua[Random().nextInt(13)])
            .ignoreContentType(true)
            .header("referer", "https://www.baidu.com")
            .get()
    println(doc.text())*/
    Thread {
        val lines: List<String> = File("D:\\Wanderlust\\Documents\\WeChat Files\\wxid_sm74t61v53db22\\FileStorage\\File\\2020-11\\data.txt").readLines()
        lines.forEach {
            val id = it.split("    ")[5]
            println("正在爬取 id=$id...")
            insertToDB(id/*, proxyIpList[Random().nextInt(proxyIpList.size - 1)]*/)
            Thread.sleep(5000)
        }
    }.start()
}

fun insertToDB(movieId: String/*, proxy: Proxy*/) {
    val doc = Jsoup.connect("https://movie.douban.com/subject/$movieId")
            .timeout(5000)
            //.proxy(proxy)
            .userAgent(ua[Random().nextInt(13)])
            .ignoreContentType(true)
            .header("referer", "https://www.baidu.com")
            .get()
    val movie = MovieDetail()
    movie.movieId = movieId
    doc.getElementById("content").getElementsByTag("h1").first().children().forEach {
        if (it.className() != "year") movie.movieName = it.text() ?: ""
    }
    movie.movieDesc = doc.getElementById("link-report").text().trim()
    val info = doc.getElementById("info").text().split(" ")
    var i = 0
    while (i < info.size) {
        if (i < info.size && info[i].contains(":")) {
            val pl = info[i]
            i++
            val builder = StringBuilder()
            while (i < info.size && !info[i].contains(":")) {
                builder.append(info[i])
                i++
            }
            put(movie, pl, builder.toString())
        } else {
            i++
        }
    }
    val rate = doc.getElementById("interest_sectl")
    movie.rate = rate.getElementsByClass("rating_num").first().text() ?: ""
    movie.rateCount = rate.getElementsByClass("rating_people").first().child(0).text() ?: ""
    movie.ratePer = buildString {
        val ratep = rate.getElementsByClass("ratings-on-weight").first().children()
        for (i in ratep) {
            append(i?./*getElementsByClass("rating_per").*/text()?.replace(" ", ":") ?: "")
            append(if (ratep.indexOf(i) == ratep.size - 1) "" else "/")
        }
    }
    println("${movie.movieName}(${movie.movieId}) 已爬取")
    if (MovieDaoImpl().insertMovie(movie) == 1) {
        println("${movie.movieName}(${movie.movieId}) 已成功写入数据库")
    } else {
        println("${movie.movieName}(${movie.movieId}) 保存到数据库失败！")
    }
    println("---------------------------------------------------")
}

fun put(movie: MovieDetail, pl: String, content: String) {
    val plList = listOf("导演", "编剧", "主演", "类型", "地区", "语言", "上映", "片长", "又名", "IMDb")
    when {
        pl.contains(plList[0]) -> movie.director = content
        pl.contains(plList[1]) -> movie.scriptwriter = content
        pl.contains(plList[2]) -> movie.actors = content
        pl.contains(plList[3]) -> movie.movieType = content
        pl.contains(plList[4]) -> movie.movieArea = content
        pl.contains(plList[5]) -> movie.movieLang = content
        pl.contains(plList[6]) -> movie.movieDate = content
        pl.contains(plList[7]) -> movie.movieSize = content
        pl.contains(plList[8]) -> movie.movieAlias = content
        pl.contains(plList[9]) -> movie.movieIMDb = content
    }
}