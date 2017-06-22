$(document).ready(function() {

  $.validator.addMethod('lowerCaseLetters', function(value) {
    return value.match(/^[a-z/-]+$/);
  }, "You must use only lowercase letters, and '-'");

  $("#manageCompany").validate({
    rules: {
      "company[subdomain]": {
        lowerCaseLetters: true,
        minlength: 3,
        maxlength: 15,
        required: true
      },
      "company[commercial_registration_expiry]": {
        australianDate: true,
        date: false
      },
      "company[municipality_registration_expiry]": {
        australianDate: true,
        date: false
      }
    }
  });
});
