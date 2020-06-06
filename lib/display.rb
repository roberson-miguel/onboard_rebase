class Display
  
  def bemvindos
    system("clear")
    puts
    puts "\t \t Esse programa traz um ranking iterativo dos nomes a partir dos dados mais recentes do CENSO.\n
                  O IBGE lançou essa aplicação Web que fez muito sucesso em 2016. Você pode consultar os nomes mais 
                  populares que pode ser organizado em décadas e/ou estados do país.

                  Além disso você pode buscar pelo seu nome e entender quão frequente é esse nome em um estado ou
                  uma cidade do país. Algumas informações podem ser separadas ainda pela década ou pelo
                  sexo atribuído ao nome.\n"
  end

  def app 
    puts
    puts "\t \t Escolha um dos desafios: \n " 
    puts 
    puts
    puts "\t \t 1 - \t Desafio 1 aplicação Ruby para uso no terminal acessando API em tempo real.\n" 
    puts "\t \t 2 - \t Desafio 2 a mesma aplicação Ruby com estrutura de conexão a um BD SQLite\n"
    puts "\t \t 3 - \t Desafio 3 nossa app acessando através de um arquivo CSV\n"
    puts 
    puts 
    puts "\t \t PARA FINALIZAR DIGITE: 'sair'" 
    puts 
    puts
    print "\t \t Escolha um dos desafio: " 
  end

  def menu_desafio1
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
  end

  def menu_desafio2
    system('clear')
    puts "\t \t Escolha uma das opções do Desafio 2: \n " 
    puts 
    puts
    puts "\t \t 1 - \t Ranking dos nomes mais comuns em uma determinada Unidade Federativa (UF)\n" 
    puts "\t \t 2 - \t Ranking dos nomes mais comuns em uma determinada cidade\n"
    puts 
    puts "\t \tPARA FINALIZAR DIGITE: 'sair'" 
      puts 
      puts
      print "\t Digite sua escolha: " 
  end
end