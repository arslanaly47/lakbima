class SeedPermissionsForManager

  def call
    seed_permissions
    seed_permissions_for_leave_application
  end

  private

  def seed_permissions
    actions = %w(create update view)
    models = %w(AccountMainType AccountSubType AccountType Account AllowanceType AttachmentType Company Currency Department DynamicMenu Employee JobTitle JournalEntry JournalEntrySession Role Transaction User VacationType)
    actions.each do |action|
      models.each do |model|
        Permission.find_or_create_by(subject_class: model, action: action)
      end
    end
  end

  def seed_permissions_for_leave_application
    %w(approve deny view).each do |action|
      Permission.find_or_create_by(subject_class: 'LeaveApplication', action: action)
    end
  end
end
