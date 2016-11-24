$(function() {

  var showSpaceError = function() {
    $(".errors")[0].innerHTML = "Spaces are not allowed!";
    $(".errors").fadeIn(300);
    setTimeout(function() {
      $(".errors").hide();
    }, 2250);
  };

  var showDotError = function() {
    $(".errors")[0].innerHTML = "Dots are not allowed!";
    $(".errors").fadeIn(300);
    setTimeout(function() {
      $(".errors").hide();
    }, 2250);
  };

  var showWordFormatError = function() {
    $(".errors")[0].innerHTML = "You can't add that!";
    $(".errors").fadeIn(300);
    setTimeout(function() {
      $(".errors").hide();
    }, 2250);
  };

  var checkInput = function(input) {
    $(input).on("keypress", function(e) {
      if (e.which == 32) {
        showSpaceError();
        return false;
      }

      if (e.which == 46) {
        showDotError();
        return false;
      }
    });
  };

  // WEBSOCKETS
  var ws = new WebSocket("ws://" + window.location.host);
  $("#new-quote-form").submit(function() {
    var input = $("#new-quote-input")[0];
    if (input.value.match(/^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/)) {
      $("#new-quote-form").submit(function() {
        return false;
      });
      ws.send(input.value);
    } else {
      showWordFormatError();
      return false;
    }
  });

  $("#edit-quote-form").submit(function() {
    var input = $("#edit-quote-input")[0];
    var quoteId = $("#edit-quote-input")[0].baseURI.split("/").pop();
    if (input.value.match(/^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/)) {
      $("#edit-quote-form").submit(function() {
        return false;
      });
      ws.send([quoteId, input.value]);
    } else {
      showWordFormatError();
      return false;
    }
  });

  // Do not allow to enter spaces or dots
  checkInput("#new-quote-input");
  checkInput("#edit-quote-input");

  $(".disabled").on("click", function() {
    $(".errors")[0].innerHTML = 
      "You must wait when someone else will add a word.";
    $(".errors").fadeIn(300);
    return false;
  });

  $(".container").on("click", function() {
    $(".errors").fadeOut(300);
  });


  $("[data-toggle=\"popover\"]").popover();
});
