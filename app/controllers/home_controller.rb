class HomeController < ApplicationController
  def minha_conta
    render "minha_conta", locals: {usuario: current_user}
  end
end
