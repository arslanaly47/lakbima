$(document).ready(function() {
  var hostname = window.location.origin;

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
    if (url.indexOf('?') >= 0) {
      url = url.replace(/\?.*/, '');
    }
    url += '?date_for_transaction=' + selectedDate;
    window.location.href = url;
  });

  var updateTransaction = function() {
    var $this = $(this);
    $this.ladda();
    $this.ladda('start');
    var dynamic_menu_id = $this.data('dynamic-menu-id');
    var transaction_id  = $this.data('transaction-id');

    var data = $('#updateTransaction' + transaction_id).serialize();

    $.ajax({
      url: hostname + '/dynamic_menus/' + dynamic_menu_id + '/transactions/' + transaction_id,
      type: 'PUT',
      data: data,
      dataType: 'script',
      success: function(data) {
        console.log("The data that I have got back is: " + JSON.stringify(data));
        $this.ladda('stop');
      }
    });
  };

  $('.update-transaction').on('click', updateTransaction);
});
