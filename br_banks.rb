require 'net/http'
require 'json'

module BRBank
  
  def self.banks
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/igorcb/banks/master/banks.json').body
  end

  def self.populate
    banks.each do |bank|
      bank = Bank.create_with(codigo: bank["code"], nome: bank["name"]).find_or_create_by(nome: bank["name"])
    end
  end
end

BRBank.populate