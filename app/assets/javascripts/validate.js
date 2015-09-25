$(document).ready(function() 
{
	newMerchant = "#new_merchant11";
   //form handlers
   $(newMerchant).validationEngine();

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

});