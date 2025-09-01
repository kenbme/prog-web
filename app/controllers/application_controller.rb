class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  class UsuarioNotLoggedInError < StandardError; end

  def handle_usuario_not_logged_in
    redirect_to :root, alert: "Usuário não logado"
  end

  def handle_forbidden_error
    redirect_to :root, alert: "Usuário não tem permissão"
  end

  def handle_record_invalid(exception)
    render json: {error: exception.record.errors.full_messages.to_sentence}, status: :unprocessable_entity
  end

  rescue_from UsuarioNotLoggedInError, with: :handle_usuario_not_logged_in

  rescue_from ForbiddenError, with: :handle_forbidden_error

  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  def current_user
    @_current_user ||= Usuario.find_by(id: session[:usuario_id])
    raise UsuarioNotLoggedInError unless @_current_user

    @_current_user
  end
end
