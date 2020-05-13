require_relative 'processos.rb'
require_relative 'sexos.rb'

  def display
    puts  "\t Escolha uma das opções: \n " 
    puts 
    puts "\t \tAtalhos para os itens Desafio 1"
    puts "\t \tOpção: "
    puts "\t \t12 - \t Ranking dos nomes mais comuns em uma determinada Unidade Federativa (UF)\n" 
    puts "\t \t15 - \t Ranking dos nomes mais comuns em uma determinada cidade\n"
    puts "\t \t 2 - \t Frequência do uso de um nome ao longo dos anos \n"
    puts 
    puts "\t \tTodas Consultas possiveis "
    puts "\t \tOpção: "
    puts "\t \t 1 - \tPesquisar Nome em Todos Estados" 
    puts "\t \t 2 - \tFrequência do uso de um nome ao longo dos anos \n"
    puts "\t \t 3 - \tRanking de Nomes em Todas Décadas" 
    puts "\t \t 4 - \tRanking de Nomes em única Década, ex. 1950" 
    puts "\t \t 5 - \tRanking de Nomes por único Sexo, ex. Masculino ou Feminino" 
    puts "\t \t 6 - \tPesquisar Nome por único Sexo em Todas Décadas" 
    puts "\t \t 7 - \tPesquisar Nome por Estado" 
    puts "\t \t 8 - \tConsultar UF dos Estados" 
    puts "\t \t 9 - \tRanking de Nomes Masculinos e Femininos" 
    puts "\t \t10 - \tRanking de Nomes Masculinos" 
    puts "\t \t11 - \tRanking de Nomes Femininos \n" 
    puts "\t \t12 - \tRanking dos nomes mais comuns em uma determinada Unidade Federativa (UF) \n" 
    puts "\t \t13 - \tPesquisar Nome mais em uma determinada cidade\n" 
    puts "\t \t14 - \tConsultar Nomes das cidades\n"
    puts "\t \t15 - \tRanking dos nomes mais comuns em uma determinada cidade"
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
        return Processos.nome 
      elsif escolha == "2" then
        return Processos.nome_decada 
      elsif escolha == "3" then
        return Processos.todas_decadas
      elsif escolha == "4" then
        return Processos.decada
      elsif escolha == "5" then
        return Sexos.sexo
      elsif escolha == "6" then
        return Sexos.nome_sexo
      elsif escolha == "7" then
        return Processos.nome_local
      elsif escolha == "8" then
        return Processos.local
      elsif escolha == "9" then
        return Sexos.todos_sexos
      elsif escolha == "10" then
        return Sexos.masculino
      elsif escolha == "11" then
        return Sexos.feminino
      elsif escolha == "12" then
        return Sexos.todos_sexos_local
      elsif escolha == "13" then
        return Processos.nome_cidade
      elsif escolha == "14" then
        return Processos.cidade
      elsif escolha == "15" then
        return Processos.nomes_cidade
      elsif escolha == "sair" then
        return Processos.sair
      else
        return Processos.opcao_invalida
      end
    end
  end

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
display