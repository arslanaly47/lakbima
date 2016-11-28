class JournalEntrySessionsController < ApplicationController

  def create
    journal_entry_session = current_user.journal_entry_sessions.create
    redirect_to journal_entry_session_journal_entries_path(journal_entry_session)
  end

  def close
  end
end
