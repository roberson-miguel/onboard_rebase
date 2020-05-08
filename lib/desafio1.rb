require 'rest-client'
require 'json'


api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"
api_base_url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/"

system("clear")
puts "+------------------------------------+" 
puts "|        Escolha uma das opções:     |" 
puts "|                                    |" 
puts "| 1- Pesquisar por Primeiro nome     |" 
puts "| 2- Digitar uma década ex. 1950     |" 
puts "| 3- Pesquisar por sexo: M ou F      |" 
puts "|                                    |" 
puts "+------------------------------------+"  
  
# taking input from user 
print "Entre com sua escolha: " 
escolha = gets.chomp 

case escolha
when "1"  
  puts "\n \nDigite o primeiro nome para pesquisar: " 
  nome = gets.chomp
  puts "\n \nPrimeiro nome a ser pesquisado: #{nome} \n \n"
  groupBy = "UF"
  url_nomes = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"
  resource_nome = RestClient::Resource.new(url_nomes)
  rest_nome = resource_nome.get
  rest_nome_json = JSON.parse(rest_nome, :symbolize_names => true)
  puts "Apenas uma localidade: \n \n #{rest_nome_json[0].to_s}\n"
  
when "2" 
  puts "\n \nDigite uma década para pesquisar: " 
  decada = gets.chomp
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
  
when "3"  
  print "\n \n Digite um sexo para pesquisar" 
  puts  "\n \n'M' para Masculino 'F' para FEMININO:" 
  sexo = gets.chomp
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

else  
  puts "\t \n Escolha uma das opções..."
  puts
  sleep 1.9
  system("ruby desafio1.rb")
end  
