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
    forceParse: false,
    autoclose: true
  };

  var optionsForTransactionDate = $.extend(optionsForDatePicker, {
    todayHighlight: true
  });

  $('#dateOfJoining.input-group.date').datepicker(optionsForDatePicker);
  $('#passportExpiry.input-group.date').datepicker(optionsForDatePicker);
  $('#visaExpiry.input-group.date').datepicker(optionsForDatePicker);
  $('#medicalExpiry.input-group.date').datepicker(optionsForDatePicker);
  $('#appointmentDate.input-group.date').datepicker(optionsForDatePicker);
  $('.vacation-dates.input-group.date').datepicker(optionsForDatePicker);
  $('.journal-entry-happened-at .input-group.date').datepicker(optionsForDatePicker);
  $('#transactionHappenedAt.input-group.date').datepicker(optionsForTransactionDate);
  $('.allowance-start.input-group.date').datepicker(optionsForDatePicker);
  $('.allowance-end.input-group.date').datepicker(optionsForDatePicker);
  
  $.validator.addMethod(
    "australianDate",
    function(value, element) {
      return value.match(/^\d\d?\/\d\d?\/\d\d\d\d$/);
    },
    "Please enter a valid date"
  );


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
      },
      "employee[date_of_joining]": {
        australianDate : true
      },
      "employee[passport_expiry]": {
        australianDate : true
      },
      "employee[visa_expiry]": {
        australianDate : true
      },
      "employee[medical_expiry]": {
        australianDate : true
      },
      "employee[appointment_date]": {
        australianDate : true
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

  var terminateAnEmployee = function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var employeeID = $this.data('employee-id');

    var url = hostname + "/employees/" + employeeID.toString() + "/terminate";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        if (data.success) {
          $this.text('Unterminate');
          $this.data('confirm', "Are you sure you want to unterminate this employee?");
          $this.removeClass('btn-danger');
          $this.removeClass('terminate-employee');
          $this.addClass('btn-primary');
          $this.addClass('unterminate-employee');
          $this.unbind('click');
          $this.bind('click', unterminateAnEmployee);
        }
      }
    });
  };

  var unterminateAnEmployee = function(event) {
    event.preventDefault();
    var $this = $(this);
    $this.ladda('start');
    var employeeID = $this.data('employee-id');

    var url = hostname + "/employees/" + employeeID.toString() + "/unterminate";

    $.ajax({
      type: "POST",
      url: url,
      success: function(data) {
        $this.ladda('stop');
        if (data.success) {
          $this.text('Terminate');
          $this.data('confirm', "Are you sure you want to terminate this employee?");
          $this.removeClass('btn-primary');
          $this.removeClass('unterminate-employee');
          $this.addClass('btn-danger');
          $this.addClass('terminate-employee');
          $this.unbind('click');
          $this.bind('click', terminateAnEmployee);
        }
      }
    });
  };

  var terminateButton, unterminateButton;

  if ($(".terminate-employee").length) {
    terminateButton = $(".terminate-employee").ladda();
    terminateButton.click(terminateAnEmployee);
  } else {
    unterminateButton = $(".unterminate-employee").ladda();
    unterminateButton.click(unterminateAnEmployee);
  }

  function showCurrentEmployees() {
    $('.current-employees').removeClass('hidden');
    $('.current-employees').show();
    $('.past-employees').hide();
    $('.future-employees').hide();
  }

  function showPastEmployees() {
    $('.past-employees').removeClass('hidden');
    $('.past-employees').show();
    $('.current-employees').hide();
    $('.future-employees').hide();
  }

  function showFutureEmployees() {
    $('.future-employees').removeClass('hidden');
    $('.future-employees').show();
    $('.past-employees').hide();
    $('.current-employees').hide();
  }

  var allEmployees = $('.employees:visible');

  $(".employee-display").change(function() {
    if($(this).val() == "Current") {
      $("#downloadValue").val("Current");
      showCurrentEmployees();
      allEmployees = $('.employees:visible');
      return;
    }
    if($(this).val() == "Past") {
      $("#downloadValue").val("Past");
      showPastEmployees();
      allEmployees = $('.employees:visible');
      return;
    }
    if($(this).val() == "Future") {
      $("#downloadValue").val("Future");
      showFutureEmployees();
      allEmployees = $('.employees:visible');
      return;
    }
  });


  $("#searchEmployees").on('input properychange paste', function() {
    var $this = $(this);

    var searchText = $this.val();
    if(searchText == "") {
      allEmployees.show();
    } else {
      var firstName, lastName;
      allEmployees.each(function() {
        firstName = $(this).find('.first-name').html();
        lastName  = $(this).find('.last-name').html();

        searchTextRegExp = new RegExp(searchText, "i");
        if((firstName.match(searchTextRegExp) == null) && (lastName.match(searchTextRegExp) == null)) {
          $(this).hide();
        } else {
          $(this).show();
        }
      });
    }
  });

  $("#pdfDownload").click(function(){
    setTimeout(function () {
      $("#pdfDownload").prop("disabled", false);
    }, 500);
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
