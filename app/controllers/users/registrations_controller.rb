class Users::RegistrationsController < Devise::RegistrationsController
    include ActionController::Helpers
    include ActionController::Flash
    before_action :configure_permitted_parameters
    respond_to :json

    def create 
      params[:user][:email] = params[:user][:email].strip.downcase
      user = User.find_by(email: params[:user][:email])
      if user.present?
        render json: { error: 'An account with this email already exists' }, status: :conflict
        return
      end

      super
    end

    private
    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end
    def register_success
      render json: { message: 'Signed up.' }
    end
    def register_failed
      render json: { message: "Signed up failure." }
    end
    
    protected
    def configure_permitted_parameters
      attributes = %i[email password role first_name last_name]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    end
  end