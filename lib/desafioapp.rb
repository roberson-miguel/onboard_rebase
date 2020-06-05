require 'rest-client'
require 'json'
require_relative 'display.rb'

class Desafioapp

  def app
    Display.new.app
  end

  def menu_app(desafio)
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

end

Desafioapp.new.app
