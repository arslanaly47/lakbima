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
        $("#journalEntryForm")[0].reset();
        $(".update-journal-entry").on('click', updateJournalEntry);
      }
    });
  });

  $(".update-journal-entry").on('click', updateJournalEntry);
});
