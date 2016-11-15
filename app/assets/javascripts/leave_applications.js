$(document).on('ready', function() {

  var oneDay         = $("#oneDay");
  var moreThanOneDay = $("#moreThanOneDay");
  var dates  = $("#dates");

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
    format: "mm/dd/yyyy",
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    startDate: new Date()
  };

  dates.bind("DOMSubtreeModified", function() {
    $('.leave-dates.input-group.date').datepicker(optionsForDatePicker);
  });

  $('.leave-dates.input-group.date').datepicker(optionsForDatePicker);
});
