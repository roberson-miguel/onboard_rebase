require 'rest-client'
require 'json'
require 'text-table'
require_relative 'formatador'

require 'ruby-progressbar'


class Processos

  def self.opcao_invalida
    table = Text::Table.new :rows => [['Escolha uma das opções'], [" de 1 a 15"]],
                :horizontal_padding    => 3,
                :vertical_boundary     => '=',
                :horizontal_boundary   => ':',
                :boundary_intersection => '+'
    puts table
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
    uri = "#{nome}?groupBy=UF"
    json = url_base(uri)
    # Formatador.display_table(json, [:localidade, :res])
    
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
    uri = "#{nome}"
    json = url_base(uri)
    puts "\t Consultando Nome por Periodos"
    puts
    puts "\t Periodo:\tFrequêcia:"
    linha = 0
    json.to_s.gsub("[","")
    Formatador.display_table(json[0][:res], [:periodo, :frequencia])

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
    uri = "/ranking/?decada"
    json = url_base(uri)
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
    uri = "ranking/?decada=#{decada}"
    json = url_base(uri)
    puts "\t Ranking de Nomes por Década"
    puts
    json[0][:res].each do |ranking|
      puts "\t #{ranking[:ranking]}.#{ranking[:nome]}\t Frequência: #{ranking[:frequencia]}"
    end
    puts
  end
 
  def self.nome_local #menu 7
    system("clear")
    uri = "estados"
    json = url_base_local(uri)
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
    uri = "#{nome}?localidade=#{uf}"
    json = url_base(uri)
    puts "\t Consultando Nome por Estado nos Periodos"
    puts
      json[0][:res].each do |nome|
        puts "\t Periodo: #{nome[:periodo]} - \t Frequência: #{nome[:frequencia]}".tr('[', '')
      end
    puts
  end

  def self.local #menu 8
          uri = "estados"
          json = url_base_local(uri)
          puts "\n \n \t \t Consultando siglas das localidades"
          puts
          json.each do |localidade|
          puts "\t \t #{localidade[:sigla]} - #{localidade[:nome]} "
          end
          puts
  end 


  def self.cidade #menu 13
          uri = "municipios"
          json = url_base_local(uri)
          puts "\n \t \t Consultar Ids e Nomes das Cidades"
          puts
          json.each do |municipio|
          puts "\t \t #{municipio[:id]} - #{municipio[:nome]} "
          end
          puts
  end

  def self.nomes_cidade #menu 14
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
  
    if nomes.length == 1
      uri = "#{nomes[0]}?localidade=#{id_municipio}"
      json = url_base(uri)
      puts
      puts "\t Exibindo #{nomes[0]} no Municipio #{nome_cidade} nos Periodos"
        json[0][:res].each do |nome|
          puts "\t Periodo: #{nome[:periodo]} - \t Frequência: #{nome[:frequencia]}".tr('[', '')
        end
      puts
    else
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
    end
  end 

end
