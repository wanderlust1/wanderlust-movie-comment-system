<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
     <meta charset="UTF-8">
     <title>用户信息管理</title>
     <link rel="stylesheet" href="layui/css/layui.css" media="all">
     <script src="./layui/layui.js"></script>

    <%
        if (session.getAttribute("user_id") == null || session.getAttribute("user_id") == "") {
            response.sendRedirect("login.jsp");
            return;
        }
        String user_id = (String) session.getAttribute("user_id");
        String nick_name = (String) session.getAttribute("nick_name");
    %>

    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            overflow-y: scroll;
        }
        .outer_body {
            width: 920px;
        }
        #user_info_edit_main {
            width: 270px;
            margin: 0 auto;
        }
        .header_box {
            height: 160px;
            width: 160px;
            margin: 20px 0 30px 90px;
            position: relative;
            border-radius: 90px;
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

        #info_edit_box {
            width: 270px;
            margin: 0 auto;
        }

        .info_single {
            margin-bottom: 10px;
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
            width:200px !important;
            position: relative;
        }
        .save_edit_button {
            visibility: hidden;
            position: absolute;
            right: -60px;
            top: 10px;
            font-size: 13px;
            font-weight: lighter;
            color: #1E9FFF;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="outer_body">
    <div id="user_info_edit_main">
        <div class="header_box">
            <img id="user_header" class="layui-nav-img" onerror="this.src = 'header/default_head.png'">
            <div id="header_edit">
                <i class="layui-icon layui-icon-edit"></i>
            </div>
        </div>
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
</div>

<script>
    layui.use(['element', 'upload'], function () {
        var element = layui.element;
        var upload = layui.upload;
        var $ = layui.$;
        $('#user_header').attr('src', 'header/<%=user_id%>.jpg' + '?h=' + Math.random())
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
                    layui.$('#user_header').attr('src', result);
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
            $("#save_nickname").css("visibility", $("#nick_name").val() === "" ? "hidden" : "visible");
        });
        $("#password").bind("input propertychange",function(){
            $("#save_password").css("visibility", $("#password").val() === "" ? "hidden" : "visible");
        });
        $("#save_nickname").on("click", function () {
            let newNickname = $("#nick_name").val();
            if (newNickname === "") return;
            modify_nickname_req = {};
            modify_nickname_req.id = '<%=user_id%>';
            modify_nickname_req.newValue = newNickname;
            $.post("<%=request.getContextPath()%>/modifyNickname", { req: JSON.stringify(modify_nickname_req)}, function(result) {
                var res = JSON.parse(result);
                if (res.code == 0) {
                    layer.msg("修改昵称成功");
                    $("#nick_name").val('');
                    $("#nick_name").attr("placeholder", newNickname);
                    $("#save_nickname").css("visibility", "hidden");
                } else {
                    layer.msg("修改昵称时出错了");
                }
            });
        });
        $("#save_password").on("click", function () {
            let newPassword = $("#password").val()
            if (newPassword === "") return;
            modify_password_req = {};
            modify_password_req.id = '<%=user_id%>';
            modify_password_req.newValue = newPassword;
            $.post("<%=request.getContextPath()%>/modifyPassword", { req: JSON.stringify(modify_password_req)}, function(result) {
                var res = JSON.parse(result)
                if (res.code == 0) {
                    layer.msg("修改密码成功");
                    $("#password").val('');
                    $("#save_password").css("visibility", "hidden");
                } else {
                    layer.msg("修改密码时出错了");
                }
            });
        });
    });
</script>
</body>
</html>