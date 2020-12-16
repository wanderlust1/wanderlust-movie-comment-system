<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="./layui/layui.js"></script>
    <script src="js/jquery-2.1.3.min.js"></script>

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
    <title><%=nick_name%> - 个人信息</title>

    <style>
        body {
            overflow-y: scroll;
        }
        .outer_body {
            margin: 0 auto;
            width: 840px;
            position: relative;
        }
        #user_info_edit_main {
            width: 260px;
            position: absolute;
            left: -280px;
        }
        .header_box {
            height: 190px;
            width: 190px;
            margin: 0 auto 15px;
            position: relative;
            border-radius: 95px;
            box-shadow: 0 3px 6px rgba(149, 157, 165, 0.65);
        }
        #header_edit {
            width: 30px;
            height: 30px;
            position: absolute;
            bottom: 8px;
            right: 8px;
            background-color: #fff;
            border: 1px solid #e1e4e8;
            border-radius: 2em;
            box-shadow: 0 3px 6px rgba(149, 157, 165, 0.15);
            cursor: pointer;
        }
        #header_edit i {
            display: block;
            height: 30px;
            width: 30px;
            font-size: 18px;
            line-height: 30px;
            text-align: center;
        }
        #user_header {
            height: 100%;
            width: 100%;
        }

        #user_statistics {
            text-align: center;
            margin-bottom: 20px;
            font-size: 15px;
            font-weight: lighter;
            font-family: Calibri, sans-serif;
        }
        #stat_yp {
            color: #8D8BFF;
            margin-right: 10px;
        }
        #stat_hz {
            color: #FF6266;
        }
        #user_statistics i {
            margin-right: 5px;
        }

        #info_edit_box {
            width: 230px;
            margin: 0 auto;
        }

        .info_single {
            margin-top: 10px;
        }
        .info_label {
            width: 70px;
            float: left;
            height: 36px;
            line-height: 36px;
            font-weight: lighter;
        }
        .info_label i {
            margin-right: 13px;
        }
        .info_content {
            width:160px !important;
            position: relative;
        }
        .save_edit_button {
            display: none;
            float: right;
            width: 48px;
            font-size: 11px;
            font-weight: lighter;
            color: #FFF;
            cursor: pointer;
            background: #1E9FFF;
            border-radius: 4px;
            padding: 2px 10px;
            line-height: 20px;
            margin-top: 5px;
        }
        .layui-input {
            height: 28px !important;
            font-family: Calibri, sans-serif !important;
        }
        .info_label {
            height: 26px !important;
            line-height: 26px !important;
        }

        .layui-tab {
            margin-top: 20px;
        }
        .layui-timeline-axis {
            color: #1E9FFF !important;
        }
        .span_special {
            color: #1E9FFF;
            margin-left: 4px;
            margin-right: 4px;
            font-weight: lighter !important;
            font-family: Calibri, sans-serif;
        }
        .like_record_single_box {
            overflow: hidden;
            zoom: 1;
        }
        .like_record_header_div {
            float: left;
            width: 50px;
            height: 50px;
        }
        .like_record_header {
            width: 100%;
            height: 100%;
            border-radius: 25px;
        }
        .like_record_content {
            width: 750px;
            float: right;
        }
        .record_rate {
            margin-bottom: 8px;
            font-size: 15px;
            font-weight: 500;
            color: #FFB800;
        }
        .rate_box i {
            color: #FFB800;
            margin-right: 3px;
        }
        .record_content {
            font-size: 14px;
            line-height: 24px;
            color: #8D8D8D;
        }
        .comment_list_item:before {
            visibility: visible;
        }
        .comment_list_item_empty:before {
            visibility: hidden;
        }
        .comment_item_hz {
            color: #FF6266 !important;
            margin-left: 10px !important;
            margin-right: 10px !important;
            font-size: 14px !important;
            font-family: Calibri, sans-serif;
        }
        .like_list_item:before {
            visibility: visible;
        }
        .like_list_item_empty:before {
            visibility: hidden;
        }
        .delete_comment {
            display: none;
            vertical-align: top;
            text-decoration: none;
            color: #FFF !important;
            font-size: 11px;
            font-weight: lighter;
            background: #FF6266;
            border-radius: 4px;
            padding: 4px 8px;
            margin-left: 10px;
        }
        .comment_list_item:hover .delete_comment {
            display: inline;
        }
        .layui-tab-brief>.layui-tab-title .layui-this:after {
             border: none;
             border-radius: 0;
             border-bottom: 2px solid #1E9FFF;
         }
         .layui-tab-brief>.layui-tab-title .layui-this {
             color: #1e9fff;
         }
         .layui-tab-title li {
             font-size: 17px;
             font-weight: lighter;
         }
    </style>
</head>
<body>

