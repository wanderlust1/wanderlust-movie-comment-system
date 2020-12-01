<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="layui/css/layui.css" type="text/css">
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
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

        body {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #comment_msg_box {
            margin-top: 20px;
            margin-bottom: 20px;
            height: 300px;
            overflow: hidden;
            zoom: 1;
        }

        #comment_header {
            float: left;
            width: 196px;
            height: 275px;
        }

        #msg_header_img {
            width: 100%;
            height: 100%;
            border-radius: 10px;
            box-shadow: 8px 8px 10px #c0c0c0;
        }

        #comment_book_msg {
            float: left;
            margin-left: 20px;
        }

        #comment_book_msg tr {
            line-height: 40px;
        }

        .msg_hint {
            text-align: right;
            font-weight: bold;
            font-size: 15px;
        }

        .msg_data {
            font-size: 15px;
        }

        .comment_box {
            margin-top: 40px;
            margin-left: -45px
        }

        .comment_box img {
            width: 50px;
            height: 50px;
            margin-top: -8px;
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
            width: 850px;
            margin-top: 8px;
        }

        .comment_box_divide {
            margin-top: 30px;
            margin-bottom: 30px
        }

        .comment_box_divide legend {
            font-size: 15px;
            font-weight: bold;
            color: #1E9FFF;
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
            text-indent:2em;
        }

        .msg_desc_box legend {
            font-size: 18px;
            font-weight: 500;
        }
        #msg_desc {
            line-height: 25px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="main_body_box">
        <!-- 内容主体区域 -->
        <div id="comment_main_box" style="margin: 20px 0 30px 0;">
            <div><h2 id="main_title" style="font-weight: bold;display: inline-block"></h2><span id="msg_state"></span></div>
            <div id="comment_msg_box">
                <div id="comment_header">
                    <img id="msg_header_img" style="width: 100%;height: 100%">
                </div>
                <div id="comment_book_msg">
                    <table>
                        <tr>
                            <td class="msg_hint">导演：</td>
                            <td id="msg_director" class="msg_data"></td>
                        </tr>
                        <tr>
                            <td class="msg_hint">演员：</td>
                            <td id="msg_actors" class="msg_data"></td>
                        </tr>
                        <tr>
                            <td class="msg_hint">电影分类：</td>
                            <td id="msg_type" class="msg_data"></td>
                        </tr>
                        <tr>
                            <td class="msg_hint">上映日期：</td>
                            <td id="msg_publish" class="msg_data"></td>
                        </tr>
                        <tr>
                            <td class="msg_hint">地区语言：</td>
                            <td id="msg_area" class="msg_data"></td>
                        </tr>
                        <tr>
                            <td class="msg_hint">别名：</td>
                            <td id="msg_alias" class="msg_data"></td>
                        </tr>
                        <tr>
                            <td class="msg_hint">IMDb：</td>
                            <td id="msg_imdb" class="msg_data"></td>
                        </tr>
                    </table>
                </div>
            </div>

            <fieldset class="layui-elem-field msg_desc_box" style="margin: 40px 0 30px;">
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
                                <textarea placeholder="输入简短的文本评价一下这部电影吧" class="layui-textarea" name="comment_desc"
                                          style="width:850px;height: 120px"></textarea>
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
</div>

