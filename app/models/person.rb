class Person < ApplicationRecord
  attr_accessor :first_name, :last_name, :email, :admin, :slug, :validated, :handle, :team

  enum team: { laser_scorpions: 0, unicorn_rainbows: 1 }

  validates :first_name, :last_name, :email, presence: true
  after_create :update_other_details

  scope :admins, -> { where(admin: true) }
  scope :expired, -> { where('people.created_at < ? AND validated = ? ', Date.current.to_time - 30.days, false) }

  private

  def update_other_details
    total_people = Person.count
    slug = "ABC123#{Time.now.to_i}1239827#{rand(10_000)}"
    team = (total_people + 1).odd? ? Person.teams[:unicorn_rainbows] : Person.teams[:laser_scorpions]
    self.slug = slug
    self.team = team
    self.handle = "#{Person.teams.key(team).camelize}#{total_people + 1}"
    Emails.validate_email(self).deliver!
    Emails.admin_new_user(self).deliver!
  end
end
