class SeedPermissionsForManager

  def call
    seed_permissions
    seed_permissions_for_leave_application
  end

  private

  def seed_permissions
    actions = %w(Create Update View)
    models = %w(AccountMainType AccountSubType AccountType Account AllowanceType AttachmentType Company Currency Department DynamicMenu Employee JobTitle JournalEntry JournalEntrySession Role Transaction User VacationType)
    actions.each do |action|
      models.each do |model|
        Permission.find_or_create_by(subject_class: model, action: action)
      end
    end
    Permission.find_or_create_by(subject_class: 'Employee', action: 'download_pdf')
    Permission.find_or_create_by(subject_class: 'AccountMainType', action: 'account_sub_headers')
    Permission.find_or_create_by(subject_class: 'AccountSubType', action: 'account_lists')
    Permission.find_or_create_by(subject_class: 'Account', action: 'account_tree')
    Permission.find_or_create_by(subject_class: 'Account', action: 'balance_sheet')
    Permission.find_or_create_by(subject_class: 'Account', action: 'view')
  end

  def seed_permissions_for_leave_application
    %w(Approve Deny View).each do |action|
      Permission.find_or_create_by(subject_class: 'LeaveApplication', action: action)
    end
  end
end
