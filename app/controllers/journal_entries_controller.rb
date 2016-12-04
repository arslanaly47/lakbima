class JournalEntriesController < ApplicationController

  before_action :set_journal_entry_session, only: [:index, :show, :create, :update, :destroy]
  helper_method :sort_column

  def index
    @journal_entries = @journal_entry_session.journal_entries.order(sort_column + " " + sort_direction)
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

  def update
    @journal_entry = @journal_entry_session.journal_entries.find(params[:id])
    @journal_entry && @journal_entry.update_attributes(journal_entry_params)
    respond_to do |format|
      flash.now[:notice] = "The journal entry has successfully been updated."
      format.js
    end
  end

  def destroy
    @journal_entry = @journal_entry_session.journal_entries.find(params[:id])
    @journal_entry && @journal_entry.destroy
    respond_to do |format|
      flash.now[:notice] = "The journal entry has been deleted."
      format.js
    end
  end

  def build_options
    account = Account.find_by_id(params[:id])
    remaining_accounts = (Account.all - [account]).map { |a| [a.id, a.name] }
    remaining_options = "<option value>Please choose TO account.</option>"
    remaining_accounts.each do |remaining_account|
      remaining_options << "<option value=\"#{remaining_account[0]}\">#{remaining_account[1]}</option>"
    end
    render json: { options: remaining_options }
  end

  private

  def journal_entry_params
    params.require(:journal_entry).permit(:happened_at, :amount, :description, :from_account_id, :to_account_id)
  end

  def set_journal_entry_session
    @journal_entry_session = JournalEntrySession.find(params[:journal_entry_session_id])
  end

  def sort_column
    JournalEntry.column_names.include?(params[:sort])? params[:sort] : "id"
  end
end
