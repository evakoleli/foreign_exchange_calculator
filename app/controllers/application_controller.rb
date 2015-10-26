class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_available_currencies

  def load_available_currencies
    @currencies = ExchangeRate.get_currencies
  end
end
