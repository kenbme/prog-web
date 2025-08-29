class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  class UsuarioNaoLogadoError < StandardError; end

  def handle_usuario_nao_logado
    redirect_to root_path, alert: "Usuário não logado"
  end

  def handle_forbidden_error
    redirect_to root_path, alert: "Usuário não tem permissão"
  end

  rescue_from UsuarioNaoLogadoError, with: :handle_usuario_nao_logado

  rescue_from ForbiddenError, with: :handle_forbidden_error

  def current_user
    @usuario ||= Usuario.find_by(id: session[:usuario_id])
    raise UsuarioNaoLogadoError unless @usuario

    @usuario
  end
end
