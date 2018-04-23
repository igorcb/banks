require 'net/http'
require 'json'

module BRBank
  
  def self.banks
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/igorcb/banks/master/banks.json').body
  end

  def self.populate
    banks.each do |bank|
      bank = Bank.create_with(codigo: bank["codigo"], nome: bank["nome"]).find_or_create_by(nome: bank["nome"])
    end
  end
end

BRBank.populate