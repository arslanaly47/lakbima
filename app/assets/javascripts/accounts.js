$(document).ready(function() {
  $("#accountsForm").validate({
    rules: {
      "account[name]": {
        required: true,
        minlength: 5,
        maxlength: 100
      },
      "account[description]": {
        required: true
      },
      "account[account_sub_type_id]": {
        required: true
      }
    }
  });

  $("#accountHeaderSelectTag").change(function() {
    var $this = $(this);
    var accountSubType  = $("#accountSubTypeSelectTag");
    var accountHeaderID = $this.val();
    var parentFormGroup = accountSubType.parent().parent();

    accountSubType.prop("disabled", true);

    $("#accountHeaderHelpBlock").remove();
    parentFormGroup.removeClass('has-error');


    $.ajax({
      type:  'GET',
      url:   '/account_headers/' + accountHeaderID + '/account_sub_types',
      success: function() {
        accountSubType.prop("disabled", false);
      },
      error: function() {
        var helpBlock = $("<span id='#accountHeaderHelpBlock' class='help-block m-b-none'>Error: Sub categories couldn't be fetched.</span>");
        accountSubType.after(helpBlock);
        parentFormGroup.addClass('has-error');
      }
    });
  });
});
