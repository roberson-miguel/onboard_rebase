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
        Display.new.sair
        break
      else
        Display.new.opcao_invalida
        return app
      end
    end
  end

  def app_desafio1
    Display.new.menu_desafio1
    Desafio1.new.menu
    Display.new.continuar
    continua = $stdin.gets.chomp
    if continua == 'sair'
      Display.new.sair
    else
      return Desafioapp.new.app_desafio1
    end
  end

  def app_desafio2
    Display.new.menu_desafio2
    Desafio2.new.menu
    Display.new.continuar
    continua = $stdin.gets.chomp
    if continua == 'sair'
      Display.new.sair
    else
      return Desafioapp.new.app_desafio2
    end
  end

end

Desafioapp.new.app

