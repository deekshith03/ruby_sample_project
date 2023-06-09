namespace :accounts do
  desc 'Remove accounts where the email was never validated and it is over 30 days old'
  task remove_unvalidated: :environment do
    people = Person.expired
    people.each do |person|
      Rails.logger.info "Removing unvalidated user #{person.email}"
      person.destroy
    rescue StandardError => e
      Rails.logger.error "Error removing unvalidated user #{person.id}: #{e.message}"
    end
    Emails.admin_removing_unvalidated_users(people).deliver_now
  end
end
