class Desafio2
  def menu
    escolha = $stdin.gets.chomp.to_s
    while true do
      if escolha == "1" then
        return Desafio2_controller.todos_sexos_local
      elsif escolha == "2" then
        return Desafio2_controller.nomes_cidade
      elsif escolha == "sair" then
        return sair
      else
        return opcao_invalida
      end
    end
  end
end


