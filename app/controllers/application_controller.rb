class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  def current_user
    @nome ||= Usuario.find_by!(nome: "João")
  end
end
