require 'rest-client'
require 'json'
require "sqlite3"

system("clear")
puts
puts
puts "\t \t Busca ao site do IBGE com busca das cidades e UFs em Banco de Dados SQLite local\n"
puts

def url_base(uri)
  url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{uri}"
  resource = RestClient::Resource.new(url)
  json = JSON.parse(resource.get, :symbolize_names => true)
end


def display
  puts "\t \t Escolha uma das opções: \n " 
  puts 
  puts "\t \t Atalhos cosultar os itens do Desafio1: "
  puts
  puts "\t \t 1 - \t Ranking dos nomes mais comuns em uma determinada Unidade Federativa (UF)\n" 
  puts "\t \t 2 - \t Ranking dos nomes mais comuns em uma determinada cidade\n"
  puts 
  puts "\t \tPARA FINALIZAR DIGITE: 'sair'" 
    puts 
    puts
    print "\t Digite sua escolha: " 
    escolha = $stdin.gets.chomp.to_s
    return menu(escolha)
  puts
end

def self.menu(escolha)
  while true do
    if escolha == "1" then
      return todos_sexos_local
    elsif escolha == "2" then
      return nomes_cidade
    elsif escolha == "sair" then
      return sair
    else
      return opcao_invalida
    end
  end
end

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

def create_estados
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

end 

puts
display
