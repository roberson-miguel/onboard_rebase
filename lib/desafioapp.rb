require 'rest-client'
require 'json'
require_relative 'display.rb'
require_relative 'processos.rb'

class Desafioapp
  attr_accessor :display, :desafio

  def initialize
    self.desafio = desafio
    self.display = display
  end

  def app
    display = Display.new
    display.bemvindos
    display.app
    menu_app
  end

  def app_desafio1
    app_desafio1 = Display.new
    app_desafio1.menu_desafio1
    menu_app
    app_desafio1.menu
  end

  def app_desafio2
    app_desafio2 = Display.new
    app_desafio2.menu_desafio2
    menu_app
    app_desafio2.menu
  end
  
  def menu_app
    desafio = $stdin.gets.chomp.to_s
    while true do
      if desafio == "1" then
        app_desafio1
      elsif desafio == "2" then
        app_desafio2
      elsif desafio == "3" then
        app_desafio3
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

desafio = Desafioapp.new.app

