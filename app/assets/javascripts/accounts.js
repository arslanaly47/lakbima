$(document).ready(function() {
  $("#accountsForm").validate({
    rules: {
      "account_header": {
        required: true
      },
      "account[name]": {
        required: true,
        minlength: 5,
        maxlength: 100
      },
      "account[description]": {
        required: true
      },
      "account[account_type_id]": {
        required: true
      }
    }
  });

  $("#accountHeaderSelectTag").change(function() {
    var $this = $(this);
    var accountSubType  = $("#accountSubTypeSelectTag");
    var accountType = $("#accountTypeSelectTag");
    var accountHeaderID = $this.val();
    var parentFormGroup = accountSubType.parent().parent();

    accountSubType.prop("disabled", true);
    accountType.prop("disabled", true);

    $("#accountHeaderHelpBlock").remove();
    parentFormGroup.removeClass('has-error');


    $.ajax({
      type:  'GET',
      url:   '/account_headers/' + accountHeaderID + '/account_sub_headers',
      success: function() {
        accountSubType.prop("disabled", false);
        accountType.prop("disabled", false);
      },
      error: function() {
        var helpBlock = $("<span id='accountHeaderHelpBlock' class='help-block m-b-none'>Error: Sub categories couldn't be fetched.</span>");
        accountSubType.after(helpBlock);
        parentFormGroup.addClass('has-error');
      }
    });
  });

  $("#accountSubTypeSelectTag").change(function() {
    var $this = $(this);
    var accountType = $("#accountTypeSelectTag");
    var accountSubHeaderID = $this.val();
    var parentFormGroup = accountType.parent().parent();

    accountType.prop("disabled", true);

    $("#accountSubTypeHelpBlock").remove();
    parentFormGroup.removeClass('has-error');


    $.ajax({
      type:  'GET',
      url:   '/account_sub_headers/' + accountSubHeaderID + '/account_lists',
      success: function() {
        accountType.prop("disabled", false);
      },
      error: function() {
        var helpBlock = $("<span id='accountSubTypeHelpBlock' class='help-block m-b-none'>Error: Account Lists couldn't be fetched.</span>");
        accountType.after(helpBlock);
        parentFormGroup.addClass('has-error');
      }
    });
  });
});
