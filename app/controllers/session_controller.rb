class SessionController < ApplicationController
  def login_cliente
    usuario = Usuario.find_by!(cargo: "cliente")
    session[:usuario_id] = usuario.id
    render json: {session: {usuario:}}, status: :ok
  end

  def login_vendedor
    usuario = Usuario.find_by!(cargo: "vendedor")
    session[:usuario_id] = usuario.id
    render json: {session: {usuario:}}, status: :ok
  end

  def login_admin
    usuario = Usuario.find_by!(cargo: "admin")
    session[:usuario_id] = usuario.id
    render json: {session: {usuario:}}, status: :ok
  end

  def logout
    session[:usuario_id] = nil
    render json: {}, status: :ok
  end
end
