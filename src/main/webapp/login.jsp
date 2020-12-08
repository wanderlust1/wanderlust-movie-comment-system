<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="./layui/layui.js"></script>
    <script>
        //登录表单
        layui.use(['form', 'jquery'], function () {
            var form = layui.form;

            //登录按钮
            form.on('submit', function (data) {
                layui.$.post("<%=request.getContextPath()%>/login",
                   {login_req: JSON.stringify(data.field)}, function(result) {
                   var obj = JSON.parse(result)
                   if (obj.code == 0) {
                       layer.msg(obj.msg);
                       setTimeout("toIndex()","1000");
                   } else {
                       layer.msg(obj.msg);
                   }
                 });
                return false;
            });

            //注册按钮
            layui.jquery(document).on('click', '#register', function () {
                location.href = "register.jsp";
            });
        });
        function toIndex() {
            location.href = "movie_index.jsp"
        }
    </script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Century Gothic", sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(45deg, #FFFFFF, #1E9FFF);
        }

        .login_box {
            position: relative;
            width: 400px;
            height: 312px;
            background: #fcfcfc;
            overflow: hidden;
            transition: 1s;
            box-sizing: border-box;
            border-radius: 10px;
            box-shadow: -10px 25px 50px rgba(0, 0, 0, 0.27);
        }

        .form_login {
            position: absolute;
            top: 98px;
            left: 20px;
            width: 360px;
            margin: auto 0;
            overflow: hidden;
            zoom: 1;
        }

        .form_button {
            float: right;
            margin-bottom: 0;
        }

        .title {
            text-align: center;
            margin-top: 25px;
            color: #585e5a;
        }

        .tip {
            position: absolute;
            bottom: 0;
            height: 50px;
            color: #9ea8a0;
            text-align: center;
            line-height: 50px;
            width: 100%;
        }
    </style>

</head>

<body>
<div class="login_box">
    <div class="box_content">
        <div class="title">
            <h2>登录</h2>
        </div>
        <form action="" method="post" name="login" class="layui-form form_login">
            <div class="layui-form-item">
                <div class="layui-input-inline" style="width:100%">
                    <input type="text" name="user_id" lay-verify="required" autocomplete="off"
                           placeholder="请输入账号" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-inline" style="width:100%">
                    <input type="password" name="password" lay-verify="required" autocomplete="off"
                           placeholder="请输入密码" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item form_button">
                <div>
                    <button class="layui-btn layui-btn-normal" lay-submit>立即登录</button>
                    <button id="register" type="button" class="layui-btn layui-btn-primary">注册</button>
                </div>
            </div>
        </form>
        <div class="tip">
            <h4>Wanderlust</h4>
        </div>
    </div>
</div>
</body>
</html>