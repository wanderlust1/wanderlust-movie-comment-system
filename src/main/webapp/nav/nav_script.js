function logout(context) {
    $.ajax({
        type: "GET",
        url: context + "/logout",
        dataType: "json",
        success: function (result) {
            location.href = "login.jsp"
        }
    });
}

layui.$('#nav_logo').on('click', function () {
    layer.tips('Wanderlust', '#nav_logo', {
      tips: [3, '#1e9fff']
    });
});