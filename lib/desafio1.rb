class Desafio1
  
  def menu
    escolha = $stdin.gets.chomp.to_s
    while true do
      if escolha == "1" then
        return Desafio1_controller.nome_decada 
      elsif escolha == "2" then
        return Desafio1_controller.todos_sexos_local
      elsif escolha == "3" then
        return Desafio1_controller.nomes_cidade
      elsif escolha == "sair" then
        return Desafio1_controller.sair
      else
        return Desafio1_controller.opcao_invalida
      end
    end
  end

end
