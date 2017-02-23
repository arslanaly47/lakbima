$(document).ready(function() {

  $("#autoGenerateUserPassword").change(function() {
    if($(this).is(":checked")) {
      $("#userCreationPasswordField").val("");
      $("#userCreationPasswordField").prop('disabled', true);
    } else {
      $("#userCreationPasswordField").prop('disabled', false);
    }
  });
});
