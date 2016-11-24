var updatePhraseListeners = function () {
    var phrases = $(".phrases");
    var socket = null;

    phrases.off();
    phrases.find(".btn").off();

    phrases.find(".add-phrase button").on("click", function () {
        var phrase = $(this).parents(".phrase"),
            text = phrase.find("input").val(),
            username = $(".username-handler").data("username"),
            phrase_id = phrase.data("id"),
            word_name = $(this).parents(".phrase").find(".word:last").data("username");

        if (!username) {
            var self = this;

            $(this).popover({
                content: "Необходимо залогиниться!",
                animation: true,
                placement: "top"
            }).popover("show");

            setTimeout(function () {
                $(self).popover("destroy");
            }, 3000);

            return;
        }

        if (username == word_name) {
            var self1 = this;

            $(this).popover({
                content: "Ваше сообщение последнее!",
                animation: true,
                placement: "top"
            }).popover("show");

            setTimeout(function () {
                $(self1).popover("destroy");
            }, 3000);

            return;
        }

        $(this).parents(".controls").find("input").val("");

        var data = {
            text: text,
            username: username,
            phraseId: phraseId
        };

        socket.send(JSON.stringify({
            type: "add_word",
            data: data
        }));

    });

    $(".word").each(function () {
        var moment = null;
        $(this).popover({
            trigger: "hover",
            title: $(this).data("name"),
            content: moment($(this).data("time"), "YYYY-MM-DD HH-mm-ss UTC").locale("ru").fromNow(),
            animation: true,
            placement: "top"
        });
    });

    $(".phrase").click(function () {
        $(this).parent().find(".controls").css("display", "none");
        $(this).find(".controls").css("display", "inline-block");
    });
};

updatePhraseListeners();
