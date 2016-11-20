$(function() {

  var showInlineRedactor = function() {
    $(".quote-able").click(function(event) {
      if ((event.target == this) || (event.target.tagName == "SPAN")) {
        if ($(this).hasClass("redactor-show"))  {
          $(this).removeClass("redactor-show");
          $("#inline-redactor-for-" + $(this)[0].id).slideUp(300);
          $(".errors").hide();
        } else {
          $(this).addClass("redactor-show");
          $("#inline-redactor-for-" + $(this)[0].id).slideDown(500);
        }
      }
    });
  };

  var showSpaceError = function(errorsBlock) {
    $(errorsBlock)[0].innerHTML = "Spaces are not allowed!";
    $(errorsBlock).fadeIn(300);
    setTimeout(function() {
      $(errorsBlock).hide();
    }, 2250);
  };

  var showDotError = function(errorsBlock) {
    $(errorsBlock)[0].innerHTML = "Dots are not allowed!";
    $(errorsBlock).fadeIn(300);
    setTimeout(function() {
      $(errorsBlock).hide();
    }, 2250);
  };

  var showWordFormatError = function(errorsBlock) {
    $(errorsBlock)[0].innerHTML = "You can't add that!";
    $(errorsBlock).fadeIn(300);
    setTimeout(function() {
      $(errorsBlock).hide();
    }, 2250);
  };

  var updateQuoteHTML = function(quoteID, responseText) {
    var html = $.parseHTML(responseText);
    var containerChildren = html[html.length - 1].children;
    var quotesTableChildren =
      containerChildren[containerChildren.length - 1].children;
    var ulChildren = quotesTableChildren[0];
    var quote = $(ulChildren).find("#" + quoteID);
    $("#" + quoteID)[0].outerHTML = quote[0].outerHTML;
  };

  var addNewQuoteHTML = function(responseText) {
    var html = $.parseHTML(responseText);
    var containerChildren = html[html.length - 1].children;
    var quotesTableChildren =
      containerChildren[containerChildren.length - 1].children;
    var ulChildren = quotesTableChildren[0].children;
    var quote = ulChildren[0];
    $("#quotes-list")[0].innerHTML = 
      quote.outerHTML + $("#quotes-list")[0].innerHTML;
  };

  // WEBSOCKETS
  var ws = new WebSocket("wss://" + window.location.host);

  ws.onmessage = function(msg) {
    if (msg.data.split(",").length == 2) {
      var quoteID = msg.data.split(",")[0];
      $.get("/", function(data) {
        updateQuoteHTML(quoteID, data);
      });
    } else {
      $.get("/", function(data) {
        addNewQuoteHTML(data);
      });
    }
  };

  // AJAX update quote from main page
  $(".inline-redactor-btn").click(function() {
    var input = $(this)[0].previousSibling;
    var errorsBlock = $(this).parent()[0].lastChild;
    var quoteID = $(this)[0].parentElement.id.split("-").slice(-1)[0];
    if (input.value.match(/^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/)) {
      $.ajax({
        url: "/quotes/edit/" + quoteID,
        dataType: "json",
        type: "POST",
        data : { text: input.value }
      }).always(function(response) {
        updateQuoteHTML(quoteID, response.responseText);
        ws.send([quoteID, input.value]);
      });
    } else {
      showWordFormatError(errorsBlock);
      return false;
    }
  });

  showInlineRedactor();

  $(".inline-redactor-input").on("keypress", function(e) {
    var errorsBlock = $(this).parent()[0].lastChild;
    if (e.which == 32) {
      showSpaceError(errorsBlock);
      return false;
    }

    if (e.which == 46) {
      showDotError(errorsBlock);
      return false;
    }
  });

});