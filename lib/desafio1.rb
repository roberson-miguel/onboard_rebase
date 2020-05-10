require 'rest-client'
require 'json'

  def menu
    system("clear")
    puts
    puts
    puts "\t Esse programa traz um ranking iterativo dos nomes a partir dos dados mais recentes do CENSO,
         o IBGE lançou essa aplicação Web que fez muito sucesso em 2016. Você pode consultar os nomes mais 
         populares que pode ser organizado em décadas e/ou estados do país.
          
         Além disso você pode buscar pelo seu nome e entender quão frequente é esse nome em um estado ou
         uma cidade do país. Algumas informações podem ser separadas ainda pela década ou pelo
         sexo atribuído ao nome.\n"
    puts
    puts
    puts  "\t Escolha uma das opções: \n " 
    puts 
    puts "\t \t 1 - \tPesquisar Nome no Ranking Geral" 
    puts "\t \t 2 - \tPesquisar Nomes em todas Décadas" 
    puts "\t \t 3 - \tPesquisar Nomes por década ex. 1950" 
    puts "\t \t 4 - \tPesquisar por Sexo ex. M ou F" 
    puts "\t \t 5 - \tPesquisar Nome por Sexo nas Décadas" 
    puts "\t \t 6 - \tPesquisar Nome por Estado" 
    puts "\t \t 7 - \tConsultar UF dos Estados" 
    puts "\t \t 8 - \tRanking de Nomes Masculinos e Femininos" 
    puts "\t \t 9 - \tRanking de Nomes Masculinos" 
    puts "\t \t10 - \tRanking de Nomes Femininos \n" 
    puts 
    puts "\t \tPARA FINALIZAR DIGITE: 'sair'" 
    puts 
    puts
    print "\t Digite sua escolha: " 
    while true do
      escolha = $stdin.gets.chomp.to_s
      if escolha == "1" then
        return nome 
      elsif escolha == "2" then
        return todas_decadas
      elsif escolha == "3" then
        return decada
      elsif escolha == "4" then
        return sexo
      elsif escolha == "5" then
        return nome_sexo
      elsif escolha == "6" then
        return nome_local
      elsif escolha == "7" then
        return local
      elsif escolha == "8" then
        return todos_sexos
      elsif escolha == "9" then
        return masculino
      elsif escolha == "10" then
        return feminino
      
      elsif escolha == "sair" then
        return sair
      else
        puts
        puts
        puts "\t \t Escolha uma das opções..."
        puts
        sleep 1.9
        return menu
      end
    end
  end

  def sair 
    puts 
    puts "+------------------------------------+" 
    puts "|                                    |" 
    puts "|        Saindo...Obrigado...        |"
    puts "|                                    |" 
    puts "+------------------------------------+" 
    puts
    sleep 1.9
  end

  def nome  
    print "\n \t Digite o nome para pesquisar: " 
    nome = $stdin.gets.chomp
    puts
    groupBy = "UF"
    url_nomes = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}?groupBy=#{groupBy}"
    resource_nome = RestClient::Resource.new(url_nomes)
    rest_nome = resource_nome.get
    rest_nome_json = JSON.parse(rest_nome, :symbolize_names => true)
    puts "\t Ranking para #{nome} nas Localidades e com a Frequencia"
    puts
    puts "\tLocalidade:\tFrequêcia:"
    rest_nome_json.each do |ranking|
      puts "\t #{ranking[:localidade]}\t\t#{ranking[:res][0][:frequencia]}"
    end 
  end
    
  def todas_decadas 
    url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?decada"
    resource_ranking = RestClient::Resource.new(url_ranking)
    rest_ranking = resource_ranking.get
    rest_ranking_json = JSON.parse(rest_ranking, :symbolize_names => true)
    puts "\t Ranking de Nomes em todas as Década"
    puts
    rest_ranking_json[0][:res].each do |ranking|
      puts "\t #{ranking[:ranking]}. #{ranking[:nome]} \t - Frequência: #{ranking[:frequencia]}"
    end
  end

  def decada 
    print "\n \t Digite uma década para pesquisar: " 
    decada = gets.chomp
    puts
    url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?decada=#{decada}"
    resource_ranking = RestClient::Resource.new(url_ranking)
    rest_ranking = resource_ranking.get
    rest_ranking_json = JSON.parse(rest_ranking, :symbolize_names => true)
    puts "\t Ranking de Nomes por Década"
    puts
    rest_ranking_json[0][:res].each do |ranking|
      puts "\t #{ranking[:ranking]}.#{ranking[:nome]}\t Frequência: #{ranking[:frequencia]}"
    end
  end
  
  def sexo
    puts "\n \t Escolha um Sexo para pesquisar" 
    print  "\n \t 'M' para Masculino ou 'F' para FEMININO: " 
    sexo = gets.chomp
    puts
    url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=#{sexo}"
    resource_sexo = RestClient::Resource.new(url_ranking)
    rest_sexo = resource_sexo.get
    rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
    puts "\t Ranking de Nome por Sexo "
    puts
    rest_sexo_json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
  end

  def nome_sexo
    print "\n \tDigite o Nome para pesquisar: " 
    nome = gets.chomp 
    print  "\n \tEscolha o sexo para o nome: #{nome}, ex. 'M' para Masculino 'F' para FEMININO: " 
    sexo = gets.chomp
    puts
    url_nomes = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}?sexo=#{sexo}"
    resource_periodo = RestClient::Resource.new(url_nomes)
    rest_periodo_decada = resource_periodo.get
    rest_periodo_decada_json = JSON.parse(rest_periodo_decada, :symbolize_names => true)
    tam_periodo_res = rest_periodo_decada_json[0][:res].size
    puts "\t Consultando #{nome} por Sexo nos Periodos"
    puts
    rest_periodo_decada_json[0][:res].each do |decada|
      puts "\t Periodo: #{decada[:periodo]} - \t Frequência: #{decada[:frequencia]}".tr('[', '')
    end
  end
  
  def todos_sexos
    puts "\n \t Exibindo Ranking de nomes Masculinos e Femininos " 
    puts
    url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=''"
    resource_sexo = RestClient::Resource.new(url_ranking)
    rest_sexo = resource_sexo.get
    rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
    rest_sexo_json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
  end

  def masculino
    puts "\n \t Exibindo Ranking de nomes Masculinos " 
    puts
    url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=M"
    resource_sexo = RestClient::Resource.new(url_ranking)
    rest_sexo = resource_sexo.get
    rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
    rest_sexo_json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
  end

  def feminino
    puts "\n \t Exibindo Ranking de nomes Femininos " 
    puts
    url_ranking = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=F"
    resource_sexo = RestClient::Resource.new(url_ranking)
    rest_sexo = resource_sexo.get
    rest_sexo_json = JSON.parse(rest_sexo, :symbolize_names => true)
    rest_sexo_json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
  end

  
  def nome_local
    system("clear")
    api_base_url_localidade = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    resource_localidade = RestClient::Resource.new(api_base_url_localidade)
    rest_localidade = resource_localidade.get
    rest_localidade_json = JSON.parse(rest_localidade, :symbolize_names => true)
    
    puts "\n \t \t Siglas dos Estados"
    puts
    rest_localidade_json.each do |localidade|
    puts "\t \t #{localidade[:id]} - #{localidade[:sigla]} - #{localidade[:nome]} "
    end
    print "\n \t Digite um nome para pesquisar: " 
    nome = gets.chomp 
    puts "\n \t Digite o numero referente ao Estado "
    print "\t Exemplo, digite '33' para pesquisar por #{nome} no Estado do Rio de Janeiro: " 
    localidade = gets.chomp
    puts
    url_nome_localidade = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}?localidade=#{localidade}"
    resource_nome_localidade = RestClient::Resource.new(url_nome_localidade)
    rest_nome_localidade = resource_nome_localidade.get
    rest_nome_localidade_json = JSON.parse(rest_nome_localidade, :symbolize_names => true)
    puts "\t Consultando Nome por Estado nos Periodos"
    puts
    rest_nome_localidade_json[0][:res].each do |nome|
      puts "\t Periodo: #{nome[:periodo]} - \t Frequência: #{nome[:frequencia]}".tr('[', '')
    end
  end

  def local
    api_base_url_localidade = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    resource_localidade = RestClient::Resource.new(api_base_url_localidade)
    rest_localidade = resource_localidade.get
    rest_localidade_json = JSON.parse(rest_localidade, :symbolize_names => true)
    
    puts "\n \n \t \t Consultando siglas das localidades"
    puts
    rest_localidade_json.each do |localidade|
    puts "\t \t #{localidade[:id]} - #{localidade[:sigla]} - #{localidade[:nome]} "
    end
  end 

menu