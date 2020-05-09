require 'rest-client'
require 'json'

api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"
api_base_url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/"
api_base_url_localidade = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"

system("clear")
puts
puts "+------------------------------------+" 
puts "|      Escolha uma das opções:       |" 
puts "|                                    |" 
puts "| 1- Pesquisar Nome no ranking geral |" 
puts "| 2- Digitar uma década ex. 1950     |" 
puts "| 3- Pesquisar por sexo: M ou F      |" 
puts "| 4- Nome por Sexo nas décadas       |" 
puts "| 5- Nome por Estados                |" 
puts "| 6- Consultar UF dos estados        |" 
puts "|                                    |" 
puts "| 0- Sair                            |" 
puts "|                                    |" 
puts "+------------------------------------+"  
puts  
print "  >>>>  Entre com sua escolha: " 
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
  puts "\n \nDigite o primeiro nome para pesquisar: " 
  nome = gets.chomp
  groupBy = "UF"
  url_nomes = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"
  resource_nome = RestClient::Resource.new(url_nomes)
  rest_nome = resource_nome.get
  rest_nome_json = JSON.parse(rest_nome, :symbolize_names => true)
  puts "Ranking para o nome: #{nome} em Localidades, Frequencia, População e Proporção"
  rest_nome_json.each do |ranking|
    puts "Localidade: #{ranking[:localidade]} - Frequêcia: #{ranking[:res][0][:frequencia]} - População: #{ranking[:res][0][:populacao]} - Proporção: #{ranking[:res][0][:proporcao]}"
  end 
    
when "2" 
  print "\n \nDigite uma década para pesquisar: " 
  decada = gets.chomp
  url_ranking = "#{api_base_url_ranking}?decada=#{decada}"
  resource_ranking = RestClient::Resource.new(url_ranking)
  rest_ranking = resource_ranking.get
  rest_ranking_json = JSON.parse(rest_ranking, :symbolize_names => true)
  puts "Ranking de Nomes por Década"
  rest_ranking_json[0][:res].each do |ranking|
    puts "#{ranking[:ranking]}. #{ranking[:nome]} - Frequência: #{ranking[:frequencia]}"
  end
  
when "3"  
  print "\n \n Digite um sexo para pesquisar" 
  puts  "\n \n'M' para Masculino 'F' para FEMININO:" 
  sexo = gets.chomp
  url_ranking = "#{api_base_url_ranking}?sexo=#{sexo}"
  resource_sexo = RestClient::Resource.new(url_ranking)
  rest_sexo = resource_sexo.get
  rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
  puts "Ranking de Nome por Sexo todos Periodos"
  rest_sexo_json[0][:res].each do |sexo|
    puts "Periodo: #{sexo[:nome]} - Frequência: #{sexo[:frequencia]}"
  end

when "4"
  puts "\n \nDigite o primeiro nome para pesquisar: " 
  nome = gets.chomp 
  puts  "\n \nDigite'M' para Masculino 'F' para FEMININO:" 
  sexo = gets.chomp
  url_nomes = "#{api_base_url_nome}#{nome}?sexo=#{sexo}"
  resource_periodo = RestClient::Resource.new(url_nomes)
  rest_periodo_decada = resource_periodo.get
  rest_periodo_decada_json = JSON.parse(rest_periodo_decada, :symbolize_names => true)
  tam_periodo_res = rest_periodo_decada_json[0][:res].size
  puts "Consultando Nome por Sexo nos Periodos"
  rest_periodo_decada_json[0][:res].each do |decada|
    puts "Periodo: #{decada[:periodo]} - Frequência: #{decada[:frequencia]}"
  end


when "5"
  puts "\n \nDigite o primeiro nome em um estado: " 
  nome = gets.chomp 
  puts  "\n \nDigite um Estado para esquisar. Ex.: '33' para Rio de Janeiro:" 
  localidade = gets.chomp
  url_nome_localidade = "#{api_base_url_nome}#{nome}?localidade=#{localidade}"
  resource_nome_localidade = RestClient::Resource.new(url_nome_localidade)
  rest_nome_localidade = resource_nome_localidade.get
  rest_nome_localidade_json = JSON.parse(rest_nome_localidade, :symbolize_names => true)
  puts "Consultando Nome por Localidade nos Periodos"
  rest_nome_localidade_json[0][:res].each do |nome|
    puts "Periodo: #{nome[:periodo]} - Frequência: #{nome[:frequencia]}"
  end

when "6"
  resource_localidade = RestClient::Resource.new(api_base_url_localidade)
  rest_localidade = resource_localidade.get
  rest_localidade_json = JSON.parse(rest_localidade, :symbolize_names => true)
  
  puts "\n \n \t \t Consultando siglas das localidades"
  rest_localidade_json.each do |uf|
  puts "\t \t #{uf[:nome]} " + '-' + " #{uf[:sigla]}"
  end

else  
  puts "\t \n Escolha uma das opções..."
  puts
  sleep 1.9
  system("ruby desafio1.rb")
end  