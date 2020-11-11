<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html><head>
          <meta charset="UTF-8">
          <title>账号注册</title>
          <link rel="stylesheet" href="layui/css/layui.css" media="all">
          <script src="./layui/layui.js"></script>
          <script>
              //登录表单
              layui.use(['form', 'upload', 'jquery'], function () {
                  var form = layui.form;
                  var upload = layui.upload;
                  var $ = layui.jquery;
                  form.on('submit', function (data) {
                      layui.$.post("<%=request.getContextPath()%>/register",
                          {register_req: JSON.stringify(data.field)}, function(result) {
                      var obj = JSON.parse(result)
                      if (obj.code == 0) {
                          layer.msg(obj.msg);
                          setTimeout("toLogin()","800");
                      } else {
                          layer.msg(obj.msg);
                      }
                  });
                  return false;
              });
                  $("#exit").on("click", function () {
                      toLogin();
                  });
              });
            function toLogin() {
                location.href = "login.jsp"
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

              .outer_body {
                  width: 1200px;
                  min-height: 312px;
                  display: flex;
                  justify-content: center;
              }

              .register_box {
                  position: relative;
                  width: 400px;
                  background: #fff;
                  overflow: hidden;
                  transition: 1s;
                  box-sizing: border-box;
                  border-radius: 10px;
                  box-shadow: -10px 25px 50px rgba(0, 0, 0, 0.27);
              }

              .form_login {
                  position: absolute;
                  top: 78px;
                  left: 20px;
                  width: 360px;
                  margin: auto 0;
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
          </style>

      </head>

      <body>
      <div class="outer_body">
          <div class="register_box">
              <div class="box_content">
                  <div class="title">
                      <h2>账号注册</h2>
                  </div>
                  <form action="" method="post" name="login" class="layui-form form_login">
                      <div class="layui-form-item">
                          <div class="layui-input-inline" style="width:100%">
                              <input type="text" name="user_id" lay-verify="required" autocomplete="off"
                                     placeholder="请输入账号" class="layui-input">
                          </div>
                      </div>
                      <div class="layui-form-item">
                      <div class="layui-input-inline" style=" width:100%">
                          <input type="password" name="password" lay-verify="required" autocomplete="off"
                                 placeholder="请输入密码" class="layui-input">
                      </div>
                  </div>
                      <div class="layui-form-item">
                          <div class="layui-input-inline" style="width:100%">
                              <input type="text" name="nick_name" lay-verify="required" autocomplete="off"
                                     placeholder="请输入昵称" class="layui-input">
                          </div>
                      </div>
                      <div class="layui-form-item form_button" style="margin-top: 5px;">
                          <button class="layui-btn layui-btn-normal" lay-submit>立即注册</button>
                          <button type="button" class="layui-btn layui-btn-danger" id="exit">退出</button>
                      </div>
                  </form>
              </div>
          </div>
      </div>
      </body>
</html>