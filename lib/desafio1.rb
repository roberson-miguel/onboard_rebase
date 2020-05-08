require 'rest-client'
require 'json'


api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"
api_base_url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/"



print "\nNo Brasil, de acordo com o Censo Demográfico 2010,\n
existem cerca de 200 milhões de habitantes com mais\n 
de 130 mil nomes diferentes."

#### Nomes
#puts "\n \nDigite o primeiro nome para pesquisar: " 
#nome = gets.chomp
puts
nome = "Maria"
puts "\n \nPrimeiro nome a ser pesquisado: #{nome} \n \n"
groupBy = "UF"
url_nomes = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"
rest_resource_nome = RestClient::Resource.new(url_nomes)

rest_nome = rest_resource_nome.get

rest_nome_json = JSON.parse(rest_nome, :symbolize_names => true)

puts "Todas localidades: \n \n #{rest_nome_json.to_s} \n \n "
puts 
puts "Apenas uma localidade: \n \n #{rest_nome_json[0].to_s}\n"
puts

rest_nome_json[0].each { |chave, valor|
puts "Chave: #{chave} ----> guarda o valor #{valor}"
}

#### Ranking
#puts "\n \nDigite ad decada para pesquisar: " 
#decada = gets.chomp
puts
decada = "1950"
puts "\n \nDecada a ser pesquisada: #{decada} \n \n"
groupBy = "UF"
url_ranking = "#{api_base_url_ranking}?decada=#{decada}"
rest_resource_ranking = RestClient::Resource.new(url_ranking)

rest_ranking = rest_resource_ranking.get

rest_ranking_json = JSON.parse(rest_ranking, :symbolize_names => true)

puts "Todos Nomes: \n \n #{rest_ranking_json.to_s} \n \n "
puts 
puts "Apenas um nome: \n \n #{rest_ranking_json[0].to_s}\n \n"

puts "As Chaves: #{rest_ranking_json[0].keys}\n \n "
puts "Localidade: #{rest_ranking_json[0][:localidade]} \n \n "
puts "Sexo: #{rest_ranking_json[0][:sexo]} \n \n "
puts "Res: #{rest_ranking_json[0][:res][0][:nome]} \n \n "
