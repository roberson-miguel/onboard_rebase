require 'rest-client'
require 'json'


api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"


print "\nNo Brasil, de acordo com o Censo Demográfico 2010,\n
existem cerca de 200 milhões de habitantes com mais\n 
de 130 mil nomes diferentes."

#puts "\n \nDigite o primeiro nome para pesquisar: " 
#nome = gets.chomp
puts
nome = "Maria"
puts "\n \nDigite o primeiro nome para pesquisar: #{nome} \n \n"


groupBy = "UF"

url = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"

rest_resource = RestClient::Resource.new(url)

rest_get = rest_resource.get

rest_json = JSON.parse(rest_get, :symbolize_names => true)

puts "Todas localidades: \n \n #{rest_json.to_s} \n \n "
puts 
puts "Apenas uma localidade: \n \n #{rest_json[0].to_s}\n"
puts

rest_json[0].each { |chave, valor|
puts "Chave: #{chave} ----> guarda o valor #{valor}"
}