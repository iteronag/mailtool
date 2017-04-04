var og_statuses = ['New', 'Rejected', 'Hold', 'Mailed', 'Reminder'];
var og_datatable ;
$(document).ready(function(){

  // var phones = [{ "mask": "(###) ###-####"}, { "mask": "(###) ###-#######"}];
  // $('#opportunity_generator_phone_number').inputmask({
  //     mask: phones,
  //     greedy: false,
  //     definitions: { '#': { validator: "[0-9]", cardinality: 1}} });

  // Setup - add a text input to each footer cell
  $('#datatable tfoot th').each( function () {
      var title = $(this).text();
      // if(title != ""){
      // // if($.inArray( title, ["Company","Website","Mail","Is hr or info","Phone number","Technology","Generated date","Status","Group"]) > 0){
      //   $(this).html( '<input type="text" class="search-box" placeholder="'+title+'" />' );
      // }else{
      //   $(this).html( '' );
      // }
  } );


  og_datatable = $('#datatable').DataTable({
    "scrollX": true,
    scrollCollapse: true,
    "iDisplayLength": 50,
    "sScrollY": "600px",
    "columnDefs": [
      {
      "targets": [ 0, 1 ],
      "visible": false,
      "searchable": false
      },
      {
        "targets": [2],
        "render": function ( data, type, row ) {
          return ("<a href='/opportunity_generators/" + row[0] + "/edit'>" + data + "</a>");
        }
      },
      {
        "targets": [3],
        "render": function ( data, type, row ) {
          return ("<a target='_blank' href='http://" + data + "'>" + data + "</a>");
        }
      },
      {
        targets: [15],
        "render": function(d,t,r){
          var $select = $("<select></select>", {
              "id": r[0]+"start",
                "value": d
            });
          $.each(og_statuses, function(k,v){
              var $option = $("<option></option>", {
                  "text": v,
                    "value": v
                });
                if(d === v){
                  $option.attr("selected", "selected")
                }
              $select.append($option);
            });
            return $select.prop("outerHTML");
        }
      }
    ],
    dom: 'TB<"clear">lfrtip',
    buttons: [ 'csv' ],
    tableTools: {
        "sRowSelect": "multi",
        "aButtons": [ "select_all", "select_none" ]
    }
  });
  $(".update_status").click(function(e){
    e.preventDefault();
    var ids = {}
    $.map(og_datatable.rows('.selected').data(), function (item) {
      ids[item[0]] = item[1];
    });
    // $("#ids").val(ids);
    // $("#status").val($(this).val());
      $.ajax({
      type: "post",
      url: "/opportunity_generators/update_status",
      dataType: "json",
      data: {ids: ids, status: $(this).val()},
      success: function(responseData, textStatus, jqXHR) {
        var og_datatable = $('#datatable').dataTable().api();
        og_datatable.clear();
        new_data = []
        $.each(responseData.opportunity_generators, function(i, opportunity_generator){
          new_data .push([
                           opportunity_generator.id, opportunity_generator.template_id,
                           opportunity_generator.company, opportunity_generator.website,
                           opportunity_generator.first_name, opportunity_generator.last_name,
                           opportunity_generator.mail_id, opportunity_generator.is_hr_or_info,
                           opportunity_generator.generated_mail_id1, opportunity_generator.generated_mail_id2,
                           opportunity_generator.phone_number, opportunity_generator.technology,
                           opportunity_generator.job_url, opportunity_generator.linkedin_url,
                           opportunity_generator.generated_date, opportunity_generator.status,
                           opportunity_generator.version, opportunity_generator.ageing,
                           opportunity_generator.group_name
                         ])
        });
        og_datatable.rows.add(new_data);
        og_datatable.draw();

        $(".navbar-inverse").after('<div class="alert alert-info fade in"> <button data-dismiss="alert" class="close">×</button>' + responseData.message + '</div>');
      },
      error: function(jqXHR, textStatus, errorThrown) {

      }
    });
  });

$('#datatable tfoot tr').insertAfter($('#datatable thead tr'))

  $("#opportunity_generator_mail_id, #opportunity_generator_first_name, #opportunity_generator_last_name, #opportunity_generator_website").on("blur", function(){
    gemerateEmailfromName($("#opportunity_generator_mail_id").val(), $("#opportunity_generator_is_hr_or_info").is(":checked"));
  });

  $('#opportunity_generator_is_hr_or_info').change(function() {
    gemerateEmailfromName($("#opportunity_generator_mail_id").val(), $(this).is(":checked"));
  });

  $("#opportunity_generator_job_title").keyup(function(){
    text = $(this).val();

    if (text.length > 20){
      $(this).val(text.substring(0,20));
    }
  });
});

function gemerateEmailfromName(mailId, isHrInfo){

  if ((validateEmail(mailId) && validHrOrInfoEmail(mailId)) || isHrInfo){
    var fname = $("#opportunity_generator_first_name").val();
    var lname = $("#opportunity_generator_last_name").val();
    var domain = $("#opportunity_generator_website").val();
    $("#opportunity_generator_is_hr_or_info").prop("checked", true);
    $("#opportunity_generator_generated_mail_id1").val(mailIdGenerator(fname, lname, domain));//.prop('readonly', true);
    $("#opportunity_generator_generated_mail_id2").val(mailIdGenerator(lname, fname, domain));//.prop('readonly', true);
  }else{
    $("#opportunity_generator_is_hr_or_info").prop("checked", false);
    $("#opportunity_generator_generated_mail_id1").val("").prop('readonly', false);
    $("#opportunity_generator_generated_mail_id2").val("").prop('readonly', false);
  }
}


//some needed code
/*
to show export buttons in group
    dom: 'TB<"clear">lfrtip',
    buttons: [
      {
      extend: 'collection',
      text: 'Export',
      buttons: [
        'excel',
        'csv',
        'pdf'
      ]
      }

    ],
*/