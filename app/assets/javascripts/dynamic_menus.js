$(document).ready(function() {

  var hostname = window.location.origin;

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
