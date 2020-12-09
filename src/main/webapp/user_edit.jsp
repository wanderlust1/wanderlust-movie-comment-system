<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
     <meta charset="UTF-8">
     <title>用户信息管理</title>
     <link rel="stylesheet" href="layui/css/layui.css" media="all">
     <script src="./layui/layui.js"></script>

     <style>

        .top_box {
            margin-bottom: 30px;
        }

        .header_box {
            height: 80px;
            width: 80px;
            margin-left: 15px;
            float: left;
        }

        .name_box {
            float: left;
            margin-left: 15px;
            margin-top: 10px;
        }

        #user_header {
            height: 100%;
            width: 100%;
        }

        #user_name {
            height: 30px;
            width: 120px;
            font-size: 16px;
            margin-bottom: 5px;
        }

        .name_box h5 {
            margin-left: 10px;
            color: #828a84;
        }

        .button_group {
            width: 350px;
        }

        .button_group button {
            margin-left: 12px;
            float: right;
        }
     </style>

     </head>

<body>
<div class="outer_body">

    <div style="padding: 15px;">
        <form action="" method="post" name="book editing" class="layui-form layui-form-pane">
            <div class="layui-form-item top_box">
                <div class="header_box">
                    <img id="user_header" class="layui-nav-img" src="def_header_dark.png">
                </div>
                <div class="name_box">
                    <input type="text" id="user_name" name="id" placeholder="用户名" class="layui-input">
                    <h5>UID: 02</h5>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-inline" style="width:350px">
                        <input type="password" name="password" autocomplete="off"
                               placeholder="密码" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-inline" style="width:350px">
                        <input type="text" id="date_select" name="email" autocomplete="off"
                               placeholder="邮箱地址" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">电话</label>
                    <div class="layui-input-inline" style="width:350px">
                        <input type="text" name="phone" autocomplete="off" placeholder="电话号码"
                               class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block button_group">
                    <button class="layui-btn layui-btn-primary" type="reset">重置</button>
                    <button class="layui-btn layui-btn-normal" lay-submit>提交修改</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    layui.use(['element', 'form', 'upload'], function () {
        var element = layui.element;
        var form = layui.form;
        form.on('submit', function (data) {
            layer.alert(JSON.stringify(data.field));
            return false;
        });
        var upload = layui.upload;
        upload.render({
            elem: '#user_header' //绑定元素
            , url: '<%=request.getContextPath()%>/uploadHeader' //上传接口
            , accept: 'images'
            , data: {
                user_id: "123",
            }
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    console.log(index);
                    console.log(file);
                    console.log(result);
                    layui.$('#user_header').attr('src', result); //图片链接（base64）
                });
                layer.load(); //上传loading
            }
            ,done: function(res, index, upload){
              layer.closeAll('loading'); //关闭loading
            }
            ,error: function(index, upload){
              layer.closeAll('loading'); //关闭loading
            }
        });
    });
</script>
</body>
</html>