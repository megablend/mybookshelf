/*
    Created by Megafu Charles
*/

$(document).ready(function() 
{
	newMerchant = "#new_merchant";
	newStore = "#new_store";
  merchantLogin = "#merchant-login";
  productDescription = "#description-form";
   //form handlers
   $(newMerchant).validationEngine();
   $(newStore).validationEngine();
   $(merchantLogin).validationEngine();
   $(productDescription).validationEngine();

   //submit merchant login form
  $(merchantLogin).submit(function (e) {
          var form = this;
          e.preventDefault();
      
      //check if the error message exists
      $('body').each(function(){
               var $error = $('.formError',$(this));
               if(!$error.length){
      //             $(".overlay").css("visibility", "visible");
          // $(".loader").css("visibility", "visible");
          // $(".loader").html('<img src="' + main_index + 'assets/img/ajax-modal-loading.gif" /> <span style="color: #fff; font-size: 12px; margin-left: 5px;">Please wait...</span>');
          
           //  setTimeout(function () {
           //     form.submit();
           // }, 2000); // in milliseconds
                 form.submit();
               }
           });
      
    });

  //submit merchant login form
  $(productDescription).submit(function (e) {
          
    });

   //submit store signup form
	$(newStore).submit(function (e) {
          var form = this;
          e.preventDefault();
		  
		  //check if the error message exists
		  $('body').each(function(){
               var $error = $('.formError',$(this));
               if(!$error.length){
      //             $(".overlay").css("visibility", "visible");
				  // $(".loader").css("visibility", "visible");
				  // $(".loader").html('<img src="' + main_index + 'assets/img/ajax-modal-loading.gif" /> <span style="color: #fff; font-size: 12px; margin-left: 5px;">Please wait...</span>');
				  
					 //  setTimeout(function () {
					 //     form.submit();
					 // }, 2000); // in milliseconds
		             form.submit();
               }
           });
		  
    });

   //submit merchant signup form
	$(newMerchant).submit(function (e) {
          var form = this;
          e.preventDefault();
		  
		  //check if the error message exists
		  $('body').each(function(){
               var $error = $('.formError',$(this));
               if(!$error.length){
      //             $(".overlay").css("visibility", "visible");
				  // $(".loader").css("visibility", "visible");
				  // $(".loader").html('<img src="' + main_index + 'assets/img/ajax-modal-loading.gif" /> <span style="color: #fff; font-size: 12px; margin-left: 5px;">Please wait...</span>');
				  
					 //  setTimeout(function () {
					 //     form.submit();
					 // }, 2000); // in milliseconds
		             form.submit();
               }
           });
		  
    });


    /* Store URL auto-fill */
    $("#store_url").on({
        keydown: function (e) {
            var excluded = ["13", "32", "190", "191", "220", "186", "189", "222"];
            var code = e.which.toString();
            //alert(code);
            if (excluded.indexOf(code) != -1)
                return false;
        },
        input: function () {
            var storeUrl = $(this).val();

            if (!charReg.test(storeUrl)) {
                var temp = $(this).val().toString();
                $(this).val(temp.substring(0, temp.length - 1));
            }
        },
        change: function () {
            this.value = this.value.replace(/\s/g, "");
            this.value = this.value.replace(/\s/g, "");
        }
    });

    var charReg = /^\s*[a-zA-Z0-9,\s]+\s*$/;

    $("#store_name").on({
        keydown: function (e) {
            var excluded = ["13", "190", "191", "220", "186", "222"];
            var code = e.which.toString();
            if (excluded.indexOf(code) != -1)
                return false;
        },
        input: function () {
            var storeName = $(this).val();

            if (!charReg.test(storeName)) {
                var temp = $(this).val().toString();
                $(this).val(temp.substring(0, temp.length - 1));
            }

            var suggestedStoreUrl = $(this).val().replace(/\s{1,}/g, "-");
            $("#store_url").val(suggestedStoreUrl.toLowerCase());
        }
    });

});