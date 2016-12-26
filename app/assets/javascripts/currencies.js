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
});
