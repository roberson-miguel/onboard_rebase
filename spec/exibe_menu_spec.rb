describe 'Exibe Menu ' do
    it 'retorna a escolha do usuario caso seja válida' do
      allow($stdin).to receive(:gets).and_return("1\n", "Maria\n")
      expect { load "./lib/desafio1.rb" }
      expect ( output "Esse programa traz um ranking").to_stdout
      expect ("Esse programa traz um ranking").to_str
    end
end
  