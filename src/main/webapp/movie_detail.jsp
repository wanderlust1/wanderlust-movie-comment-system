<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="layui/css/layui.css" type="text/css">
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>

    <link href="nav/nav_style.css" rel="stylesheet"/>
    <script src="nav/nav_script.js"></script>

    <%
        if (session.getAttribute("user_id") == null || session.getAttribute("user_id") == "") {
            response.sendRedirect("login.jsp");
            return;
        }
        String user_id = (String) session.getAttribute("user_id");
        String nick_name = (String) session.getAttribute("nick_name");
        String header = (String) session.getAttribute("header");
    %>

    <style>
        #msg_state {
            display: inline-block;
            vertical-align: middle;
            color: #ffffff;
            font-size: 12px;
            font-weight: normal;
            font-style: normal;
            margin: -6px 8px 0;
            border-radius: 8px;
            padding: 5px;
        }

        #comment_msg_box {
            margin-top: 20px;
            margin-bottom: 20px;
            overflow: hidden;
            zoom: 1;
        }

        #comment_header {
            float: left;
            width: 206px;
            height: 300px;
        }

        #msg_header_img {
            width: 196px;
            height: 280px;
            border-radius: 8px;
            box-shadow: 10px 10px 12px #c0c0c0;
        }

        #comment_book_msg {
            float: left;
            margin-left: 8px;
            margin-top: -2px
        }

        #comment_book_msg table {
            border-collapse: separate;
            border-spacing: 0 2px;
        }

        #comment_book_msg tr {
            line-height: 30px;
            margin-bottom: 5px;
            margin-top: 5px;
        }

        .msg_hint {
            text-align: right;
            font-weight: bold;
            font-size: 14px;
        }

        .msg_data {
            font-size: 14px;
            max-width: 460px;
        }

        #movie_score_main_box {
            float: right;
            margin-right: 10px;
            padding-left: 15px;
            border-left: #e3e3e3 1px solid;
            font-size: 14px;
            color: #8D8D8D;
        }

        #movie_score_box {
            margin-top: 12px;
            overflow: hidden;
            zoom: 1;
        }

        #movie_score {
            height: 38px;
            display: inline;
            float: left;
            font-weight: normal;
            color: #ffb800;
            font-size: 30px;
            line-height: 38px;
        }

        #movie_star_box {
            float: left;
            margin-left: 14px;
        }

        #movie_display_star {
        }

        #movie_display_star ul {
            padding: 0;
        }

        #movie_display_star i {
            font-size: 16px;
        }

        #movie_score_count {
            font-size: 12px;
            text-align: center;
            margin-right: 5px;
            margin-top: 3px;
        }

        #movie_score_rate_box {
            margin-top: 10px;
            margin-left: -8px;
            border-collapse: separate;
            border-spacing: 8px 5px;
        }

        .td_rate_hint {
            font-size: 12px;
        }

        .td_rate_content {
            width: 125px;
            position: relative;
        }

        .td_rate_content .tip_text {
            visibility: hidden;
            float: right;
            background-color: rgba(0, 0, 0, 0.43);
            color: #f6f6f6;
            font-size: 12px;
            text-align: center;
            border-radius: 3px;
            padding: 3px 5px;
            position: absolute;
            right: 0px;
            top: -10px;
            z-index: 1;
         }

        .td_rate_content:hover .tip_text {
            visibility: visible;
        }

        .comment_box {
            margin-top: 20px;
            margin-left: -45px;
            margin-right: 8px;
        }

        .comment_box hr {
            margin-top: 26px;
            height: 0.5px;
        }

        .comment_box img {
            width: 50px;
            height: 50px;
            margin-top: -8px;
            border-radius: 25px;
        }

        .user_name {
            font-size: 15px;
            font-weight: bold;
            display: inline;
        }

        .comment_time {
            display: inline;
            font-size: 13px;
            line-height: 15px;
            margin-left: 15px;
            margin-right: 8px;
            color: #8f8f8f;
        }

        .comment_content {
            font-size: 14px;
            line-height: 24px;
            width: 857px;
            margin-top: 8px;
        }

        .comment_box_divide {
            margin-top: 30px;
            margin-bottom: 30px
        }

        .comment_box_divide legend {
            font-size: 15px;
            font-weight: normal;
            color: #1E9FFF;
            letter-spacing: 1px;
        }

        .comment_box i {
            color: #FFB800;
            margin-left: 3px;
        }

        .msg_desc_box {
            width: 878px;
            padding: 20px;
        }

        .msg_desc_box p {
            margin-top: -5px;
            text-indent: 2em;
        }

        .msg_desc_box legend {
            font-size: 15px;
            font-weight: normal;
            color: #1E9FFF;
            letter-spacing: 1px;
        }

        #msg_desc {
            line-height: 25px;
            font-size: 14px;
        }

        .like_box {
            float: right;
            cursor: pointer;
        }

        .like_box p {
            display: inline;
            margin-right: 3px;
            line-height: 15px;
            font-size: 15px;
            color: #FF6266;
        }

        .like_box i {
            margin-top: 13px;
            font-size: 15px;
            line-height: 15px;
            color: #FF6266;
        }
    </style>
