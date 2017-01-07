$(document).ready(function() {

  $("#manageCurrencies").validate({
    rules: {
      "currency[name]": {
        required: true
      },
      "currency[code]": {
        required: true
      },
      "currency[symbol]": {
        required: true
      },
      "currency[country]": {
        required: true
      }
    }
  });

  var hostname = window.location.origin;
  var setDefaultCurrency = $("#setDefaultCurrency").ladda();

  setDefaultCurrency.click(function(event) {
    event.preventDefault();
    var $this = $(this);

    var defaultCurrencyID = $("#currencySelectTag").val();

    if (defaultCurrencyID != "") {
      $this.ladda('start');

      $.ajax({
        type: "POST",
        url: hostname + "/currencies/" + defaultCurrencyID.toString() + "/default",
        success: function(data) {
          $this.ladda('stop');
          $("#defaultCurrencyName").html(data.default_currency_name)
        }
      });
    }

  });
});
