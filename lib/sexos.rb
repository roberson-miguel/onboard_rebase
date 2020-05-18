require 'rest-client'
require 'json'


class Sexos

  def self.sexo #menu 5
    puts "\n \t Escolha um Sexo para pesquisar" 
    print  "\n \t 'M' para Masculino ou 'F' para FEMININO: " 
    sexo = gets.chomp
    puts
    uri = "ranking/?sexo=#{sexo}"
    json = url_base(uri)
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
    uri = "#{nome}?sexo=#{sexo}"
    json = url_base(uri)
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
  
  def self.todos_sexos #menu 9
    puts "\n \t Exibindo Ranking de nomes Masculinos e Femininos " 
    puts
    uri = "ranking/?sexo=''"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

  def self.masculino #menu 10
    puts "\n \t Exibindo Ranking de nomes Masculinos " 
    puts
    uri = "ranking/?sexo=M"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

  def self.feminino #Menu 11
    puts "\n \t Exibindo Ranking de nomes Femininos " 
    puts
    uri = "ranking/?sexo=F"
    json = url_base(uri)
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

    puts "\n \t Exibindo Ranking Geral para o Estado de: #{uf}" 
    puts
    uri = "ranking/?localidade=#{uf}"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
    
    puts "\n \t Exibindo Ranking Sexo Masculino por Estado" 
    puts
    uri = "ranking/?sexo=M&localidade=#{uf}"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts

    puts "\n \t Exibindo Ranking Sexo Feminino por Estado" 
    puts
    uri = "ranking/?sexo=F&localidade=#{uf}"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

end
