class WelcomeController < ApplicationController

  before_filter :check_date, only: [:result]

  def index
    respond_to do |format|
      format.html {render layout: 'application'}
    end 
  end

  def result
    from_currency = params["from_currency"]
    to_currency = params["to_currency"] 
    amount = params["amount"].to_f
    begin
      rate = ExchangeRate.at(@date, from_currency, to_currency)
      unless rate == 0
        @value = "On #{@date}, you can buy #{(amount * rate)} #{to_currency} with #{amount} #{from_currency}"
      else
        @value = 'There is no data for the date you have selected. Please try again'
      end
      respond_to do |format|
        format.html {render layout: 'application'}
      end 
    rescue
      redirect_to(root_path, alert: 'Invalid parameters. Please try again...')
    end
  end

  private

  def check_date
    begin
      @date = Date.strptime(params["date"], "%m/%d/%Y")
    rescue 
      redirect_to(root_path, alert: 'Invalid date')
    end
  end
end
