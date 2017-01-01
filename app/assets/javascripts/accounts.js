$(document).ready(function() {

  var hostname = window.location.origin;

  function emptyOptionTagsFor(element) {
    element.find('option').remove();
  }

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
    var accountHeaderID = $this.val();

    emptyOptionTagsFor($("#accountSubTypeSelectTag"));
    emptyOptionTagsFor($("#accountTypeSelectTag"));

    if (accountHeaderID != "") {
      var accountSubType  = $("#accountSubTypeSelectTag");
      var accountType = $("#accountTypeSelectTag");
      var parentFormGroup = accountSubType.parent().parent();

      accountSubType.prop("disabled", true);
      accountType.prop("disabled", true);

      $("#accountHeaderHelpBlock").remove();
      parentFormGroup.removeClass('has-error');

      $.ajax({
        type:  'GET',
        url:   hostname + '/account_headers/' + accountHeaderID + '/account_sub_headers',
        success: function() {
          accountSubType.prop("disabled", false);
        },
        error: function() {
          var helpBlock = $("<span id='accountHeaderHelpBlock' class='help-block m-b-none'>Error: there are no associated records.</span>");
          accountSubType.after(helpBlock);
          parentFormGroup.addClass('has-error');
        }
      });
    }
  });

  $("#accountSubTypeSelectTag").change(function() {
    var $this = $(this);
    var accountSubHeaderID = $this.val();
    emptyOptionTagsFor($("#accountTypeSelectTag"));

    if (accountSubHeaderID != "") {
      var accountType = $("#accountTypeSelectTag");
      var parentFormGroup = accountType.parent().parent();

      accountType.prop("disabled", true);

      $("#accountSubTypeHelpBlock").remove();
      parentFormGroup.removeClass('has-error');


      $.ajax({
        type:  'GET',
        url:   hostname + '/account_sub_headers/' + accountSubHeaderID + '/account_lists',
        success: function() {
          accountType.prop("disabled", false);
        },
        error: function() {
          var helpBlock = $("<span id='accountSubTypeHelpBlock' class='help-block m-b-none'>Error: there are no associated records.</span>");
          accountType.after(helpBlock);
          parentFormGroup.addClass('has-error');
        }
      });
    }
  });
});
