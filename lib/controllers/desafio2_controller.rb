class Desafio2_controller

  def self.url_base(uri)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end


  def self.todos_sexos_local #menu 1
 
    system("clear")
    db = SQLite3::Database.new "estados.db"
    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS estados(
        id INT NOT NULL UNIQUE,
        nome VARCHAR(50) NOT NULL,
        sigla VARCHAR(2) NOT NULL
      );
    SQL
  
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
    if db.execute('SELECT * FROM estados').empty?
      json.each do |uf|
        db.execute('INSERT INTO estados (id, nome, sigla) 
                VALUES (?, ?, ?)', ["#{uf[:id]}", "#{uf[:nome]}", "#{uf[:sigla]}"]
        )
      end
    end
  
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
  
    system("clear")
   
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
    puts
      puts "Digite 'sair' para sair ou Tecle 'ENTER' para continuar"
      cont = $stdin.gets.chomp
      if cont == 'sair'
        Display.new.sair
      else
        return Desafioapp.new.app_desafio2
      end
  end
  
  def self.nomes_cidade #menu 2
  
    system("clear")
    db = SQLite3::Database.new "municipios.db"
    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS municipios(
        id INT NOT NULL UNIQUE,
        nome VARCHAR(50) NOT NULL,
        sigla VARCHAR(2) NOT NULL
      );
    SQL
   
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  
    print "\n \t Digite um ou mais nomes, separados por virgula, ex.: 'maria,joao' para pesquisar: " 
    nome = gets.chomp 
    puts "\n \t Digite o nome de uma Cidade"
    print "\t Exemplo, digite 'São Paulo' para pesquisar o(s) nome(s): #{nome} na Cidade de São Paulo: " 
      nome_cidade = gets.chomp
      id_municipio = nil
  
      if db.execute('SELECT * FROM municipios').empty?
        json.each do |municipio|
          if municipio[:nome] == nome_cidade
            id_municipio = municipio[:id]
          end
          db.execute('INSERT INTO municipios (id, nome, sigla) 
                  VALUES (?, ?, ?)', ["#{municipio[:id]}", "#{municipio[:nome]}", "#{municipio[:sigla]}"]
          )
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
        Display.new.sair
      else
        return Desafioapp.new.app_desafio2
      end
  end 

end