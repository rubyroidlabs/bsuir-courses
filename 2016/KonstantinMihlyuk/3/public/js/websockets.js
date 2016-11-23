(function () {
    try {
        socket.onopen = function () {
            console.log("Socket Status: " + socket.readyState + " (open)");
        };

        socket.onclose = function () {
            console.log("Socket Status: " + socket.readyState + " (closed)");
        };

        socket.onmessage = function (msg) {
            var response = msg.data ? JSON.parse(msg.data) : '';

            switch (response.type) {
                case 'create_phrase': {
                    var data = response.data;

                    createPhrase(data.phrase_id, data.word_id, data.word_text, data.name, data.time, data.username);
                    updatePhraseListeners();
                    break;
                }
                case 'add_word': {
                    var data = response.data;

                    addWord(data.phrase_id, data.word_id, data.word_text, data.name, data.time, data.username);
                    updatePhraseListeners();
                    break;
                }

            }
        }
    } catch (exception) {
        console.log("Error: " + exception);
    }

    function createPhrase(phrase_id, word_id, text, name, time, username) {
        var phrase =
            '<div class="well phrase" data-id=' + phrase_id + '>' +
            '<div class="proposal">' +
            '<span class="word" data-id=' + word_id + ' data-username='+ username + ' data-name=' + name + ' data-time="' + time + '">' + text + '</span>' +
            '<div class="controls">' +
            '<div class="add-phrase input-group">' +
            '<input placeholder="Добавьте слово" type="text" class="form-control" maxlength="12">' +
            '<span class="input-group-btn">' +
            '<button class="btn btn-success" type="button">' +
            '<span class="glyphicon glyphicon-ok"></span>' +
            '</button>' +
            '</span>' +
            '</div>' +
            '<button class="remove-phrase btn btn-danger" type="button">' +
            '<span class="glyphicon glyphicon-remove"></span>' +
            '</button>' +
            '</div>' +
            '</div>' +
            '<div class="strap"></div>' +
            '</div>';

        $('.phrases').prepend(phrase);
    }

    function addWord(phrase_id, word_id, text, username, time) {
        var phrase = $('.phrase[data-id=' + phrase_id + ']');

        phrase.find('.proposal .word:last-of-type').after("<span class='word' data-id=" + word_id + " data-name=" + username + " data-time=" + time+ ">" + text + "</span>");
    }

})();