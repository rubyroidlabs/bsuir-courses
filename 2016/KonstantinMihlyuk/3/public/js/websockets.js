(function () {
    try {
        socket.onmessage = function (msg) {
            var response = msg.data ? JSON.parse(msg.data) : "";

            switch (response.type) {
                case "create_phrase": {
                    var data = response.data;

                    createPhrase(data['phrase_id'], data['word_id'], data['word_text'],
                        data['name'], data['time'], data['username']);
                    updatePhraseListeners();
                    break;
                }
                case "add_word": {
                    var data1 = response.data;

                    addWord(data1['phrase_id'], data1['word_id'], data1['word_text'],
                        data1['name'], data1['time'], data1['username']);
                    updatePhraseListeners();
                    break;
                }
            }
        };
    }

    function createPhrase(phraseId, wordId, text, name, time, username) {
        var phrase =
            "<div class=\"well phrase\" data-id=" + phraseId + ">" +
            "<div class=\"proposal\">" +
            "<span class=\"word\" data-id=" + wordId + " data-username=" + username + " data-name=" +
                name + " data-time=\"" + time + "\">" + text + "</span>" +
            "<div class=\"controls\">" +
            "<div class=\"add-phrase input-group\">" +
            "<input placeholder=\"Добавьте слово\" type=\"text\" " +
            "class=\"form-control\" maxlength=\"12\">" +
            "<span class=\"input-group-btn\">" +
            "<button class=\"btn btn-success\" type=\"button\">" +
            "<span class=\"glyphicon glyphicon-ok\"></span>" +
            "</button>" +
            "</span>" +
            "</div>" +
            "<button class=\"remove-phrase btn btn-danger\" type=\"button\">" +
            "<span class=\"glyphicon glyphicon-remove\"></span>" +
            "</button>" +
            "</div>" +
            "</div>" +
            "<div class=\"strap\"></div>" +
            "</div>";

        $(".phrases").prepend(phrase);
    }

    function addWord(phraseId, wordId, text, username, time) {
        var phrase = $(".phrase[data-id=" + phraseId + "]");

        phrase.find(".proposal .word:last-of-type").after("<span class=\"word\" data-id=" + wordId +
            " data-name=" + username + " data-time=" + time + ">" + text + "</span>");
    }

})();