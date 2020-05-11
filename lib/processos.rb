require 'rest-client'
require 'json'

class Processos

  def self.opcao_invalida
    puts
    puts
    puts "\t \t Escolha uma das opções..."
    puts
    puts
    sleep 1.9
    return display
  end

  def self.sair 
    puts 
    puts                            
    puts "\t \t Saindo...Obrigado..."          
    puts               
    puts                                    
    sleep 1.9
  end
  
  def self.nome  #menu 1
    print "\n \t Digite o nome para pesquisar: " 
    nome = $stdin.gets.chomp
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}?groupBy=UF"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\t Ranking para #{nome} por Estado e Frequencia"
    puts "\t Localidade:\tFrequêcia:"
    json.each do |ranking|
      puts "\t #{ranking[:localidade]}\t\t#{ranking[:res][0][:frequencia]}"
    end 
    puts
  end

  def self.nome_decada #menu 2
    print "\n \t Digite o nome para pesquisar: " 
    nome = $stdin.gets.chomp
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\t Consultando Nome por Periodos"
    puts
    puts "\t Periodo:\tFrequêcia:"
    linha = 0
    json[0][:res].each do |ranking|
      if linha == 0
        puts "\t Até  #{ranking[:periodo]}\t\t#{ranking[:frequencia]}".tr('[', '')
        linha = linha + 1
      else
      puts "\t #{ranking[:periodo]}\t\t#{ranking[:frequencia]}".tr('[', '')
      end
    end 
    puts
  end 
    
  def self.todas_decadas #menu 3
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?decada"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\t Ranking de Nomes em todas as Década"
    puts
    json[0][:res].each do |ranking|
      puts "\t #{ranking[:ranking]}. #{ranking[:nome]} \t - Frequência: #{ranking[:frequencia]}"
    end
    puts
  end

  def self.decada #menu 4
    print "\n \t Digite uma década para pesquisar: " 
    decada = gets.chomp
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?decada=#{decada}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\t Ranking de Nomes por Década"
    puts
    json[0][:res].each do |ranking|
      puts "\t #{ranking[:ranking]}.#{ranking[:nome]}\t Frequência: #{ranking[:frequencia]}"
    end
    puts
  end
  
  def self.sexo #menu 5
    puts "\n \t Escolha um Sexo para pesquisar" 
    print  "\n \t 'M' para Masculino ou 'F' para FEMININO: " 
    sexo = gets.chomp
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=#{sexo}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\t Ranking de Nome por Sexo "
    puts
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

  def self.nome_sexo #menu 6
    print "\n \tDigite o Nome para pesquisar: " 
    nome = gets.chomp 
    print  "\n \tEscolha o sexo para o nome: #{nome}, ex. 'M' para Masculino 'F' para FEMININO: " 
    sexo = gets.chomp
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}?sexo=#{sexo}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\tConsultando #{nome} por Sexo nos Periodos"
    puts
    puts "\tPeriodo: \tFrequêcia:"
    linha = 0
    json[0][:res].each do |ranking|
      if linha == 0
        puts "\tAté  #{ranking[:periodo]} - \t#{ranking[:frequencia]}".tr('[', '')
        linha = linha + 1
      else
        puts "\t#{ranking[:periodo]} - \t#{ranking[:frequencia]}".tr('[', '')
      end
    end 
    puts
  end

  def self.nome_local #menu 7
    system("clear")
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\n \t \t Siglas dos Estados"
    puts
    json.each do |localidade|
    puts "\t \t #{localidade[:sigla]} - #{localidade[:nome]} "
    end
    print "\n \t Digite um nome para pesquisar: " 
    nome = gets.chomp 
    puts "\n \t Digite uma sigla do Estado para pesquisar - Veja Tabela acima."
    print "\t Exemplo, digite 'SP' para pesquisar o nome: #{nome} no Estado de São Paulo: " 
      sigla = gets.chomp
      uf = nil
      json.each do |localidade|
        if localidade[:sigla] == sigla
          uf = localidade[:id]
        end
      end
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{nome}?localidade=#{uf}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\t Consultando Nome por Estado nos Periodos"
    puts
      json[0][:res].each do |nome|
        puts "\t Periodo: #{nome[:periodo]} - \t Frequência: #{nome[:frequencia]}".tr('[', '')
      end
    puts
  end

  def self.local #menu 8
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\n \n \t \t Consultando siglas das localidades"
    puts
    json.each do |localidade|
    puts "\t \t #{localidade[:sigla]} - #{localidade[:nome]} "
    end
    puts
  end 
  
  def self.todos_sexos #menu 9
    puts "\n \t Exibindo Ranking de nomes Masculinos e Femininos " 
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=''"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

  def self.masculino #menu 10
    puts "\n \t Exibindo Ranking de nomes Masculinos " 
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=M"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

  def self.feminino #Menu 11
    puts "\n \t Exibindo Ranking de nomes Femininos " 
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=F"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

  def self.todos_sexos_local #menu 12
    system("clear")
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    puts "\n \t \t Siglas dos Estados"
    puts
    json.each do |localidade|
    puts "\t \t #{localidade[:sigla]} - #{localidade[:nome]} "
    end

    puts "\n \t Digite uma sigla do Estado para pesquisar - Veja Tabela acima."
    print "\t Exemplo, digite 'SP' para Ranking por Sexo no Estado de São Paulo: " 
    sigla = gets.chomp
    uf = nil
    json.each do |localidade|
      if localidade[:sigla] == sigla
        uf = localidade[:id]
      end
    end
    
    puts "\n \t Exibindo Ranking Sexo Masculino por Estado" 
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=M&localidade=#{uf}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts

    puts "\n \t Exibindo Ranking Sexo Feminino por Estado" 
    puts
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/?sexo=F&localidade=#{uf}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

end
