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
});
