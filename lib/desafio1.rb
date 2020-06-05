require_relative 'processos.rb'

system("clear")
puts
puts
puts "\t \t Esse programa traz um ranking iterativo dos nomes a partir dos dados mais recentes do CENSO,
            o IBGE lançou essa aplicação Web que fez muito sucesso em 2016. Você pode consultar os nomes mais 
            populares que pode ser organizado em décadas e/ou estados do país.

            Além disso você pode buscar pelo seu nome e entender quão frequente é esse nome em um estado ou
            uma cidade do país. Algumas informações podem ser separadas ainda pela década ou pelo
            sexo atribuído ao nome.\n"
puts

  def url_base(uri)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  def url_base_local(uri)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/#{uri}"
    resource = RestClient::Resource.new(url)
    json = JSON.parse(resource.get, :symbolize_names => true)
  end

  def display
    system('clear')
    puts "\t \t Escolha uma das opções do Desafio 1: \n " 
    puts 
    puts
    puts "\t \t 1 - \t Ranking dos nomes mais comuns em uma determinada Unidade Federativa (UF)\n" 
    puts "\t \t 2 - \t Ranking dos nomes mais comuns em uma determinada cidade\n"
    puts "\t \t 3 - \t Frequência do uso de um nome ao longo dos anos \n"
    puts 
    puts 
    puts "\t \tPARA FINALIZAR DIGITE: 'sair'" 
    puts 
    puts
    print "\t Digite sua escolha: " 
    escolha = $stdin.gets.chomp.to_s
    return menu(escolha)
  end

  def menu(escolha)
    while true do
      if escolha == "1" then
        return Processos.nome_decada 
      elsif escolha == "2" then
        return Processos.todos_sexos_local
      elsif escolha == "3" then
        return Processos.nomes_cidade
      elsif escolha == "sair" then
        return Processos.sair
      else
        return Processos.opcao_invalida
      end
    end
  end
puts
display