$(document).on('ready', function() {

  var oneDay         = $("#oneDay");
  var moreThanOneDay = $("#moreThanOneDay");
  var dates          = $("#dates");

  if ($("#one-day").is(":checked")) {
    moreThanOneDay.detach();
    dates.append(oneDay);
  } else {
    oneDay.detach();
    dates.append(moreThanOneDay);
  }

  $(".numberOfDays").change(function() {
    if ($(this).attr("id") == "one-day" ) {
      moreThanOneDay.detach();
      dates.append(oneDay);
    } else {
      oneDay.detach();
      dates.append(moreThanOneDay);
    }
  });

  var optionsForDatePicker = {
    format: "dd/mm/yyyy",
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    startDate: new Date()
  };

  dates.bind("DOMSubtreeModified", function() {
    $('.leave-dates.input-group.date').datepicker(optionsForDatePicker);
  });

  $('.leave-dates.input-group.date').datepicker(optionsForDatePicker);

  function showAllLeaveApplications() {
    $('.leave_applications').show();
  }

  function showLeaveApplicationWithVacationTypeID(vacationTypeID) {
    $('.leave_applications[data-vacation-type-id=\''  + vacationTypeID + '\']').show();
    $('.leave_applications[data-vacation-type-id!=\'' + vacationTypeID + '\']').hide();
  }

  $("#leaveApplicationApplicantsDropdown, #leaveApplicationVacationTypesDropdown").change(function() {
    var promptOption = $(this).find("option[value='']");
    promptOption.remove();
  });

  $("#leaveApplicationVacationTypesDropdown").change(function() {
    var currentValue = $(this).val();

    if (currentValue == "all_types") {
      showAllLeaveApplications();
    } else {
      showLeaveApplicationWithVacationTypeID(currentValue);
    }
  });

  function showLeaveApplicationsWithApplicantID(applicantID) {
    $('.leave_applications[data-applicant-id=\''  + applicantID + '\']').show();
    $('.leave_applications[data-applicant-id!=\'' + applicantID + '\']').hide();
  }

  $("#leaveApplicationApplicantsDropdown").change(function() {
    var currentValue = $(this).val();

    if (currentValue == "all_applicants") {
      showAllLeaveApplications();
    } else {
      showLeaveApplicationsWithApplicantID(currentValue);
    }
  });
});
