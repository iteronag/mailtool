$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});

// //to get a specific parameter value from the current url
// function urlParam(name) {
//   var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
//   if (results == null) {
//     return null;
//   } else {
//     return results[1] || 0;
//   }
// }

//validate email address
function validateEmail(email) {
  return /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test( email );
}

//validate email id is hr or info
function validHrOrInfoEmail(email){
  return  /^(hr|info)+@([\w-]+\.)+[\w-]{2,4}?$/.test( email );
}

//convert string to lowarcase and trim whitepsace
function lowerCaseFormatter(str){
  return str.toLowerCase().replace(/\s/g, "");
}

//validate domain name
function validDomain(str){
return /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9](?:\.[a-zA-Z]{2,})+$/.test(str)
}

//generate mail id from firstname, lastname and domain
function mailIdGenerator(part1, part2, domain){

  if(validDomain(domain)){
    formatted_domain = domain.replace(/https:\/\/|http:\/\//, "").replace(/www\./, "");
    return lowerCaseFormatter(part1) + "." + lowerCaseFormatter(part2) + "@" + formatted_domain;
  }else{
    return "";
  }

}


function flashMessage(message, type){
  $("#flash-message").remove();
  alerts = {
    success: "alert-success",
    error: "alert-error",
    alert: "alert-block",
    notice: "alert-info"
  }

  var template = _.template($("#tmpl_js_flash_message").html());
  $(template({message: message, type: alerts[type]})).insertAfter("#app-header");
}
