describe 'Exibe Menu ' do
     it 'retorna a escolha do usuario caso seja válida' do
       allow($stdin).to receive(:gets).and_return("1\n", "Maria\n")
       expect { load "./lib/desafio1.rb" }.to output("Escolha uma das opções:").to_stdout
     end
end