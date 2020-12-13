<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>找电影</title>
    <link href="layui/css/layui.css" rel="stylesheet"/>
    <link href="nav/nav_style.css" rel="stylesheet"/>
    <script src="nav/nav_script.js"></script>
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="layui/layui.js"></script>

    <%
        if (session.getAttribute("user_id") == null || session.getAttribute("user_id") == "") {
            response.sendRedirect("login.jsp");
            return;
        }
        String user_id = (String) session.getAttribute("user_id");
        String nick_name = (String) session.getAttribute("nick_name");
        String header = (String) session.getAttribute("header");
    %>

    <style type="text/css">
        body {
            overflow-y: scroll;
        }
        #div_list_container {
            width: 900px;
            margin-top: 30px;
            margin-left: -20px;
            padding-right: 20px;
        }
        .div_list_item {
            width: 160px;
            display: inline-block;
            margin-left: 20px;
            margin-bottom: 20px;
        }
        .div_list_img {
            width: 160px;
            height: 214px;
        }
        .div_list_item a {
            text-decoration: none;
        }
        .div_list_img img {
            width: 100%;
            height: 100%;
            border-radius: 5px;
        }
        .p_list_movie_name {
            height: 34px;
            margin: 6px 5px;
            font-size: 13px;
            text-align: center;
            color: #15151c;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            overflow: hidden;
        }
        .p_list_movie_name span {
            margin-left: 3px;
            font-size: 13px;
            color: #f5b000;
        }
        .div_list_item:hover p {
            color: #1E9FFF;
        }
        .div_header {
            width: 880px;
            margin-top: 20px;
        }
        #div_header_search {
            overflow: hidden;
            zoom: 1;
        }
        #div_header_search h2 {
            float: left;
            font-weight: lighter;
            font-size: 25px;
        }
        #search_box {
            float: right;
        }
        #search_box button {
            width: 55px;
            height: 35px;
            margin-left: 5px;
            line-height: 35px;
        }
        #search_box input {
            width: 300px;
            height: 35px;
            line-height: 35px;
        }
        .table_selection {
            margin-top: 15px;
        }
        .layui-form-radio * {
            font-size: 14px !important;
            margin-top: -2px; !important;
        }
        .layui-form-radioed i {
            border-color:#1E9FFF !important;
            background-color:#FFF !important;
            color:#1E9FFF !important;
            font-weight: bold;
        }
        #footer {
            width: 880px;
            margin: 0 0 15px;
            padding-top: 15px;
            text-align: center;
            font-size: 16px;
            font-weight: lighter;
            border-top: #e3e3e3 1px solid;
        }
        #footer span {
            height:25px;
            font-size: 13px;
            color: #B2B2B2;
            line-height: 25px;
        }
    </style>
</head>
<body>
    <div id="navigation" style="width: 100%; font-weight: lighter; font-family: Calibri, sans-serif"">
        <ul class="layui-nav layui-bg-black">
            <li class="layui-nav-item" id="nav_logo"><a href="javascript:">电影评论系统 by Wanderlust</a></li>
            <li class="layui-nav-item"><a href="movie_index.jsp">找电影</a></li>
            <li class="layui-nav-item" style="float: right">
                <a href="javascript:">
                    <img src="header/<%=header%>.jpg" class="layui-nav-img" id="nav_header" onerror="this.src = 'header/default_head.png'">
                    <span id="nav_id" style="margin-right: 5px;"><%=nick_name%></span>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="user_detail.jsp">个人信息</a></dd>
                    <dd><a href="javascript:logout('<%=request.getContextPath()%>');">退出登录</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <div style="width: 880px;margin: 0 auto;">
    <div class="div_header">
        <div id="div_header_search">
            <a href="user_detail.jsp"><h2>找电影</h2></a>
            <div id="search_box">
                <div class="layui-inline"><div class="layui-input-inline edit_input_div">
                    <input type="text" name="Book_num" autocomplete="off" placeholder="请输入电影名称、ID等关键字..." class="layui-input" id="input">
                </div></div>
                <div class="layui-inline"><div class="layui-input-inline">
                    <button id="search" data-type="search" class="layui-btn layui-btn-normal"><i class="layui-icon layui-icon-search"></i></button>
                </div></div>
            </div>
        </div>
        <form class="layui-form layui-form-pane table_selection" lay-filter="table_selection" action="">
            <div class="layui-form-item" pane style="font-size: 14px">
                <label class="layui-form-label">排序</label>
                <div class="layui-input-block" style="margin-left: 120px;">
                    <input type="radio" name="sort" value="default" title="默认" checked>
                    <input type="radio" name="sort" value="name" title="按名称排序" lay-filter="sort">
                    <input type="radio" name="sort" value="rate" title="按评分排序" lay-filter="sort">
                </div>
            </div>
            <div class="layui-form-item" pane style="font-size: 14px; margin-top: -8px !important;">
                <label class="layui-form-label">风格</label>
                <div class="layui-input-block" style="margin-left: 120px;">
                    <input type="radio" name="style" value="all" title="全部" checked>
                    <input type="radio" name="style" value="jq" title="剧情">
                    <input type="radio" name="style" value="xj" title="喜剧">
                    <input type="radio" name="style" value="dz" title="动作">
                    <input type="radio" name="style" value="aq" title="爱情">
                    <input type="radio" name="style" value="dh" title="动画">
                    <input type="radio" name="style" value="js" title="惊悚">
                </div>
            </div>
            <div class="layui-form-item" pane style="font-size: 14px; margin-top: -8px !important;">
                <label class="layui-form-label">地区</label>
                <div class="layui-input-block" style="margin-left: 120px;">
                    <input type="radio" name="area" value="all" title="全部" checked>
                    <input type="radio" name="area" value="dl" title="大陆">
                    <input type="radio" name="area" value="gat" title="港澳台">
                    <input type="radio" name="area" value="om" title="欧美">
                    <input type="radio" name="area" value="rb" title="日本">
                    <input type="radio" name="area" value="hg" title="韩国">
                </div>
            </div>
            <div class="layui-form-item" pane style="font-size: 14px; margin-top: -8px !important;">
                <label class="layui-form-label">年份</label>
                <div class="layui-input-block" style="margin-left: 120px;">
                    <input type="radio" name="year" value="all" title="全部" checked>
                    <input type="radio" name="year" value="2020" title="2020">
                    <input type="radio" name="year" value="2019" title="2019">
                </div>
            </div>
        </form>
    </div>
    <div id="div_list_container"></div>
    <div id="footer"></div>
    </div>

