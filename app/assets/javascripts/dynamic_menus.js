$(document).ready(function() {

  var hostname = window.location.origin;

  $("#dynamicMenuName").on('input properychange paste', function() {
    var $this = $(this);
    var currentName = $(this).val() || "";

    var url = hostname + "/dynamic_menus/check_uniqueness_for_name";
    var data = { currentName: currentName };

    $.ajax({
      url: url,
      type: "GET",
      data: data,
      success: function(data) {
        if(data.result) {
          $("#dynamicMenuSubmit").attr('disabled', false);
          $("#dynamicMenuNameHelpBlock").remove();
          $this.parent().parent().removeClass('has-error');
          $this.removeClass('invalid');
        } else {
          $("#dynamicMenuSubmit").attr('disabled', true);
          if (!$("#dynamicMenuNameHelpBlock").length) {
            var helpBlock = $("<span id='dynamicMenuNameHelpBlock' class='help-block m-b-none'>A dynamic menu with this name already exists.</span>");
            $this.after(helpBlock);
          }
          $this.parent().parent().addClass('has-error');
          $this.addClass('invalid');
        }
      }
    });
  });

  $("#fromAccountTypeSelect").change(function() {
    var toAccountTypeSelect = $("#toAccountTypeSelect");
    var currentlySelectedOptionIDs = $(this).val();

    $.ajax({
      url: hostname + '/dynamic_menus/to_account_type_ids/' + currentlySelectedOptionIDs,
      success: function(data) {
        toAccountTypeSelect.empty();
        toAccountTypeSelect.append(data.options);
      }
    });
  });

  $("#manageDynamicMenus").validate({
    rules: {
      "dynamic_menu[name]": {
        required: true
      },
      "dynamic_menu[description]": {
        required: true
      },
      "dynamic_menu[from_account_type_ids]": {
        required: true
      },
      "dynamic_menu[to_account_type_ids]": {
        required: true
      }
    }
  });
});
