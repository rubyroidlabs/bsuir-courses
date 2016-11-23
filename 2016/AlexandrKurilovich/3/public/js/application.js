$(document).ready(function() {
  $("div.can_update").mouseenter(function() {
    $(this).find("div.form_content").fadeIn(0);
  });
  $("div.can_update").mouseleave(function() {
    $(this).find("div.form_content").fadeOut(0);
  });
  $("input.submit_form").click(function() {
    var $this = $(this);
    var value = $this.parent().find("input[type='text']").val();
    var id = $this.parents(".can_update").attr("data-id");
    $.ajax({
      url: "/create",
      type: "POST",
      data: { word: { name: value, id: id } },
      complete: function(xhr){
        message = JSON.parse(xhr.responseText).message;
        switch (message) {
          case "error":
            alert("Можно использовать только 1 знак препинания. Нельзя использовать точки");
            break;
          case "success":
            var $can = $this.parents(".can_update");
            $can.removeClass("can_update");
            $can.addClass("not_update");
            $can.find(".form_content").remove();
            $can.css("border-left", "3px solid rgb(238, 62, 31)");
            $can.find("a").css("color", "rgb(143, 143, 143)");
            var text = $can.find("a").text();
            $can.find("a").text(text + " " + value);
            $("span.success_update").text("Слово успешно добавлено");
            break;
          default:
            alert("Ошибка");
        }
      },
    });
  });
});
