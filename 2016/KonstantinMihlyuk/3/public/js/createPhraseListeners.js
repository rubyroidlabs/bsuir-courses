(function () {
    $(".create-phrase").on("click", function () {
        var beginPhrase =
            "<div class=\"create-phrase-popup well phrase\">" +
            "<div class=\"input-group\">" +
            "<input type=\"text\" class=\"form-control\">" +
            "<span class=\"input-group-btn\">" +
            "<button class=\"add-phrase btn btn-success\" " +
            "type=\"button\">Начните фразу!</button>" +
            "</span>" +
            "</div>" +
            "<button class=\"remove-phrase btn btn-danger\" type=\"button\">" +
            "<span class=\"glyphicon glyphicon-remove\"></span>" +
            "</button>" +
            "</div>";

        var phrasePopup = ".phrases .create-phrase-popup";
        var phrasePopupInput = phrasePopup + " input";
        var addPhrase = phrasePopup + " .add-phrase";
        var removePhrase = phrasePopup + " .remove-phrase";
        var phrases = ".phrases";

        if ($(phrasePopup).length > 0) {
            $(phrasePopup).remove();
        } else {
            $(phrases).prepend(beginPhrase);

            $(removePhrase).on("click", function () {
                $(phrasePopup).remove();
            });

            $(addPhrase).click(function () {
                var text = $(phrasePopupInput).val();
                var username = $(".username-handler").data("username");

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

                $(phrasePopup).remove();
            });
        }
    });

})();
