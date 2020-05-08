require 'rest-client'
require 'json'


api_base_url_nome = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/"


print "\nNo Brasil, de acordo com o Censo Demográfico 2010,\n
existem cerca de 200 milhões de habitantes com mais\n 
de 130 mil nomes diferentes."

puts "\n \nDigite o primeiro nome para pesquisar: " 
nome = gets.chomp

groupBy = "UF"

url = "#{api_base_url_nome}#{nome}?groupBy=#{groupBy}"

rest_resource = RestClient::Resource.new(url)

resultado = rest_resource.get

puts JSON.parse(resultado, :symbolize_names => true)
puts resultado.code

