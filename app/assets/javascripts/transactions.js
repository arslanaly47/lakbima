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
