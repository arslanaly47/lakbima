$(document).ready(function() {
  $("#accountsForm").validate({
    rules: {
      "account[account_id]": {
        required: true,
        range: [1100, 5000]
      },
      "account[name]": {
        required: true,
        minlength: 5,
        maxlength: 100
      },
      "account[description]": {
        required: true,
      }
    }
  });
});
