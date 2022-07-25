class Users::SessionsController < Devise::SessionsController
    include ActionController::Helpers
    include ActionController::Flash
    respond_to :json

    def create
      user = User.find_by(email: params[:user][:email].strip.downcase)
      valid_password = if user.present?
                         user.valid_password?(params[:user][:password])
                       else
                         false
                       end
  
      if user.blank?
        render json: { error: 'Such user doesn’t exist' }, status: :not_found
        return
      elsif !valid_password
        render json: { error: 'You entered wrong password' }, status: :forbidden
        return
      end
  
      super
    end
    
    private

    def respond_with(resource, _opts = {})
      render json: {message: "Authorization"}, status: :ok
    end

    def access_denied(exception)
      render json: {message: exception.message}, status: :unauthorized
    end

    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failure
    end

    def log_out_success
      render json: { message: "Logged out." }, status: :ok
    end

    def log_out_failure
      render json: { message: "Logged out failure."}, status: :unauthorized
    end
  end