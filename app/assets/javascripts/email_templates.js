//underscorejs template settings
 _.templateSettings = {
                evaluate: /\{\{=(.+?)\}\}/g,
                interpolate: /\{\{(.+?)\}\}/g,
                escape: /\{\{-(.+?)\}\}/g
            };
var asdf;
$(document).ready(function(){

  //get template details and update it in the form
  $("#email_template_group_id").change(function(){
    id = $(this).val()

    // //reset form with with default value
    // $.each(["new_template", "reminder_template"], function(i, form_type){
      setFormValues({new_text: "", reminder_text: "", version: 0})
    // });

    if(id != ""){
      url = "/groups/" + id + "/email_templates?"
      if ($("#email_template_language").val() != undefined)
        url +=  "language=" + $("#email_template_language").val()

      $.ajax({
        dataType: 'json',
        url: url,
        success: function(data){
          asdf = data
          if(Object.keys(data).length > 0){
            fields = {}
            $.each(data[0], function(field, value){
              fields[field] = value;
            });
            setFormValues(fields)
          }
        },
        error: function(){
          alert("error")
        }
      });
    }
  });

  $("#new_reminder_template, #new_new_template").submit(function(event) {
      event.preventDefault();
      createEmailTemplate($(this).attr("id"));
  });
});

//set form values on group change
function setFormValues(values){
  $(".help-inline").remove();

  $.each(values, function(field, value){
    $elem = $("#email_template_" + field );

    if(field == 'new_text' || field == "reminder_text"){
      $elem.data("wysihtml5").editor.setValue(value);
    }else{
      $elem.val(value)
    }
  });
}

// function createEmailTemplate(formId){
//   $form = $("#"+formId);
//   form_const = formId.replace("new_", "");
//   $.ajax({
//     type: "post",
//     url: $form.attr("action"),
//     dataType: "json",
//     data: $( $form ).serialize(),
//     beforeSend: function() {
//       $(".error-message").remove();
//     },
//     success: function(responseData, textStatus, jqXHR) {
//       field_prefix = "form#" + form_const + "_template #email_template_";
//       setFormValues(form_const, {group_id: responseData.group_id, description: responseData.description, version: responseData.version});
//       flashMessage("Email Template created successfully.", "success")
//     },
//     error: function(jqXHR, textStatus, errorThrown) {
//       errors = $.parseJSON(jqXHR.responseText);

//       $.each(errors, function(field, value){
//         var ErrorField = _.template($("#tmpl_error_field").html());
//         if($.inArray( field, [ "group_id" ]) < 0 ){
//           $("#"+formId + " #"+form_const + "_" + field ).closest("div").append($(ErrorField({message: value[0]})))
//         }
//       });
//     },
//     complete: function(){
//       // $form.find("input[type=submit]").val("Save").prop("disabled", false);
//     }
//   });
// }