class Emails < ApplicationMailer
  def welcome(person)
    @person = person
    mail to: person.email
  end

  def validate_email(person)
    @person = person
    mail to: person.email
  end

  def admin_user_validated(user)
    @user = user
    mail to: admins.map(&:email)
  end

  def admin_new_user(user)
    @user = user
    mail to: admins.map(&:email)
  end

  def admin_removing_unvalidated_users(users)
    @users = users
    mail to: admins.map(&:email)
  end

  private

  def admins
    @admins ||= Person.admins
  end
end
