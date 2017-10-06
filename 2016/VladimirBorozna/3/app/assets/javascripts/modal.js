(function() {
  var target = document.getElementById('modal-container');
  var config = { attributes: true, childList: true, characterData: true };

  var observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      $('form').submit(function(event) {
        event.preventDefault();
        var form = $(this);
        $.ajax({
          type: form.attr('method'),
          url:  form.attr('action'),
          data: form.serialize()
        }).done(function(data) {
          
        }).fail(function(data) {
          var errors = data.responseJSON;
          if (errors.length != 0 && data.status != 404) {
            var errorsHtml = "<div id='errors'><ul>";
            for(var i = 0; i < errors.length; ++i) {
              errorsHtml += "<li>" + errors[i] + "</li>";
            }
            errorsHtml += "</ul></div>";
            $('#errors').remove();
            $(errorsHtml).hide().appendTo('.modal-body').slideDown();
          }
        });
      });
    });
  });

  observer.observe(target, config);
})();

//observer.disconnect();