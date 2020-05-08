require "spec_helper"
require 'rest-client'

describe "API GET status" do
 
  it "successful" do
    nome = 'Joao'
    response = RestClient.get "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}"
    expect(response.code).to eq(200)
  end

end  