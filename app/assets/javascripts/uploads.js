$(document).ready(function(){

  $('#fileupload').fileupload({
    dataType: 'json',
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png|mp4|mp3)$/i,
    maxFileSize: 1048576//1MB
  }).bind('fileuploadadd', function (e, data) {
  $(".error-message").html("");
  }).bind('fileuploadfail', function (e, data) {
  $(".error-message").html("invalid content type");
  }).bind("fileuploaddone", function (e, data) {
    $('#progress .bar').css( 'width','0%' );
    attachImage(data.result.file);
    // $('.nav-tabs a[href="#fasset"]').tab('show')
    // str = '<a href="javascript:void(0)"><div class="image"><img class="img-thumbnail" src="' + data.result.file + '" width="100px" height="100px"></div>';
    // $(".image-container").prepend(str);
  }).bind('fileuploadprogressall', function (e, data) {
    var progress = parseInt(data.loaded / data.total * 100, 10);
    $('#progress .bar').css( 'width', progress + '%' );
  });

  $(".popuper").on("click", function(){
    $(".popuper").removeClass("current");
    $(this).addClass("current")
  });

  $("body").on("click", ".img-thumbnail", function(){
    var url = window.location.href
    var arr = url.split("/");
    var result = arr[0] + "//" + arr[2]
    path = result + "/" + $(this).attr("src").replace("thumb", "original");
    var $editor = $(".popuper.current").parent().find("textarea").data("wysihtml5").editor
    $editor.setValue($editor.getValue() + "<img src='"+ path +"' alt='missing image'>", true);
    $('#asset_files').modal('hide')
  });
});

function attachImage(image_path){
  var url = window.location.href;
  var arr = url.split("/");
  var result = arr[0] + "//" + arr[2]
  path = result + "/" + image_path.replace("thumb", "original");
  var $editor = $(".popuper.current").parent().find("textarea").data("wysihtml5").editor
  $editor.setValue($editor.getValue() + "<img src='"+ path +"' alt='missing image'>", true);
  $('#asset_files').modal('hide')
}