require 'rest-client'
require 'json'


system("clear")
puts
puts
puts "\t \t Esse programa traz um ranking iterativo dos nomes a partir dos dados mais recentes do CENSO,
            o IBGE lançou essa aplicação Web que fez muito sucesso em 2016. Você pode consultar os nomes mais 
            populares que pode ser organizado em décadas e/ou estados do país.

            Além disso você pode buscar pelo seu nome e entender quão frequente é esse nome em um estado ou
            uma cidade do país. Algumas informações podem ser separadas ainda pela década ou pelo
            sexo atribuído ao nome.\n"

def self.app
  puts "\t \t Escolha um dos desafios: \n " 
  puts 
  puts
  puts "\t \t 1 - \t Desafio 1 aplicação Ruby para uso no terminal acessando API em tempo real.\n" 
  puts "\t \t 2 - \t Desafio 2 a mesma aplicação Ruby com estrutura de conexão a um BD SQLite\n"
  puts "\t \t 3 - \t Desafio 3 nossa app acessando através de um arquivo CSV\n"
  puts 
  puts 
  puts "\t \tPARA FINALIZAR DIGITE: 'sair'" 
  puts 
  puts
  print "\t Escolha um dos desafio: " 
  desafio = $stdin.gets.chomp.to_s
  return self.menu_app(desafio)
end

def self.menu_app(desafio)
  while true do
    if desafio == "1" then
      system('ruby desafio1.rb') 
    elsif desafio == "2" then
      system('ruby desafio2.rb') 
    elsif desafio == "3" then
      system('ruby desafio3.rb') 
    elsif desafio == "sair" then
      return self.sair
    else
      return self.opcao_invalida
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
  return app
end

def self.sair 
  puts 
  puts                            
  puts "\t \t Saindo...Obrigado..."          
  puts               
  puts                                    
  sleep 1.9
end
puts
app