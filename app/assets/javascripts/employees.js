//= require datapicker/bootstrap-datepicker.js
//= require validate/jquery.validate.min.js
//= require jasny/jasny-bootstrap.min.js

$(document).ready(function() {
  $('#expiry .input-group.date').datepicker({
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
      "employee[last_name]": {
        email: true
      },
      "employee[username]": {
        minlength: 3,
        maxlength: 20
      },
      "employee[mobile_no]": {

      }

    }
  });
});
