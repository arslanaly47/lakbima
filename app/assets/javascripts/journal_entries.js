$(document).ready(function() {

  var saveJournalEntry = $("#saveJournalEntry").ladda();

  $("#saveJournalEntry").on('click', function() {
    var $this = $(this);
    $this.ladda('start');
    var hostname = window.location.origin;
    var data = $("#journalEntryForm").serialize();

    var journal_entry_session_id = $this.data("journal-entry-session-id");

    $.ajax({
      url: hostname + "/journal_entry_sessions/" + journal_entry_session_id + "/journal_entries",
      type: "POST",
      data: data,
      success: function() {
        $this.ladda('stop');
      }
    });
  });
});
