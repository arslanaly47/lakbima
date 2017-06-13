$(document).ready(function() {
  $("#manageTransactions").validate({
    rules: {
      "transaction[from_account_id]": {
        required: true
      },
      "transaction[to_account_id]": {
        required: true
      },
      "transaction[amount]": {
        required: true
      },
      "transaction[happened_at]": {
        required: true
      }
    }
  });


  $("#dateForTransactions").on('changeDate', function() {
    var selectedDate = $(this).val();
    var url = window.location.href;
    if (url.indexOf('?') > 0) {
      url.replace(/\?.*/, '');
    }
    url += '?date_for_transaction=' + selectedDate;
    window.location.href = url;
  });
});
