class Person < ApplicationRecord
  enum team: { laser_scorpions: 0, unicorn_rainbows: 1 }

  validates :first_name, :last_name, :email, presence: true
  after_create :update_other_details

  scope :admins, -> { where(admin: true) }
  scope :expired, -> { where('people.created_at < ? AND validated = ? ', Date.current.to_time - 30.days, false) }

  private

  def update_other_details
    total_people = Person.count
    slug = "ABC123#{Time.now.to_i}1239827#{rand(10_000)}"
    ## removed total_people + 1 here because we are updating the recording only after save so we the count will become 1 more than old version of code
    team = total_people.odd? ? Person.teams[:unicorn_rainbows] : Person.teams[:laser_scorpions]
    self.slug = slug
    self.team = team
    self.handle = "#{Person.teams.key(team).camelize}#{total_people}"
    save!
    Emails.validate_email(self).deliver_later(wait_until: 2.seconds.from_now)
    Emails.admin_new_user(self).deliver_later(wait_until: 4.seconds.from_now)
  end
end
