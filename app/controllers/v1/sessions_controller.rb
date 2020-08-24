class V1::SessionsController < ApplicationController
  before_action :require_signin
  skip_before_action :require_signin, only: [:signin], raise: false

  def signin
    if user = User.valid_signin?(params[:email], params[:password])
      user.allow_token_to_be_used_only_once
      send_token_for_valid_signin_of(user)
      user.update_columns(sign_in_count: user.sign_in_count + 1,
        current_sign_in_at: DateTime.now, current_sign_in_ip: request.remote_ip,
        last_sign_in_at: user.current_sign_in_at, last_sign_in_ip: user.current_sign_in_ip )
    else
      render_unauthorized("unauthorized")
    end
  end

  def signout
    if current_user
      current_user.signout
      json_response({ })
    end
  end

  private

  def send_token_for_valid_signin_of(user)
    json_response({
      id: user.id,
      token: user.token
    })
  end

  def allowed_params
    params.require(:attrs).permit(:email, :password)
  end

end