<div id="navigation" style="width: 100%; font-weight: lighter; font-family: Calibri, sans-serif">
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
<div class="outer_body">
    <div id="user_info_edit_main">
        <div class="header_box">
            <img id="user_header" class="layui-nav-img" onerror="this.src = 'header/default_head.png'">
            <div id="header_edit">
                <i class="layui-icon layui-icon-edit"></i>
            </div>
        </div>
        <p id="user_statistics">
            <span id="stat_yp"><i class="layui-icon layui-icon-read"></i>影评 0</span>
            <span id="stat_hz"><i class="layui-icon layui-icon-heart"></i>获赞 0</span>
        </p>
        <div id="info_edit_box">
            <div class="info_single">
                <div class="info_label"><i class="layui-icon layui-icon-username"></i>账号</div>
                <div class="layui-input-inline info_content">
                    <input type="password" name="password" autocomplete="off" class="layui-input" disabled placeholder="<%=user_id%>">
                </div>
            </div>
            <div class="info_single">
                <div class="info_label"><i class="layui-icon layui-icon-face-smile"></i>昵称</div>
                <div class="layui-input-inline info_content">
                    <input type="text" id="nick_name" name="email" autocomplete="off" placeholder="<%=nick_name%>" class="layui-input">
                    <div class="save_edit_button" id="save_nickname">保存修改</div>
                </div>
            </div>
            <div class="info_single">
                <div class="info_label"><i class="layui-icon layui-icon-password"></i>密码</div>
                <div class="layui-input-inline info_content">
                    <input type="text" id="password" name="email" autocomplete="off" placeholder="******" class="layui-input">
                    <div class="save_edit_button" id="save_password">保存修改</div>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="content_tab">
      <ul class="layui-tab-title">
        <li class="layui-this">我发布的影评</li>
        <li>我的点赞记录</li>
        <li>收藏夹</li>
      </ul>
      <div class="layui-tab-content"></div>
    </div>
    <div class="like_record_box">
        <ul class="layui-timeline" id="list_like_record"></ul>
    </div>
    <div class="comment_record_box">
        <ul class="layui-timeline" id="list_comment_record"></ul>
    </div>
</div>