<script>
    layui.use(['element', 'layer', 'form'], function () {
        var element = layui.element;
        var form = layui.form;
        //按钮事件
        layui.$('.layui-btn').on('click', function () {
            searchMovie(layui.$('#input').val());
        });
        //单选监听
        form.on('radio()', function(data) {
            filterMovie(false);
        });
        filterMovie(true);
    });

    function searchMovie(key) {
        //搜索前，重置所有筛选器
        $("#div_list_container")[0].innerHTML = "";
        layui.form.val("table_selection", {
            "sort": "default", "style": "all", "area": "all", "year": "all"
        });
        if (key === '') {
            filterMovie(true);
            return;
        }
        //请求搜索
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath()%>/getMoviesBySearch?search=" + key,
            dataType: "json",
            success: function (result) {
                if (result) {
                    list = result['data'];
                    setFooter("<span style='color:#1E9FFF;font-size: 16px;'>“" + key + "”</span> 的搜索结果，共" + result['count'] + "部电影");
                    $.each(list, function (i, item) {
                        addMovieItem(item.id, item.title, item.rate);
                    })
                }
            }
        });
    }

    function filterMovie(isAll) {
        $("#div_list_container")[0].innerHTML = "";
        let filter = layui.form.val("table_selection");
        let url = "<%=request.getContextPath()%>/getAllMovies?"
        for (let key in filter) {
            url += key + "=" + filter[key] + "&";
        }
        //请求过滤
        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (result) {
                if (result) {
                    list = result['data'];
                    setFooter((isAll ? "" : "已过滤，") + "共" + result['count'] + "部电影");
                    $.each(list, function (i, item) {
                        addMovieItem(item.id, item.title, item.rate);
                    })
                }
            }
        });
    }

    function setFooter(text) {
        $("#footer")[0].innerHTML = text + "<span><br>电影评论系统 by Wanderlust</span>"
    }

    function addMovieItem(id, name, rate) {
        let movieCover = document.createElement("img");
        movieCover.src = "movie_cover/" + id + ".jpg";
        let movieCoverDiv = document.createElement("div");
        movieCoverDiv.className = "div_list_img";
        movieCoverDiv.appendChild(movieCover);
        let movieName = document.createElement("p");
        movieName.className = "p_list_movie_name";
        movieName.innerHTML =  name + "<span>" + rate + "</span>";
        let a = document.createElement("a");
        a.target="_blank";
        a.href = "movie_detail.jsp?id=" + id;
        a.appendChild(movieCoverDiv);
        a.appendChild(movieName);
        let listItem = document.createElement("div");
        listItem.className = "div_list_item";
        listItem.appendChild(a);
        document.getElementById("div_list_container").appendChild(listItem);
    }
</script>
</body>
</html>