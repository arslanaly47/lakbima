class JournalEntriesController < ApplicationController

  before_action :set_journal_entry_session, only: [:index, :show, :create]

  def index
    @journal_entries = @journal_entry_session.journal_entries
    @journal_entry = JournalEntry.new
  end

  def show
  end

  def create
    @journal_entry = @journal_entry_session.journal_entries.create(journal_entry_params)
    respond_to do |format|
      flash.now[:notice] = "The journal entry has successfully been created, and added to this session."
      format.js
    end
  end

  private

  def journal_entry_params
    params.require(:journal_entry).permit(:happened_at, :amount, :description, :from_account_id, :to_account_id)
  end

  def set_journal_entry_session
    @journal_entry_session = JournalEntrySession.find(params[:journal_entry_session_id])
  end
end
