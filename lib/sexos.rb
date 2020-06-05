require 'rest-client'
require 'json'

class Sexos

  def self.todos_sexos_local #menu 2
    system("clear")
    uri = "estados"
    json = url_base_local(uri)
    puts "\n \t \t Siglas dos Estados"
    puts
    json.each do |localidade|
    puts "\t \t #{localidade[:sigla]} - #{localidade[:nome]} "
    end

    puts "\n \t Digite uma sigla do Estado para pesquisar - Veja Tabela acima."
    print "\t Exemplo, digite 'SP' para Ranking por Sexo no Estado de São Paulo: " 
    sigla = gets.chomp
    uf = nil
    json.each do |localidade|
      if localidade[:sigla] == sigla
        uf = localidade[:id]
      end
    end

    puts "\n \t Exibindo Ranking Geral para o Estado de: #{uf}" 
    puts
    uri = "ranking/?localidade=#{uf}"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
    
    puts "\n \t Exibindo Ranking Sexo Masculino por Estado" 
    puts
    uri = "ranking/?sexo=M&localidade=#{uf}"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts

    puts "\n \t Exibindo Ranking Sexo Feminino por Estado" 
    puts
    uri = "ranking/?sexo=F&localidade=#{uf}"
    json = url_base(uri)
    json[0][:res].each do |sexo|
      puts "\t #{sexo[:ranking]}.#{sexo[:nome]} \tFrequência: #{sexo[:frequencia]}"
    end
    puts
  end

end
