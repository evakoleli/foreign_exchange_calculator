require 'spec_helper'

describe WelcomeController do
  describe 'results' do
    before do
      @params = {'from_currency' => 'from', 'to_currency' => 'to', 'amount' => '10'}
    end

    context 'check_date' do
      it 'invalid date' do
        @params.merge!({'date' => '18/08/2015'})
        get :result, @params
        expect(response).to redirect_to root_path
      end

      it 'valid date' do
        @params.merge!({'date' => '10/08/2015'})
        date = Date.strptime(@params['date'], "%m/%d/%Y")
        expect(ExchangeRate).to receive(:at).with(date, @params['from_currency'], @params['to_currency'])
        get :result, @params
      end
    end

    context 'exchange_rate returns a rate' do
      before do
        allow(ExchangeRate).to receive(:at).and_return(15.5)
        @params.merge!({'date' => '10/08/2015'})
      end

      it 'result includes the right amount' do
        get :result, @params
        expect(assigns(:value)).to include('155')
      end
    end

    context 'exchange_rate does not return' do
      before do
        allow(ExchangeRate).to receive(:at).and_return(0)
        @params.merge!({'date' => '10/08/2015'})
      end

      it 'result informs the user that the data are not present' do
        get :result, @params
        expect(assigns(:value)).to eq('There is no data for the date you have selected. Please try again')
      end
    end

    context 'exchange_rate raises an error' do
      before do
        allow(ExchangeRate).to receive(:at) {raise 'error'}
        @params.merge!({'date' => '10/08/2015'})
      end

      it 'result informs the user that the data are not present' do
        get :result, @params
        expect(response).to redirect_to root_path
      end
    end
  end
end
