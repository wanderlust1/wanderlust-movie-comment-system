<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <link href="layui/css/layui.css" rel="stylesheet"/>
    <script src="layui/layui.js"></script>
    <title>查询系统</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        .top {
            margin-top: 30px;
            margin-bottom: 10px;
        }
        #table-demo {
            display: block;
        }
        #search_box button {
            margin-left: 5px;
            height: 32px;
            line-height: 32px;
        }
        #search_box input {
            width:300px;
            height: 32px;
            line-height: 32px;
        }
    </style>
    <script>
    layui.use(['table', 'element', 'layer'], function () {
            var element = layui.element;
            var table = layui.table;
            table.render({
                elem: '#table-demo'
                , url: '<%=request.getContextPath()%>/getAllMovies'
                , cols: [[
                    {field: 'id', width: 300, align: 'center', title: 'ID'},
                    {field: 'title', width: 500, align: 'center', title: '电影名称'},
                    {field: 'rate', width: 126, align: 'center', title: '评分'}
                ]]
            });
            table.on('row(table)', function(obj){
                window.open("movie_detail.jsp?id=" + obj.data.id);
            });
            //按钮事件
            layui.$('.layui-btn').on('click', function () {
                var search = layui.$('#input').val()
                var url1 = '<%=request.getContextPath()%>/getAllMovies'
                if (search != '') {
                     url1 = '<%=request.getContextPath()%>/getMoviesBySearch?search=' + search
                }
                table.reload('table-demo', { url: url1 });
            });
        });
    </script>
</head>
<body>
    <div class="main">
    <div class="top">
        <div id="search_box">
            <div class="layui-inline">
                <div class="layui-input-inline edit_input_div">
                    <input type="text" name="Book_num" autocomplete="off" placeholder="请输入电影名称、ID等关键字..."
                           class="layui-input" id="input">
                </div>
            </div>
            <div class="layui-inline">
                <div class="layui-input-inline edit_input_div">
                    <button id="search" data-type="search" class="layui-btn layui-btn-normal">查询</button>
                </div>
            </div>
        </div>
    </div>
    <div><table id="table-demo" lay-filter="table"></table></div>
</body>
</html>