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
      }
    }
  });
});
