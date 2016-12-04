$(document).ready(function() {

  var hostname = window.location.origin;

  var updateJournalEntry = function() {
    var $this = $(this);
    $this.ladda();
    $this.ladda('start');
    var journal_entry_session_id = $this.data("journal-entry-session-id");
    var journal_entry_id         = $this.data("journal-entry-id");

    var data = $("#journalEntryForm" + journal_entry_id).serialize();

    $.ajax({
      url: hostname + "/journal_entry_sessions/" + journal_entry_session_id + "/journal_entries/" + journal_entry_id,
      type: "PUT",
      data: data,
      success: function() {
        $this.ladda('stop');
      }
    });
  };

  var enableChangeInDropdown = function() {
    var $this = $(this);

    var journalEntryToAccount = $this.parent().next().find('.journal-entry-to-account')
    journalEntryToAccount.attr('disabled', 'disabled');

    $.ajax({
      url: "/journal_entries/build_options",
      data: { id: $this.val() },
      success: function(data) {
        journalEntryToAccount.removeAttr('disabled');
        journalEntryToAccount.empty();
        journalEntryToAccount.append(data.options);
      }
    });
  };

  $("#saveJournalEntry").on('click', function() {
    var $this = $(this);
    $this.ladda();
    $this.ladda('start');
    var data = $("#journalEntryForm").serialize();

    var journal_entry_session_id = $this.data("journal-entry-session-id");

    $.ajax({
      url: hostname + "/journal_entry_sessions/" + journal_entry_session_id + "/journal_entries",
      type: "POST",
      data: data,
      success: function() {
        $this.ladda('stop');
        $(".update-journal-entry").on('click', updateJournalEntry);
        $(".journal-entry-from-account").change(enableChangeInDropdown);
      }
    });
  });

  $(".update-journal-entry").on('click', updateJournalEntry);
  $("#journalEntryTableBody").bind("DOMSubtreeModified", function() {
    $("#journalEntryForm")[0].reset();
  });

  $(".journal-entry-from-account").change(enableChangeInDropdown);
});
