$(function () {
  $("#user-auth-window").dialog({
    autoOpen: false,
    resizable: false,
    show: {
      effect: "blind",
      duration: 250
    },
    width: 500
  });

  $("#user-auth-open").click(function() {
    if (!($("#user-auth-window").dialog("isOpen"))) {
      $("#shadow").fadeIn(400);
      $("#user-auth-window").dialog("open");
    } else {
      $("#shadow").fadeOut(400);
      $("#user-auth-window").dialog("close");
    };
  });

  $("#shadow").click(function() {
    $("#user-auth-window").dialog("close");
    $("#shadow").fadeOut(400);
  });

  $("#signUpWindowBtn").click(function() {
    $("#logInWindow").hide();
    $("#signUpWindow").fadeIn(300);
  });

  $("#logInWindowBtn").click(function() {
    $("#signUpWindow").hide();
    $("#logInWindow").fadeIn(300);
  });
 
});
