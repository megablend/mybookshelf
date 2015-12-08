$(function()
{
	var epubDropzone;
	Dropzone.options.myAwesomeDropzone = {
	  accept: function(file, done) {
	    console.log("uploaded");
	    done();
	  },
	  init: function() {
	    this.on("addedfile", function() {
	      if (this.files[1]!=null){
	        this.removeFile(this.files[0]);
	      }
	    });
	  }
	};
	epubDropzone = new Dropzone("#epub-dropzone",{
												  accept: function(file, done) {
												    //console.log("uploaded");
												    done();
												  },
												  init: function() {
												    this.on("addedfile", function() {
												      if (this.files[1]!=null){
												        this.removeFile(this.files[0]);
												      }
												    });
												  }
												});
	return epubDropzone.on("success", function(file, responseText)
	{
		var _this = this;
		var uploadError = $("#upload-epub-error");
		if(typeof responseText == "object")
		{
			if(!responseText.message)
			{
				uploadError.removeClass("alert alert-danger");
                uploadError.html("");
                setTimeout(function()
				{
					var getFileName = responseText.file_name.url.split("/");
					var fileName = getFileName[getFileName.length - 1].charAt(0).toUpperCase() + getFileName[getFileName.length - 1].slice(1);
					//console.log(fileName);

				   //disable further upload of files
				   var element = '<div style="text-align: left"><i class="step-1-completed fa  fa-check-circle fa-2x"></i> File successfully uploaded.</div>';
				   $("#upload-epub-file-holder").removeClass("dropfile visible-lg");
				   $('#upload-epub-file-holder').prop('onclick',null).off('click');
				   $("#upload-epub-file-holder").html(element);
		           $('#epubFileModal').modal('hide');
		           _this.removeAllFiles();
				}, 1000);
			}
			else
			{
				_this.removeAllFiles();
               uploadError.addClass("alert alert-danger");
               uploadError.html(responseText.message);
			}
		}
		else
		{
			_this.removeAllFiles();
            alert("Unknown error, please try again");
		}
	});
});