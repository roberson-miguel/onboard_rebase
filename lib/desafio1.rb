require 'rest-client'
require 'json'


api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"
api_base_url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/"

#### Ranking por Nome
#puts "\n \nDigite o primeiro nome para pesquisar: " 
#nome = gets.chomp
nome = "Maria"
puts "\n \nPrimeiro nome a ser pesquisado: #{nome} \n \n"
groupBy = "UF"
url_nomes = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"
resource_nome = RestClient::Resource.new(url_nomes)
rest_nome = resource_nome.get
rest_nome_json = JSON.parse(rest_nome, :symbolize_names => true)
puts "Apenas uma localidade: \n \n #{rest_nome_json[0].to_s}\n"
#puts "Todas localidades: \n \n #{rest_nome_json.to_s} \n \n "
#rest_nome_json[0].each { |chave, valor|
#puts "Chave: #{chave} ----> guarda o valor #{valor}"
#}

#### Ranking por década
#puts "\n \nDigite uma década para pesquisar: " 
#decada = gets.chomp
decada = "1950"
puts "\n \nDécada a ser pesquisada: #{decada} \n \n"
url_ranking = "#{api_base_url_ranking}?decada=#{decada}"
resource_ranking = RestClient::Resource.new(url_ranking)
rest_ranking = resource_ranking.get
rest_ranking_json = JSON.parse(rest_ranking, :symbolize_names => true)
#puts "Todos Nomes: \n #{rest_ranking_json.to_s} \n \n "
tam_ranking_res = rest_ranking_json[0][:res].size
ranking = []
start_ranking = 0
while tam_ranking_res > start_ranking
  ranking << rest_ranking_json[0][:res][start_ranking][:nome]
  start_ranking += 1
end
puts "\nNomes por década: \n " 
print ranking 



#### Ranking Sexo
#print "\n \n Digite um sexo para pesquisar" 
#puts  "\n \n'M' para Masculino 'F' para FEMININO:" 
#sexo = gets.chomp
sexo = "F"
puts "\n \n Sexo pesquisado: #{sexo} \n \n"
url_ranking = "#{api_base_url_ranking}?sexo=#{sexo}"
resource_sexo = RestClient::Resource.new(url_ranking)
rest_sexo = resource_sexo.get
rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
tam_sexo_res = rest_sexo_json[0][:res].size
sexo = []
start_sexo = 0
while tam_sexo_res > start_sexo
  sexo << rest_sexo_json[0][:res][start_sexo][:nome]
  start_sexo += 1
end
puts "\nNomes por sexo: \n " 
print sexo
puts