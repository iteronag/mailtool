// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require data-confirm-modal
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require underscore
//= require helpers
//= require jquery-fileupload/basic

dataConfirmModal.setDefaults({
  title: 'MailTool: Confirm your action',
  commit: 'Continue',
  cancel: 'Cancel'
});

var locals = {"german" : "de-DE", "french" : "fr-FR", "english" : "en-US"};

var wysihtml_options = {
  // "font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
  // "emphasis": true, //Italics, bold, etc. Default true
  // "lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
  // "html": true, //Button which allows you to edit the generated HTML. Default false
  // "link": false, //Button to insert a link. Default true
  // "image": false, //Button to insert an image. Default true,
  // "color": true //Button to change color of font
}