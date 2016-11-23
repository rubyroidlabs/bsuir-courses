$(".phrase-able").click(function(event) {
  if ((event.target == this) || (event.target.tagName == "SPAN")) {
    if ($("#inline-redactor-for-" + $(this)[0].id).css("display") == "none") {
      $("#inline-redactor-for-" + $(this)[0].id).slideDown(500);
    } 
    else {
      $("#inline-redactor-for-" + $(this)[0].id).slideUp(500);
    }
  }
});

var updatephraseHTML = function(phraseID, responseText) {
  var html = $.parseHTML(responseText);
  var container = html[html.length - 1].children;
  var phrasesTableChildren = container[container.length - 1].children;
  var ulChildren = phrasesTableChildren[phrasesTableChildren.length - 1];
  var phrase = $(ulChildren).find("#" + phraseID);
  $("#" + phraseID)[0].outerHTML = phrase.context.outerHTML;
};

$(".inline-redactor-btn").click(function() {
  var input = $(this)[0].previousSibling;
  var phraseID = $(this)[0].parentElement.id.split("-").slice(-1)[0];
  if (input.value.match(/^[\w\d]+[;,:&\(\)\[\]\{\}=+-]?$/)) {
    $.ajax({
      url: "/phrases/edit/" + phraseID,
      dataType: "json",
      type: "POST",
      data : { word: input.value }
    })
    .always(function(response) {
      updatephraseHTML(phraseID, response.responseText);
    }); 
  } 
  else {
    return false;
  }
});

$(function() {
    $("#login-form-link").click(function(e) {
    $("#login-form").delay(100).fadeIn(100);
    $("#register-form").fadeOut(100);
    $("#register-form-link").removeClass("active");
    $(this).addClass("active");
    e.preventDefault();
  });
  $("#register-form-link").click(function(e) {
    $("#register-form").delay(100).fadeIn(100);
    $("#login-form").fadeOut(100);
    $("#login-form-link").removeClass("active");
    $(this).addClass("active");
    e.preventDefault();
  });
});

 $( function() {
    $( "#dialog" ).dialog();
  } );

