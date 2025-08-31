class HomeController < ApplicationController
  def perfil
    render "perfil", locals: {usuario: current_user}
  end
end
