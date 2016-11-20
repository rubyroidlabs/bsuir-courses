'use strict';

var scheme   = "ws://";
var uri      = scheme + window.document.location.host + "/";
var ws       = new WebSocket(uri);


var data = { phrase_id: 123, word_content: "sdds" }

function addNewPhrase(json) {
  let content = " " + json.word_content;
  console.log("content");
  let phrase = $(content).wrap('`<a href="/phrases/show/${json.phrase_id}">')
                         .wrap(`<td id="phrase_${json.phrase_id}">`)
                         .wrap('<tr>');
  console.log(phrase.html());
  $('#phrases').append(phrase);
  $(`#phrase_${json.phrase_id} a`).append(phrase);
}

addNewPhrase(data)

function modifyPhrase(json) {
  $(`#phrase_${json.phrase_id} a`).append(" " + json.word_content);
}

function connect() {
  try {
    ws = new WebSocket(host);

    ws.onmessage = function(msg) {
      let json = JSON.parse(msg.data);
      addNewPhrase(json);
      modifyPhrase(json);
    }
  } catch(exception) {
    console.log("Error: " + exception);
  }
}

$(function() {
  connect();
});

window.onbeforeunload = function() {
  ws.onclose = function () {};
  ws.close()
};

window.onbeforeunload = function() {
  ws.onclose = function () {};
  ws.close()
};