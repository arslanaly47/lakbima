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

  function showLeaveApplicationsWithApplicantAndVacationTypeID(options) {
    $(".leave_applications[data-applicant-id=\'" + options["applicantID"] + "\'][data-vacation-type-id=\'"  + options["vacationTypeID"] + "\']").show();
    $(".leave_applications[data-applicant-id!=\'"     + options["applicantID"] + "\']").hide();
    $(".leave_applications[data-vacation-type-id!=\'" + options["vacationTypeID"] + "\']").hide();
  }

  $("#leaveApplicationApplicantsDropdown, #leaveApplicationVacationTypesDropdown").change(function() {
    var promptOption = $(this).find("option[value='']");
    promptOption.remove();
  });

  function showLeaveApplicationsWithApplicantID(applicantID) {
    $(".leave_applications[data-applicant-id=\'"  + applicantID + "\']").show();
    $(".leave_applications[data-applicant-id!=\'" + applicantID + "\']").hide();
  }

  function showLeaveApplicationsWithVacationTypeID(vacationTypeID) {
    $(".leave_applications[data-vacation-type-id=\'"  + vacationTypeID + "\']").show();
    $(".leave_applications[data-vacation-type-id!=\'" + vacationTypeID + "\']").hide();
  }

  $("#leaveApplicationVacationTypesDropdown").change(function() {
    var currentValue = $(this).val();
    var applicantDropdownValue = $("#leaveApplicationApplicantsDropdown").val();

    if (currentValue == "all_types") {
      if (applicantDropdownValue == "all_applicants" || applicantDropdownValue == "") {
        showAllLeaveApplications();
      } else {
        showLeaveApplicationsWithApplicantID(applicantDropdownValue);
      }
    } else {
      if (applicantDropdownValue == "all_applicants" || applicantDropdownValue == "") {
        showLeaveApplicationsWithVacationTypeID(currentValue);
      } else {
        showLeaveApplicationsWithApplicantAndVacationTypeID({
          applicantID: applicantDropdownValue,
          vacationTypeID: currentValue
        });
      }
    }
  });

  $("#leaveApplicationApplicantsDropdown").change(function() {
    var currentValue = $(this).val();
    var vacationTypeDropdownValue = $("#leaveApplicationVacationTypesDropdown").val();

    if (currentValue == "all_applicants") {
      if (vacationTypeDropdownValue == "all_types" || vacationTypeDropdownValue == "") {
        showAllLeaveApplications();
      } else {
        showLeaveApplicationsWithVacationTypeID(vacationTypeDropdownValue);
      }
    } else {
      if (vacationTypeDropdownValue == "all_types" || vacationTypeDropdownValue == "") {
        showLeaveApplicationsWithApplicantID(currentValue);
      } else {
        showLeaveApplicationsWithApplicantAndVacationTypeID({
          applicantID: currentValue,
          vacationTypeID: vacationTypeDropdownValue
        });
      }
    }
  });
});
