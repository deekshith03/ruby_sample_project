module Api
  module V1
    class PeopleController < ApplicationController
      def index
        render :index
      end

      def create
        person = Person.new(person_params)
        if person.save
          redirect_to api_v1_people_path(person), notice: 'Account added!'
        else
          render :new
        end
      end

      def validate_email
        return unless user.present?

        user.validated = true
        return unless user.save!

        Rails.logger.info "USER: User ##{user.id} validated email successfully."
        Emails.welcome(user).deliver_later(wait_until: 1.seconds.from_now)
        Emails.admin_user_validated(user).deliver_later(wait_until: 2.seconds.from_now)
      end

      private

      def person_params
        params.permit(:first_name, :last_name, :email)
      end

      def user
        @user ||= Person.find_by_slug(params[:slug])
      end
    end
  end
end
