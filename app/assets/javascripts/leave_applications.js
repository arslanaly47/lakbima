$(document).on('ready nested:fieldAdded', function() {

  var oneDay         = $("#oneDay");
  var moreThanOneDay = $("#moreThanOneDay");
  var saveButtonDiv  = $("#saveButtonDiv");

  moreThanOneDay.detach();
  $(".numberOfDays").change(function() {
    if ($(this).attr("id") == "one-day" ) {
      moreThanOneDay.detach();
      saveButtonDiv.before(oneDay);
    } else {
      oneDay.detach();
      saveButtonDiv.before(moreThanOneDay);
    }
  });
});
