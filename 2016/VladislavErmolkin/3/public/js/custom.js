$(".quote-able").click(function(event) {
  if ((event.target == this) || (event.target.tagName == "SPAN")) {
    if ($("#inline-redactor-for-" + $(this)[0].id).css('display') == "none") {
      $("#inline-redactor-for-" + $(this)[0].id).slideDown(500);
    } 
    else {
      $("#inline-redactor-for-" + $(this)[0].id).slideUp(500);
    }
  }
});

var updateQuoteHTML = function(quoteID, responseText) {
  var html = $.parseHTML(responseText);
  console.log(html);
  var containerChildren = html[html.length - 1].children;
  var quotesTableChildren = containerChildren[containerChildren.length - 1].children;
  var ulChildren = quotesTableChildren[quotesTableChildren.length - 1];
  console.log(ulChildren);
  var quote = $(ulChildren).find("#" + quoteID);
  console.log(quote);
  $("#" + quoteID)[0].outerHTML = quote.context.outerHTML;
};

$(".inline-redactor-btn").click(function() {
  var input = $(this)[0].previousSibling;
  var quoteID = $(this)[0].parentElement.id.split("-").slice(-1)[0];
  if (input.value.match(/^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/)) {
    $.ajax({
      url: "/phrases/edit/" + quoteID,
      dataType: "json",
      type: "POST",
      data : { word: input.value }
    })
    .always(function(response) {
      updateQuoteHTML(quoteID, response.responseText);
    }); 
  } 
  else {
    return false;
  }
});

$(function() {
    $('#login-form-link').click(function(e) {
    $("#login-form").delay(100).fadeIn(100);
    $("#register-form").fadeOut(100);
    $('#register-form-link').removeClass('active');
    $(this).addClass('active');
    e.preventDefault();
  });
  $('#register-form-link').click(function(e) {
    $("#register-form").delay(100).fadeIn(100);
    $("#login-form").fadeOut(100);
    $('#login-form-link').removeClass('active');
    $(this).addClass('active');
    e.preventDefault();
  });
});

 $( function() {
    $( "#dialog" ).dialog();
  } );

