//= require datapicker/bootstrap-datepicker.js
//= require validate/jquery.validate.min.js
//= require jasny/jasny-bootstrap.min.js
//= require slick/slick.min.js

$(document).on('ready nested:fieldAdded', function() {
  var hostname = window.location.origin;
  //toastr.success("Such a pleasure that you read it.", "Big Title");
  var optionsForDatePicker = {
    format: "mm/dd/yyyy",
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    autoclose: true
  };

  $('#dateOfJoining.input-group.date').datepicker(optionsForDatePicker);
  $('#passportExpiry.input-group.date').datepicker(optionsForDatePicker);
  $('#visaExpiry.input-group.date').datepicker(optionsForDatePicker);
  $('#medicalExpiry.input-group.date').datepicker(optionsForDatePicker);
  $('#appointmentDate.input-group.date').datepicker(optionsForDatePicker);
  $('.vacation-dates.input-group.date').datepicker(optionsForDatePicker);
  $('.journal-entry-happened-at .input-group.date').datepicker(optionsForDatePicker);
  $('#transactionHappenedAt').datepicker(optionsForDatePicker);

  $("#manageEmployee").validate({
    rules: {
      "employee[first_name]": {
        minlength: 3,
        maxlength: 100,
        required: true
      },
      "employee[last_name]": {
        minlength: 3,
        maxlength: 100,
        required: true
      },
      "role_id": {
        required: true
      },
      "employee[job_title_id]": {
        required: true
      },
      "employee[branch_id]": {
        required: true
      },
      "employee[nationality]": {
        required: true
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

  $("#employeeUsername").on('input properychange paste', function() {
    var $this = $(this);
    var currentText = $(this).val() || "";

    var url = hostname + "/users/check_uniqueness/";
    var data = { username: currentText };

    $.ajax({
      url: url,
      type: "GET",
      data: data,
      success: function(data) {
        if(data.result) {
          $("#usernameHelpBlock").remove();
          $this.parent().parent().removeClass('has-error');
          $this.removeClass('invalid');
        } else {
          if (!$("#usernameHelpBlock").length) {
            var helpBlock = $("<span id='usernameHelpBlock' class='help-block m-b-none'>This username has already been taken.</span>");
            $this.after(helpBlock);
          }
          $this.parent().parent().addClass('has-error');
          $this.addClass('invalid');
        }
      }
    });
  });
});

$(document).on('ready', function() {
  $("div[id^='links-']").each(function(index) {
    $(this).click(function(event) {
      event = event || window.event;
      var target = event.target || event.srcElement,
        link  = target.src ? target.parentNode : target,
        options = { index: link, event: event },
        links = this.getElementsByTagName('a');
      blueimp.Gallery(links, options);
    });
  });
});
