require "spec_helper"
require 'rest-client'

describe 'Exibe Menu ' do
  it 'retorna a escolha do usuario caso seja válida' do
    allow($stdin).to receive(:gets).and_return("1\n", "Maria\n")
   
    expect ( output "Esse programa traz um ranking").to_stdout
    
  end
end

#Não funciona! 