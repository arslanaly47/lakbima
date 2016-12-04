class JournalEntrySessionsController < ApplicationController

  def create
    journal_entry_session = current_user.journal_entry_sessions.create
    redirect_to journal_entry_session_journal_entries_path(journal_entry_session)
  end

  def close
    journal_entry_session = current_user.journal_entry_sessions.find(params[:id])
    if journal_entry_session
      journal_entry_session.close!
      redirect_to root_path, notice: "The session has been closed."
    end
  end
end
