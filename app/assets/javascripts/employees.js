//= require datapicker/bootstrap-datepicker.js
//= require validate/jquery.validate.min.js
//= require jasny/jasny-bootstrap.min.js

$(document).on('ready nested:fieldAdded', function() {
  $('.input-group.date').datepicker({
    format: "mm/dd/yyyy",
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true
  });

  $("#manageEmployee").validate({
    rules: {
      "employee[first_name]": {
        minlength: 3,
        maxlength: 100
      },
      "employee[last_name]": {
        minlength: 3,
        maxlength: 100
      },
      "employee[username]": {
        minlength: 3,
        maxlength: 20
      },
      "employee[mobile_no]": {

      }

    }
  });

  $("#departmentSelect").change(function() {
    var $this = $(this);
    var department_id = $this.val();
    var parentFormGroup = $this.parent().parent();

    $("#departmentHelpBlock").remove();
    parentFormGroup.removeClass('has-error');


    $.ajax({
      type:  'GET',
      url:   '/departments/' + department_id + '/job_titles',
      error: function() {
        var helpBlock = $("<span id='departmentHelpBlock' class='help-block m-b-none'>Job titles couldn't be fetched. There is something wrong with the internent.</span>");
        $this.after(helpBlock);
        parentFormGroup.addClass('has-error');
      }
    });
  });
});
