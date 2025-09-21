class SessionController < ApplicationController
  def login_cliente
    usuario = Usuario.find_by!(cargo: "cliente")
    session[:usuario_id] = usuario.id
    redirect_to root_path
  end

  def login_vendedor
    usuario = Usuario.find_by!(cargo: "vendedor")
    session[:usuario_id] = usuario.id
    redirect_to root_path
  end

  def login_admin
    usuario = Usuario.find_by!(cargo: "admin")
    session[:usuario_id] = usuario.id
    redirect_to root_path
  end

  def logout
    session[:usuario_id] = nil
    redirect_to root_path
  end
end
