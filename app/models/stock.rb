class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.IEX[:token],
                              endpoint: 'https://sandbox.iexapis.com/v1')

    begin
      new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))                      
    rescue => exception
      return nil
    end  
  end

end