<script>
    //获取电影详细信息
    $.ajax({
        type: "GET",
        url: "<%=request.getContextPath()%>/getMovieDetailById?id=" + getSearch("id"),
        dataType: "json",
        success: function (result) {
            if (result) {
                var data = result['data'];
                document.title = data['movieName'] + " - 影评";
                $("#main_title")[0].innerHTML = data['movieName'];
                $("#msg_publish")[0].innerHTML = data['movieDate'];
                $("#msg_director")[0].innerHTML = data['director'];
                $("#msg_type")[0].innerHTML = splitText(data['movieType']);
                $("#msg_area")[0].innerHTML = data['movieArea'] + " / " + data['movieLang'];
                $("#msg_imdb")[0].innerHTML = data['movieIMDb'];
                $("#msg_actors")[0].innerHTML = splitText(data['actors']);
                $("#msg_alias")[0].innerHTML = splitText(data['movieAlias'])
                $("#msg_desc")[0].innerHTML = data['movieDesc'].replaceAll("　　", "<br>　　");
                $("#msg_header_img")[0].src = "movie_cover/" + data['movieId'] + ".jpg";
                /*var book = result['book'];
                Book_id = book['book_id'];
                Book_Name = book['book_name'];
                $("#msg_state")[0].innerHTML = book['book_flag'] === 1 ? "上架中" : "已下架";
                if (book['book_flag'] === 1) {
                    $("#msg_state")[0].style = "background: #1E9FFF;";
                } else {
                    $("#msg_state")[0].style = "background: #ff5459;";
                }
                var comments = result['comments'];
                $.each(comments, function (i, obj) {
                    appendComment(
                        obj['user_name'],
                        obj['com_time'],
                        obj['com_words'],
                        ("images/user/" + obj['user_id'] + ".jpg"),
                        Math.floor(obj['com_star'] / 2)
                    );
                })*/
            }
        }
    });

    //获取评论
    $.ajax({
        type: "GET",
        url: "<%=request.getContextPath()%>/getCommentByMovieId?id=" + getSearch("id"),
        dataType: "json",
        success: function (result) {
            if (result) {
                $("#msg_comments_num")[0].innerHTML = result['count'] === 0 ? "此电影暂无影评" : "共" + result['count'] + "条影评";
                var comments = result['data'];
                $.each(comments, function (i, obj) {
                    appendComment(
                        obj['username'],
                        obj['time'],
                        obj['content'],
                        ("images/user/" + obj['user_id'] + ".jpg"),
                        Math.floor(obj['rate'])
                    );
                })
            }
        }
    });
    layui.use(['element', 'rate', 'form'], function () {
        var element = layui.element;

        //评分
        var rate = layui.rate;
        var star = rate.render({
            elem: '#comment_score',  //绑定元素
            value: 5,
            text: true
        });

        //电影评分表单
        var form = layui.form;
        form.on('submit', function (data) {
            var result = data.field;
            result.comment_id = randomString(9);
            //result.Book_id = Book_id;
            //result.Book_name = Book_Name;
            result.score = star.config.value;
            result.time = getDate();
            //result.User_id = User_id;
            //result.User_name = User_name;
            if ($.trim(data.field.comment_desc) !== "") {
                /*$.ajax({
                    url: "addComment.do",
                    method: 'post',
                    data: JSON.stringify(result),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        if (data['insert'] === 1) {
                            var obj = data['result'];
                            layer.msg("已发布您的评论");
                            appendComment(
                                obj['user_name'],
                                obj['com_time'],
                                obj['com_words'],
                                ("images/user/" + obj['user_id'] + ".jpg"),
                                Math.floor(obj['com_star'] / 2)
                            );
                        } else {
                            layer.msg("发布评论失败");
                        }
                    },
                    error: function () {
                        console.log("ajax error");
                    }
                });*/
            } else {
                layer.tips("评论内容不能为空", $(this));
            }
            return false;
        });
    });

    function appendComment(msg_username, msg_time, msg_content, msg_header, msg_star) {
        //评论用户
        var name = document.createElement("h4");
        name.className = "user_name";
        name.innerHTML = msg_username.replaceAll("?", "");

        //评论用户头像
        var header = document.createElement("img");
        //header.src = msg_header;

        //评论内容
        var content = document.createElement("p");
        content.className = "comment_content";
        content.innerHTML = msg_content;

        //评论时间
        var time = document.createElement("p");
        time.className = "comment_time";
        time.innerHTML = msg_time;


        //评论内容区域
        var msgBox = document.createElement("div");
        msgBox.className = "layui-input-block";
        msgBox.appendChild(name);
        msgBox.appendChild(time)

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
            if (temp.length > 50) {
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
        return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" +
            now.getDate() + " " + now.getHours() + ":" + now.getMinutes();
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