</head>
<body>
<div class="main_body_box">
<div id="navigation" style="width: 100%; font-weight: lighter; font-family: Calibri, sans-serif"">
    <ul class="layui-nav layui-bg-black">
        <li class="layui-nav-item" id="nav_logo"><a href="javascript:">电影评论系统 by Wanderlust</a></li>
        <li class="layui-nav-item"><a href="movie_index.jsp">找电影</a></li>
        <li class="layui-nav-item" style="float: right">
            <a href="javascript:">
                <img src="header/<%=header%>.jpg" class="layui-nav-img" id="nav_header">
                <span id="nav_id" style="margin-right: 5px;"><%=nick_name%></span>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="user_detail.jsp">个人信息</a></dd>
                <dd><a href="javascript:logout('<%=request.getContextPath()%>');">退出登录</a></dd>
            </dl>
        </li>
    </ul>
</div>
<div id="comment_main_box" style="margin: 20px auto 30px; width:930px;">
    <div><h2 id="main_title" style="font-weight: bold;display: inline-block"></h2><span id="msg_state"></span></div>
    <div id="comment_msg_box">
        <div id="comment_header"><img id="msg_header_img"></div>
        <div id="comment_book_msg">
            <table>
                <tr>
                    <td class="msg_hint" valign="top">导演：</td>
                    <td id="msg_director" class="msg_data" valign="top"></td>
                </tr>
                <tr>
                    <td class="msg_hint" valign="top">演员：</td>
                    <td id="msg_actors" class="msg_data" valign="top"></td>
                </tr>
                <tr>
                    <td class="msg_hint" valign="top">分类：</td>
                    <td id="msg_type" class="msg_data" valign="top"></td>
                </tr>
                <tr>
                    <td class="msg_hint" valign="top">日期：</td>
                    <td id="msg_publish" class="msg_data" valign="top"></td>
                </tr>
                <tr>
                    <td class="msg_hint" valign="top">地区：</td>
                    <td id="msg_area" class="msg_data" valign="top"></td>
                </tr>
                <tr>
                    <td class="msg_hint" valign="top">别名：</td>
                    <td id="msg_alias" class="msg_data" valign="top"></td>
                </tr>
                <tr>
                    <td class="msg_hint" valign="top">IMDb：</td>
                    <td id="msg_imdb" class="msg_data" valign="top"></td>
                </tr>
            </table>
        </div>
        <div id="movie_score_main_box">
            <div>电影评分</div>
            <div id="movie_score_box">
                <div id="movie_score">7.8</div>
                <div id="movie_star_box">
                    <div id="movie_display_star"></div>
                    <p id="movie_score_count">15616人评分</p>
                </div>
            </div>
            <table id="movie_score_rate_box">
                <tr>
                    <td class="td_rate_hint">5星</td>
                    <td class="td_rate_content"><div class="layui-progress movie_score_rate" lay-filter="star_5">
                        <div class="layui-progress-bar layui-bg-blue" lay-percent="0%"></div>
                    </div><span class="tip_text" id="star_text_5">40%</span></td>
                </tr>
                <tr>
                    <td class="td_rate_hint">4星</td>
                    <td class="td_rate_content"><div class="layui-progress movie_score_rate" lay-filter="star_4">
                        <div class="layui-progress-bar layui-bg-blue" lay-percent="0%"></div>
                    </div><span class="tip_text" id="star_text_4">60%</span></td>
                </tr>
                <tr>
                    <td class="td_rate_hint">3星</td>
                    <td class="td_rate_content"><div class="layui-progress movie_score_rate" lay-filter="star_3">
                        <div class="layui-progress-bar layui-bg-blue" lay-percent="0%"></div>
                    </div><span class="tip_text" id="star_text_3">20%</span></td>
                </tr>
                <tr>
                    <td class="td_rate_hint">2星</td>
                    <td class="td_rate_content"><div class="layui-progress movie_score_rate" lay-filter="star_2">
                        <div class="layui-progress-bar layui-bg-blue" lay-percent="0%"></div>
                    </div><span class="tip_text" id="star_text_2">8%</span></td>
                </tr>
                <tr>
                    <td class="td_rate_hint">1星</td>
                    <td class="td_rate_content"><div class="layui-progress movie_score_rate" lay-filter="star_1">
                        <div class="layui-progress-bar layui-bg-blue" lay-percent="0%"></div>
                    </div><span class="tip_text" id="star_text_1">100%</span></td>
                </tr>
            </table>
        </div>
    </div>

    <fieldset class="layui-elem-field msg_desc_box" style="margin: 25px 0 30px;">
        <legend>电影简介</legend>
        <p id="msg_desc"></fieldset>

    <fieldset class="layui-elem-field layui-field-title comment_box_divide" style="width: 920px;">
        <legend>我的影评</legend>
    </fieldset>

    <div>
        <form action="" method="post" name="book_comment" class="layui-form" style="margin-left: -40px">
            <div class="layui-form-item">
                <label class="layui-form-label">电影评分</label>
                <div class="layui-input-block">
                    <div id="comment_score" style="margin-top: -3px"></div>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">电影评价</label>
                <div class="layui-input-inline">
                        <textarea placeholder="输入简短的文本评价一下这部电影吧" class="layui-textarea" name="content"
                                  style="width:850px;height: 120px" id="comment_content_text"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit style="float:right;margin-right:10px;">发布影评</button>
                </div>
            </div>
        </form>
    </div>

    <fieldset class="layui-elem-field layui-field-title comment_box_divide" style="width: 920px;">
        <legend id="msg_comments_num">此电影暂无影评</legend>
    </fieldset>
    <div id="comment_review"></div>
