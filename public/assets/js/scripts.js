
jQuery(document).ready(function() {

    /*
        Fullscreen background
    */
    $.backstretch("assets/img/backgrounds/1.jpg");

    /*
        Login form validation
    */
    $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function() {
    	$(this).removeClass('input-error');
    });

    $('.login-form').on('submit', function(e) {

    	$(this).find('input[type="text"], input[type="password"], textarea').each(function(){
    		if( $(this).val() == "" ) {
    			e.preventDefault();
    			$(this).addClass('input-error');
    		}
    		else {
    			$(this).removeClass('input-error');
    		}
    	});

    });

    /*
        Registration form validation
    */
    $('.registration-form input[type="text"], .registration-form textarea').on('focus', function() {
    	$(this).removeClass('input-error');
    });

    $('.registration-form').on('submit', function(e) {

    	$(this).find('input[type="text"], textarea').each(function(){
    		if( $(this).val() == "" ) {
    			e.preventDefault();
    			$(this).addClass('input-error');
    		}
    		else {
    			$(this).removeClass('input-error');
    		}
    	});

    });


});


/*
    Create a new category onchange
*/

function yesnoCheck(that) {
		if (that.value == "new category") {
				document.getElementById("ifYes").style.display = "block";
				document.getElementById("create category").name = "category_name";
		} else {
				document.getElementById("ifYes").style.display = "none";
				document.getElementById("create category").name = "no_name";
		}
}
