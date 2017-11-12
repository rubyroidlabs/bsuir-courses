$(document).ready(function() {
  $('a[href^="/"][data-modal="true"]').click(function(e) {
    $this = $(this);
    e.preventDefault();
    $.ajax({
      url: $this.attr('href'),
      type: $this.data('method') || "GET",
      success: function(data) {
        $('#modal-container').html(data)
        $('#modal').modal({ show: true, keyboard: true })
      },
      error: function(xhr, ajaxOptions, thrownError) {
      }
    });
  });
});
