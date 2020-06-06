require 'rest-client'
require 'json'
require "sqlite3"

class Desafio2
  system("clear")
  puts
  puts
  puts "\t \t Busca ao site do IBGE com busca das cidades e UFs em Banco de Dados SQLite local\n"
  puts

  def url_base(uri)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  def menu(escolha)
    while true do
      if escolha == "1" then
        return todos_sexos_local
      elsif escolha == "2" then
        return nomes_cidade
      elsif escolha == "sair" then
        return sair
      else
        return opcao_invalida
      end
    end
  end

end


