(function () {
    $("#signInModal .signInButton").click(function () {
        var username = $("#signInModal .usernameInput").val();
        var password = $("#signInModal .passwordInput").val();

        $.ajax({
            type: "POST",
            url: "/sign_in",
            data: {
                username: username,
                password: password
            },
            success: function (data) {
                data = JSON.parse(data);

                if (data.result) {
                    window.location.href = "/";
                }
            }
        });
    });
})();
