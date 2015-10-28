$(document).ready(function() {
	var siteDomain = $("#domain-name").val();
	var pageLoadingDiv = "#loadingModal";
   $('.sell-a-book, .sell-a-book-link').on('click', function()
   	{
   		$(pageLoadingDiv).modal();
   		setTimeout(function () {
				     window.location.href = siteDomain + '/merchants/sell';
				 }, 2000); // in milliseconds
   	});
});