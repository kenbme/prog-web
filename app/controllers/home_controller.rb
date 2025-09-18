class HomeController < ApplicationController
  def index
    render "index", locals: {usuario: current_user}, status: :ok
  end

  def perfil
    render "perfil", locals: {usuario: current_user}, status: :ok
  end

  def contato
    render "contato", locals: {usuario: current_user}, status: :ok
  end
end
