(function () {
    $("#signUpModal .signUpButton").click(function () {
        var username = $("#signUpModal .usernameInput").val();
        var name = $("#signUpModal .nameInput").val();
        var password = $("#signUpModal .passwordInput").val();

        $.ajax({
            type: "POST",
            url: "/sign_up",
            data: {
                username: username,
                name: name,
                password: password
            },
            success: function (data) {
                data = JSON.parse(data);

                if (data.result) {
                    window.location.href = "/"
                } else {

                }
            }
        });
    })
})();