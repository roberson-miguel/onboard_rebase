require 'rest-client'
require 'json'

api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"
api_base_url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/"
api_base_url_localidade = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"

system("clear")
puts 
print "\t Escolha uma das opções: \n " 
puts 
puts
puts
puts "\t \t 1- Pesquisar Nome no ranking geral \n " 
puts "\t \t 2- Digitar uma década ex. 1950 \n " 
puts "\t \t 3- Pesquisar por sexo: M ou F \n " 
puts "\t \t 4- Nome por Sexo nas décadas \n " 
puts "\t \t 5- Nome por Estados \n " 
puts "\t \t 6- Consultar UF dos estados \n " 
puts 
puts "\t \t 0- SAIR" 
puts 
puts
print "\t Digite sua escolha: " 
escolha = gets.chomp 



case escolha
when "0"
  puts 
  puts "+------------------------------------+" 
  puts "|                                    |" 
  puts "|     Saindo...Obrigado...           |"
  puts "|                                    |" 
  puts "+------------------------------------+" 
  puts
when "1"  
  print "\n \t Digite o primeiro nome para pesquisar: " 
  nome = gets.chomp
  puts
  groupBy = "UF"
  url_nomes = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"
  resource_nome = RestClient::Resource.new(url_nomes)
  rest_nome = resource_nome.get
  rest_nome_json = JSON.parse(rest_nome, :symbolize_names => true)
  puts "\t Ranking para #{nome} em Localidades, Frequencia, População e Proporção"
  puts
  rest_nome_json.each do |ranking|
    puts "\t Localidade: #{ranking[:localidade]} - Frequêcia: #{ranking[:res][0][:frequencia]} - População: #{ranking[:res][0][:populacao]} - Proporção: #{ranking[:res][0][:proporcao]}"
  end 
  puts
    
when "2" 
  print "\n \t Digite uma década para pesquisar: " 
  decada = gets.chomp
  puts
  url_ranking = "#{api_base_url_ranking}?decada=#{decada}"
  resource_ranking = RestClient::Resource.new(url_ranking)
  rest_ranking = resource_ranking.get
  rest_ranking_json = JSON.parse(rest_ranking, :symbolize_names => true)
  puts "\t Ranking de Nomes por Década"
  puts
  rest_ranking_json[0][:res].each do |ranking|
    puts "\t #{ranking[:ranking]}. #{ranking[:nome]} - Frequência: #{ranking[:frequencia]}"
  end
  puts
  
when "3"  
  puts "\n \t Digite um sexo para pesquisar" 
  print  "\n \t 'M' para Masculino ou 'F' para FEMININO: " 
  sexo = gets.chomp
  puts
  url_ranking = "#{api_base_url_ranking}?sexo=#{sexo}"
  resource_sexo = RestClient::Resource.new(url_ranking)
  rest_sexo = resource_sexo.get
  rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
  puts "\t Ranking de Nome por Sexo "
  puts
  rest_sexo_json[0][:res].each do |sexo|
    puts "\t #{sexo[:ranking]}. Nome: #{sexo[:nome]} - Frequência: #{sexo[:frequencia]}"
  end
  puts

when "4"
  print "\n \tDigite o primeiro nome para pesquisar: " 
  nome = gets.chomp 
  print  "\n \tDigite'M' para Masculino 'F' para FEMININO: " 
  sexo = gets.chomp
  puts
  url_nomes = "#{api_base_url_nome}#{nome}?sexo=#{sexo}"
  resource_periodo = RestClient::Resource.new(url_nomes)
  rest_periodo_decada = resource_periodo.get
  rest_periodo_decada_json = JSON.parse(rest_periodo_decada, :symbolize_names => true)
  tam_periodo_res = rest_periodo_decada_json[0][:res].size
  puts "\t Consultando #{nome} por Sexo nos Periodos"
  puts
  rest_periodo_decada_json[0][:res].each do |decada|
    puts "\t Periodo: #{decada[:periodo]} - \t Frequência: #{decada[:frequencia]}"
  end
  puts


when "5"
  system("clear")
  resource_localidade = RestClient::Resource.new(api_base_url_localidade)
  rest_localidade = resource_localidade.get
  rest_localidade_json = JSON.parse(rest_localidade, :symbolize_names => true)
  
  puts "\n \t \t Siglas das localidades"
  puts
  rest_localidade_json.each do |localidade|
  puts "\t \t #{localidade[:id]} - #{localidade[:sigla]} - #{localidade[:nome]} "
  end
  print "\n \t Digite um nome para pesquisa: " 
  nome = gets.chomp 
  puts "\n \t Digite o numero referente ao Estado "
  print "\t Exemplo, digite '33' para Rio de Janeiro: " 
  localidade = gets.chomp
  puts
  url_nome_localidade = "#{api_base_url_nome}#{nome}?localidade=#{localidade}"
  resource_nome_localidade = RestClient::Resource.new(url_nome_localidade)
  rest_nome_localidade = resource_nome_localidade.get
  rest_nome_localidade_json = JSON.parse(rest_nome_localidade, :symbolize_names => true)
  puts "\t Consultando Nome por Estado nos Periodos"
  puts
  rest_nome_localidade_json[0][:res].each do |nome|
    puts "\t Periodo: #{nome[:periodo]} - \t Frequência: #{nome[:frequencia]}"
  end
  puts

when "6"
  resource_localidade = RestClient::Resource.new(api_base_url_localidade)
  rest_localidade = resource_localidade.get
  rest_localidade_json = JSON.parse(rest_localidade, :symbolize_names => true)
  
  puts "\n \n \t \t Consultando siglas das localidades"
  puts
  rest_localidade_json.each do |localidade|
  puts "\t \t #{localidade[:id]} - #{localidade[:sigla]} - #{localidade[:nome]} "
  end
  puts

else  
  puts "\t \n Escolha uma das opções..."
  puts
  sleep 1.9
  system("ruby desafio_old.rb")
end  