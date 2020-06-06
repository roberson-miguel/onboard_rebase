require 'rest-client'
require 'json'
require "sqlite3"
require_relative 'views/display.rb'
require_relative 'controllers/desafio1_controller.rb'
require_relative 'controllers/desafio2_controller.rb'
require_relative 'desafio1.rb'
require_relative 'desafio2.rb'

class Desafioapp

  def app
    display = Display.new
    display.bemvindos
    display.app
    menu_app
  end
  
  def menu_app
    desafio = $stdin.gets.chomp.to_s
    while true do
      if desafio == "1" then
        return app_desafio1
      elsif desafio == "2" then
        return app_desafio2
      elsif desafio == "3" then
        return app_desafio3
      elsif desafio == "sair" then
        return self.sair
      else
        return self.opcao_invalida
      end
    end
  end

  def app_desafio1
    menu1 = Display.new.menu_desafio1
    desafio1 = Desafio1.new
    desafio1.menu
  end

  def app_desafio2
    menu2 = Display.new.menu_desafio2
    desafio2 = Desafio2.new
    desafio2.menu
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

desafio = Desafioapp.new.app

