class SessionController < ApplicationController
  def login_cliente
    session[:usuario_id] = Usuario.find_by!(cargo: "cliente").id
    render json: {}, status: :ok
  end

  def login_admin
    session[:usuario_id] = Usuario.find_by!(cargo: "admin").id
    render json: {}, status: :ok
  end

  def logout
    session[:usuario_id] = nil
    render json: {}, status: :ok
  end
end
