module Api
  module V1
    class PeopleController < ApplicationController
      def create
        person = Person.new(person_params)
        if person.save
          redirect_to person, notice: 'Account added!'
        else
          render json: { messages: person.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def validate_email
        return unless user.present?

        user.validated = true
        return unless user.save!

        Rails.logger.info "USER: User ##{user.id} validated email successfully."
        Emails.admin_user_validated
        Emails.welcome(user).deliver!
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