<script>
    layui.use(['element', 'upload'], function () {
        var element = layui.element;
        var upload = layui.upload;
        var $ = layui.$;
        $('#user_header').attr('src', 'header/<%=header%>.jpg')
        upload.render({
            elem: '#header_edit'
            , url: '<%=request.getContextPath()%>/uploadHeader'
            , accept: 'images'
            , data: {
                user_id: "<%=user_id%>",
                req_id: Math.random(),
            }
            , before: function (obj) {
                obj.preview(function (index, file, result) {
                    $('#user_header').attr('src', result);
                    $('#nav_header').attr('src', result);
                });
                layer.load();
            }
            , done: function (res, index, upload) {
                layer.closeAll('loading');
                layer.msg("已更新头像");
            }
            , error: function (index, upload) {
                layer.closeAll('loading');
                layer.msg("修改头像时出错了");
            }
        });
        $("#nick_name").bind("input propertychange",function(){
            $("#save_nickname").css("display", $("#nick_name").val() === "" ? "none" : "block");
        });
        $("#password").bind("input propertychange",function(){
            $("#save_password").css("display", $("#password").val() === "" ? "none" : "block");
        });
        $("#save_nickname").on("click", function () {
            let newNickname = $("#nick_name").val();
            if (newNickname === "") return;
            const modify_nickname_req = {};
            modify_nickname_req.id = '<%=user_id%>';
            modify_nickname_req.newValue = newNickname;
            $.post("<%=request.getContextPath()%>/modifyNickname", { req: JSON.stringify(modify_nickname_req)}, function(result) {
                var res = JSON.parse(result);
                if (res.code == 0) {
                    layer.tips("修改昵称成功", '#nick_name', {
                        tips: [2, '#1E9FFF']
                    });
                    $("#nick_name").val('');
                    $("#nick_name").attr("placeholder", newNickname);
                    document.title = newNickname + ' - 个人信息';
                    $("#nav_id")[0].innerHTML = newNickname;
                    $("#save_nickname").css("display", "none");
                } else {
                    layer.tips("修改昵称时出错了", '#nick_name', {
                        tips: [2, '#1E9FFF']
                    });
                }
            });
        });
        $("#save_password").on("click", function () {
            let newPassword = $("#password").val()
            if (newPassword === "") return;
            const modify_password_req = {};
            modify_password_req.id = '<%=user_id%>';
            modify_password_req.newValue = newPassword;
            $.post("<%=request.getContextPath()%>/modifyPassword", { req: JSON.stringify(modify_password_req)}, function(result) {
                var res = JSON.parse(result)
                if (res.code == 0) {
                    layer.tips("修改密码成功", '#password', {
                        tips: [2, '#1E9FFF']
                    });
                    $("#password").val('');
                    $("#save_password").css("display", "none");
                } else {
                    layer.tips("修改密码时出错了", '#password', {
                        tips: [2, '#1E9FFF']
                    });
                }
            });
        });

        element.on('tab(content_tab)', function(data){
            $('.comment_record_box').css("display", data.index === 0 ? "block" : "none");
            $('.like_record_box').css("display", data.index === 1 ?  "block" : "none");
        });
        getCommentRecord();
        setTimeout("getLikeRecord()","200");
        $('.comment_record_box').css("display", "block");
        $('.like_record_box').css("display", "none");
    });

    addCommentEmptyRecord();
    addLikeEmptyRecord();

    //请求评论记录
    function getCommentRecord() {
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath()%>/getCommentRecordById?id=" + "<%=user_id%>",
            dataType: "json",
            success: function (result) {
                let likeCount = 0;
                $('#list_comment_record')[0].innerHTML = "";
                if (result && result['count'] > 0) {
                    $.each(result['list'], function (i, item) {
                        likeCount += Number(item.count);
                        addCommentRecord(item.time, item.movie_name, item.movie_id, item.content, Number(item.rate), item.id, Number(item.count));
                    })
                } else {
                    addCommentEmptyRecord();
                }
                $('#stat_yp')[0].innerHTML = "<i class='layui-icon layui-icon-read'></i>影评 " + result['count'];
                $('#stat_hz')[0].innerHTML = "<i class='layui-icon layui-icon-heart'></i>获赞 " + likeCount;
            }
        });
    }

    //请求点赞记录
    function getLikeRecord() {
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath()%>/getLikeRecordById?id=" + "<%=user_id%>",
            dataType: "json",
            success: function (result) {
                $('#list_like_record')[0].innerHTML = "";
                if (result && result['count'] > 0) {
                    $.each(result['list'], function (i, item) {
                        addLikeRecord(item.time, item.name, item.header, item.movie_name, item.movie_id, item.content, item.rate)
                    })
                } else {
                    addLikeEmptyRecord();
                }
            }
        });
    }

    //删除评论
    function deleteComment(commentId) {
        $.post("<%=request.getContextPath()%>/deleteComment", {id: commentId}, function(result) {
            var res = JSON.parse(result)
            if (res.code == 0) {
                layer.msg("评论已删除");
                getCommentRecord();
            } else {
                layer.msg("出错了");
            }
        });
    }

    function addCommentRecord(time, movieName, movieId, content, score, id, likeCount) {
        $("<li class='layui-timeline-item comment_list_item'><i class='layui-icon layui-timeline-axis'>&#xe63f;</i><div class='layui-timeline-content layui-text'>"
            + "<h3 class='layui-timeline-title'><span class='span_special'>" + time + "</span>在"
            + "<span class='span_special'><a target='_blank' href='movie_detail.jsp?id=" + movieId + "'>" + movieName + "</a></span>下发布了影评"
            + "<a class='delete_comment' href='javascript:deleteComment(\"" + id + "\");'><span>删除</span></a></h3>"
            + "<div class='record_rate rate_box'>我的评分："
            + "<i class='layui-icon layui-icon-rate" + (score >= 1 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 2 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 3 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 4 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 5 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-heart-fill comment_item_hz'>  " + likeCount + "</i></div>"
            + "<p class='record_content'>" + content + "</p></div></li>"
        ).prependTo($('#list_comment_record'));
    }

    function addLikeRecord(time, userName, userHeader, movieName, movieId, content, score) {
        $("<li class='layui-timeline-item like_list_item'><i class='layui-icon layui-timeline-axis'>&#xe63f;</i><div class='layui-timeline-content layui-text'>"
            + "<h3 class='layui-timeline-title'><span class='span_special'>" + time + "</span>点赞了"
            + "<span class='span_special'>" + userName + "</span>在<span class='span_special'>"
            + "<a target='_blank' href='movie_detail.jsp?id=" + movieId + "'>" + movieName + "</a></span>中的影评</h3>"
            + "<div class='like_record_single_box'>"
            + "<div class='like_record_header_div'><img class='like_record_header' src='header/" + userHeader + ".jpg' onerror='this.src = \"header/default_head.png\"'></div>"
            + "<div class='like_record_content'>"
            + "<div class='record_rate rate_box'>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 1 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 2 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 3 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 4 ? "-solid'" : "") + "'></i>"
            + "<i class='layui-icon layui-icon-rate" + (score >= 5 ? "-solid'" : "") + "'></i></div>"
            + "<p class='record_content'>" + content + "</p></div></div></div></li>"
        ).prependTo($('#list_like_record'))
    }

    function addCommentEmptyRecord() {
        $("<li class='layui-timeline-item comment_list_item_empty'><i class='layui-icon layui-timeline-axis'>&#xe63f;</i>"
            + "<div class='layui-timeline-content layui-text'>"
            + "<div class='layui-timeline-title'>暂时没有发布影评...</div></div></li>"
        ).prependTo($('#list_comment_record'))
    }

    function addLikeEmptyRecord() {
        $("<li class='layui-timeline-item like_list_item_empty'><i class='layui-icon layui-timeline-axis'>&#xe63f;</i>"
            + "<div class='layui-timeline-content layui-text'>"
            + "<div class='layui-timeline-title'>暂时没有点赞记录...</div></div></li>"
        ).prependTo($('#list_like_record'))
    }
</script>
</body>
</html>