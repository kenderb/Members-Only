class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :display_user
  helper_method :display_button
  helper_method :user_status

  def display_button(current_user)
    if current_user.present?
      return "<a href=#{destroy_user_session_path} data-method='delete' rel='nofollow'> Log out </a>".html_safe
    end

    "<a href=#{new_user_session_path}> Log in </a>".html_safe
  end

  def display_user(username, post_author)
    return post_author.username if username

    'Not a member'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