</div>
</div>

<script>
    let user_id = "<%= user_id %>";
    let nick_name = "<%= nick_name %>";
    let movie_id = getSearch("id")
    getCommentList();

    //layui配置
    layui.use(['element', 'rate', 'form'], function () {
        var element = layui.element;
        layui.element.init();
        //评分
        var rate = layui.rate;
        var star = rate.render({
            elem: '#comment_score',
            value: 5,
            text: true
        });

        //电影评分表单
        var form = layui.form;
        form.on('submit', function (data) {
            var add_comment_req = data.field;
            add_comment_req.id = randomString(9);
            add_comment_req.movie_id = getSearch("id");
            add_comment_req.rate = star.config.value;
            add_comment_req.time = getDate();
            add_comment_req.count = "0"
            add_comment_req.user_id = user_id;
            add_comment_req.username = nick_name;
            if ($.trim(data.field.content) !== "") {
                layui.$.post("<%=request.getContextPath()%>/addComment", {add_comment_req: JSON.stringify(add_comment_req)}, function(result) {
                    var obj = JSON.parse(result)
                    if (obj.code == 0) {
                        layer.msg("已发布您的评论");
                        getCommentList();
                        var count = parseInt($("#movie_score_count")[0].innerHTML.replace("人评分", ""));
                        $("#movie_score_count")[0].innerHTML = (count + 1) + "人评分";
                        $("#comment_content_text").val('');
                    } else {
                        layer.msg("发布评论失败");
                    }
                });
            } else {
                layer.tips("评论内容不能为空", $(this));
            }
            return false;
        });
    });

    //获取电影详细信息
    $.ajax({
        type: "GET",
        url: "<%=request.getContextPath()%>/getMovieDetailById?id=" + movie_id,
        dataType: "json",
        success: function (result) {
            if (result) {
                var data = result['data'];
                document.title = data['movieName'] + " - 影评";
                $("#main_title")[0].innerHTML = data['movieName'];
                $("#msg_publish")[0].innerHTML = splitText(data['movieDate']);
                $("#msg_director")[0].innerHTML = data['director'];
                $("#msg_type")[0].innerHTML = splitText(data['movieType']);
                $("#msg_area")[0].innerHTML = splitText(data['movieArea']) + " / " + splitText(data['movieLang']);
                $("#msg_imdb")[0].innerHTML = data['movieIMDb'];
                $("#msg_actors")[0].innerHTML = splitText(data['actors']);
                $("#msg_alias")[0].innerHTML = splitText(data['movieAlias'])
                $("#msg_desc")[0].innerHTML = data['movieDesc'].replaceAll("　　", "<br>　　");
                $("#msg_header_img")[0].src = "movie_cover/" + data['movieId'] + ".jpg";
                $("#movie_score")[0].innerHTML = data['rate'];
                $("#movie_score_count")[0].innerHTML = data['rateCount'] + "人评分";
                layui.rate.render({
                    elem: '#movie_display_star',
                    value: (parseFloat(data['rate']) / 2),
                    readonly: true,
                    half: true
                });
                var percent = [];
                data['ratePer'].split("/").forEach(function (value, index, array) {
                    percent[index] = value.substr(3);
                });
                layui.element.progress('star_5', percent[0]);
                $("#star_text_5")[0].innerHTML = percent[0];
                layui.element.progress('star_4', percent[1]);
                $("#star_text_4")[0].innerHTML = percent[1];
                layui.element.progress('star_3', percent[2]);
                $("#star_text_3")[0].innerHTML = percent[2];
                layui.element.progress('star_2', percent[3]);
                $("#star_text_2")[0].innerHTML = percent[3];
                layui.element.progress('star_1', percent[4]);
                $("#star_text_1")[0].innerHTML = percent[4];
            }
        }
    });

    function getCommentList() {
        //获取评论
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath()%>/getCommentByMovieId?movie_id=" + movie_id + "&user_id=" + user_id,
            dataType: "json",
            success: function (result) {
                if (result) {
                    $("#msg_comments_num")[0].innerHTML = result['count'] === 0 ? "此电影暂无影评" : "共" + result['count'] + "条影评";
                    var comments = result['data'];
                    document.getElementById("comment_review").innerHTML = "";;
                    $.each(comments, function (i, obj) {
                        appendComment(
                            obj['id'],
                            obj['username'],
                            obj['time'],
                            obj['content'],
                            ("header/" + obj['header'] + ".jpg"),
                            Math.floor(obj['rate']),
                            obj['count'],
                            obj['is_like']
                        );
                    })
                }
            }
        });
    }

    function appendComment(id, msg_username, msg_time, msg_content, msg_header, msg_star, msg_like, is_like) {
        //评论用户
        var name = document.createElement("h4");
        name.className = "user_name";
        name.innerHTML = msg_username.replaceAll("?", "");

        //评论用户头像
        var header = document.createElement("img");
        header.src = msg_header;
        header.onerror = function(event) {
            header.src = 'header/default_head.png'
        }

        //评论内容
        var content = document.createElement("p");
        content.className = "comment_content";
        content.innerHTML = msg_content;

        //评论时间
        var time = document.createElement("p");
        time.className = "comment_time";
        time.innerHTML = msg_time;

        //点赞
        var likeText = document.createElement("p");
        likeText.innerHTML = msg_like;
        var likeIcon = document.createElement("i");
        likeIcon.className = is_like ? "layui-icon layui-icon-heart-fill" : "layui-icon layui-icon-heart";
        var likeBox = document.createElement("div");
        likeBox.className = "like_box";
        likeBox.appendChild(likeText);
        likeBox.appendChild(likeIcon);
        likeIcon.addEventListener("click", function (e) {
            e.preventDefault();
            var like_req = {};
            like_req.comment_id = id;
            like_req.user_id = user_id;
            like_req.like_code = likeIcon.className === "layui-icon layui-icon-heart" ?  10 : 11 ; //like_code: 10为点赞，11为取消点赞
            layui.$.post("<%=request.getContextPath()%>/setCommentLike", {like_req: JSON.stringify(like_req)}, function(result) {
                var res = JSON.parse(result);
                if (res.result_code === 0) {
                    likeIcon.className = like_req.like_code === 10
                        ? "layui-icon layui-icon-heart-fill"
                        : "layui-icon layui-icon-heart";
                    var num = parseInt(likeText.innerHTML);
                    likeText.innerHTML = like_req.like_code === 10 ? num + 1 : num - 1
                    layer.msg(like_req.like_code === 10 ? "点赞成功" : "已取消");
                } else {
                    layer.msg("出错了");
                }
            });
        }, false);
        //评论内容区域
        var msgBox = document.createElement("div");
        msgBox.className = "layui-input-block";
        msgBox.appendChild(name);
        msgBox.appendChild(time);
        msgBox.appendChild(likeBox);

        //星星
        for (let j = 0; j < msg_star; j++) {
            var starFull = document.createElement("i");
            starFull.className = "layui-icon layui-icon-rate-solid";
            msgBox.appendChild(starFull);
        }
        if (msg_star !== 5) {
            for (let i = 0; i < (5 - msg_star); i++) {
                var starEmpty = document.createElement("i");
                starEmpty.className = "layui-icon layui-icon-rate";
                msgBox.appendChild(starEmpty);
            }
        }
        msgBox.appendChild(content);
        msgBox.appendChild(document.createElement("hr"))

        //头像框
        var headerBox = document.createElement("label");
        headerBox.className = "layui-form-label";
        headerBox.appendChild(header);

        //评论BOX主布局
        var divMain = document.createElement("div");
        divMain.className = "layui-form-item comment_box";
        divMain.appendChild(headerBox);
        divMain.appendChild(msgBox);

        //放入评论列表
        document.getElementById("comment_review").prepend(divMain);
    }

    function splitText(origin) {
        const list = origin.split("/");
        let text = "";
        for (let i = 0; i < list.length; i++) {
            let temp = text + list[i]
            if (temp.length > 130) {
                text += "等";
                break;
            } else if (i === list.length - 1) {
                text = temp;
            } else {
                text = temp + " / ";
            }
        }
        return text;
    }

    function getSearch(key) {
        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return (r[2]);
        }
        return null;
    }

    function getDate() {
        var now = new Date();
        return now.getFullYear() + "/" + (now.getMonth() + 1) + "/" + now.getDate() + " "
            + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
    }

    function randomString(len) {
        len = len || 32;
        var $chars = "0123456789";
        var maxPos = $chars.length;
        var pwd = '';
        for (let i = 0; i < len; i++) {
            pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
        }
        return pwd;
    }
</script>
</body>
</html>