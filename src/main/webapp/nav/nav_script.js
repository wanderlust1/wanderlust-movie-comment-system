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