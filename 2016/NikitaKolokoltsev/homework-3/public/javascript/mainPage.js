$(function() {

  showInlineRedactor = function() {
    $(".quote-able").click(function(event) {
      if ((event.target == this) || (event.target.tagName == "SPAN")) {
        if ($(this).hasClass("redactor-show"))  {
          $(this).removeClass("redactor-show");
          $("#inline-redactor-for-" + $(this)[0].id).slideUp(300);
          $(".errors").hide();
        } else {
          $(this).addClass("redactor-show");
          $("#inline-redactor-for-" + $(this)[0].id).slideDown(500);
        };
      };
    });
  };

  // WEBSOCKETS
  ws = new WebSocket('wss://' + window.location.host);

  ws.onmessage = function(msg) {
    if (msg.data.split(",").length == 2) {
      quoteID = msg.data.split(",")[0]
      $.get("/", function(data) {
        updateQuoteHTML(quoteID, data);
      });
    } else {
      $.get("/", function(data) {
        addNewQuoteHTML(data);
      });
    };
  };

  // AJAX update quote from main page
  $(".inline-redactor-btn").click(function() {
    input = $(this)[0].previousSibling;
    errorsBlock = $(this).parent()[0].lastChild;
    quoteID = $(this)[0].parentElement.id.split("-").slice(-1)[0];
    if (input.value.match(/^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/)) {
      $.ajax({
        url: "/quotes/edit/" + quoteID,
        dataType: 'json',
        type: 'POST',
        data : { text: input.value }
      }).always(function(response) {
        updateQuoteHTML(quoteID, response.responseText);
        ws.send([quoteID, input.value])
        console.log(quoteID + " - quoteID; " + input.value + " - input;")
      });
    } else {
      showWordFormatError(errorsBlock);
      return false;
    };
  });

  showInlineRedactor();

  showSpaceError = function(errorsBlock) {
    $(errorsBlock)[0].innerHTML = "Spaces are not allowed!"
    $(errorsBlock).fadeIn(300);
    setTimeout(function() {
      $(errorsBlock).hide();
    }, 2250);
  }

  showDotError = function(errorsBlock) {
    $(errorsBlock)[0].innerHTML = "Dots are not allowed!"
    $(errorsBlock).fadeIn(300);
    setTimeout(function() {
      $(errorsBlock).hide();
    }, 2250);
  }

  showWordFormatError = function(errorsBlock) {
    $(errorsBlock)[0].innerHTML = "You can't add that!"
    $(errorsBlock).fadeIn(300);
    setTimeout(function() {
      $(errorsBlock).hide();
    }, 2250);
  }

  $(".inline-redactor-input").on("keypress", function(e) {
    if (e.which == 32) {
      errorsBlock = $(this).parent()[0].lastChild;
      showSpaceError(errorsBlock);
      return false;
    }

    if (e.which == 46) {
      errorsBlock = $(this).parent()[0].lastChild;
      showDotError(errorsBlock);
      return false;
    }
  });

  updateQuoteHTML = function(quoteID, responseText) {
    html = $.parseHTML(responseText);
    containerChildren = html[html.length - 1].children;
    quotesTableChildren = containerChildren[containerChildren.length - 1].children;
    ulChildren = quotesTableChildren[0];
    quote = $(ulChildren).find("#" + quoteID);
    $("#" + quoteID)[0].outerHTML = quote[0].outerHTML;
  }

  addNewQuoteHTML = function(responseText) {
    html = $.parseHTML(responseText);
    containerChildren = html[html.length - 1].children;
    quotesTableChildren = containerChildren[containerChildren.length - 1].children;
    ulChildren = quotesTableChildren[0].children;
    quote = ulChildren[0];
    $("#quotes-list")[0].innerHTML = quote.outerHTML + $("#quotes-list")[0].innerHTML;
  }

})