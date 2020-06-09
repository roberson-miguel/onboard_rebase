class Desafio1_controller

  def self.url_base(uri)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  def self.url_base_local(uri)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  def self.opcao_invalida
    puts
    puts
    puts "\t \t Escolha uma das opções..."
    puts
    puts
    sleep 1.9
    return Desafioapp.new.app_desafio1
  end

  def self.sair 
    puts 
    puts                            
    puts "\t \t Saindo...Obrigado..."          
    puts               
    puts                                    
    sleep 1.9
  end
  
  def self.nome_decada #menu 1
    print "\n \t Digite o nome para pesquisar: " 
    nome = $stdin.gets.chomp
    puts
    uri = "#{nome}"
    json = url_base(uri)
    puts "\t Consultando Nome por Periodos"
    puts
    puts "\t Periodo:\tFrequêcia:"
    linha = 0
    json.to_s.gsub("[","")
    json[0][:res].each do |ranking|
      if linha == 0
        puts "\t Até  #{ranking[:periodo]}\t\t#{ranking[:frequencia]}".tr('[', '')
        linha = linha + 1
      else
      puts "\t #{ranking[:periodo]}\t\t#{ranking[:frequencia]}".tr('[', '')
      end
    end 
    puts
    puts "Digite 'sair' para sair ou Tecle 'ENTER' para continuar"
    cont = $stdin.gets.chomp
    if cont == 'sair'
      return sair
    else
      return Desafioapp.new.app_desafio1
    end
  end 
    
  def self.todos_sexos_local #menu 2
    system("clear")
    uri = "estados"
    json = url_base_local(uri)
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
    puts "Digite 'sair' para sair ou Tecle 'ENTER' para continuar"
    cont = $stdin.gets.chomp
    if cont == 'sair'
      return sair
    else
      return Desafioapp.new.app_desafio1
    end
  end
    
  def self.nomes_cidade #menu 3
    uri = "municipios"
    json = url_base_local(uri)
    print "\n \t Digite um ou mais nomes, separados por virgula, ex.: 'maria,joao' para pesquisar: " 
    nome = gets.chomp 
    puts "\n \t Digite o nome de uma Cidade"
    print "\t Exemplo, digite 'São Paulo' para pesquisar o(s) nome(s): #{nome} na Cidade de São Paulo: " 
      nome_cidade = gets.chomp
      id_municipio = nil
      json.each do |municipio|
        if municipio[:nome] == nome_cidade
           id_municipio = municipio[:id]
        end
      end
    puts
    nomes = nome.split(/,/) # => ["a", "b", "c"]
    puts 
   
    fim = nomes.length - 1
    puts "\t Consultando multiplus nomes no Municipio #{nome_cidade} nos Periodos"
    for i in 0..fim
      uri = "#{nomes[i]}?localidade=#{id_municipio}"
      json = url_base(uri)
      puts 
      puts "\t Exibindo #{nomes[i].capitalize} no Municipio #{nome_cidade} nos Periodos"
        json[0][:res].each do |nome|
          puts "\t Periodo: #{nome[:periodo]} - \t Frequência: #{nome[:frequencia]}".tr('[', '')
        end
      puts
    end
    puts
    puts "Digite 'sair' para sair ou Tecle 'ENTER' para continuar"
    cont = $stdin.gets.chomp
    if cont == 'sair'
      return sair
    else
      return Desafioapp.new.app_desafio1
    end
  end 

end
