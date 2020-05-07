require "spec_helper"
require 'rest-client'


describe "API status" do

  xit "successful for GET " do
    
    api_base_url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"

    nome = "Roberson"
    groupBy = "UF"
    localidade = 'BR'

    url = "#{api_base_url}#{nome}?groupBy=#{groupBy}"

    rest_resource = RestClient::Resource.new(url)

    nomes = rest_resource.get
      
    expect(nomes.code).to eq(200)

  end

end  