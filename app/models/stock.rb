class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true
  def self.new_lookup(ticker_symbol)

    quote = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote

    company = Alphavantage::Fundamental.new(symbol: ticker_symbol)
    overview = company.overview     
    #quote != nil
    if true
      new(ticker: ticker_symbol, name: overview.name, last_price: quote.price(ticker_symbol))
      # new(ticker: "MSFT", name: "Microsoft Corporation", last_price: 0.5224e3)
  
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
