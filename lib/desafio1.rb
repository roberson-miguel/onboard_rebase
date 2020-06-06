require 'rest-client'
require 'json'
require "sqlite3"
require_relative 'processos.rb'

class Desafio1

  def url_base(uri)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  def url_base_local(uri)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  
  def menu(escolha)
    while true do
      if escolha == "1" then
        return Processos.nome_decada 
      elsif escolha == "2" then
        return Processos.todos_sexos_local
      elsif escolha == "3" then
        return Processos.nomes_cidade
      elsif escolha == "sair" then
        return Processos.sair
      else
        return Processos.opcao_invalida
      end
    end
  end

end
