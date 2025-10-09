class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol)
        quote = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
        #quote.price
        company = Alphavantage::Fundamental.new(symbol: ticker_symbol)
        overview = company.overview     

        new(ticker: ticker_symbol, name: overview.name, last_price: quote.price(ticker_symbol))
  end
end
