# onboard_rebase

### Desafio 1

A primeiro desafio consiste na criação de uma aplicação Ruby para uso no terminal.

Ao ser executada essa aplicação oferece ao seu usuário as seguintes opções de consulta:

  1. Ranking dos nomes mais comuns em uma determinada Unidade Federativa (UF)
    a. Listar todas UFs e obter a sigla da UF que o usuário deseja consultar
    b. Exibir o resultado em 3 tabelas:
      i. Uma para o ranking geral
      ii. Outras duas tabelas separando os resultados para cada sexo

  2. Ranking dos nomes mais comuns em uma determinada cidade
    a. Obter o nome de uma cidade no terminal
    b. Exibir o resultado em 3 tabelas:
      i. Uma para o ranking geral
      ii. Outras duas tabelas separando os resultados para cada sexo

  3. Frequência do uso de um nome ao longo dos anos
    a. Solicitar um ou mais nomes (separados sempre por vírgula)
    b. Exibir uma tabela única, onde cada linha representa uma década e cada
    coluna representa um dos nomes informados na etapa anterior


### Desafio 2

Neste Desafio, queremos otimizar nossa aplicação do desafio 1. 
As UFs e as cidades do país raramente sofrem alterações, então não faz muito sentido consultar a API de localidades várias vezes para exibir o resultado, especialmente nas consultas 1 e 2 do desafio 1.

Nessa etapa fizemos:

1. Uma estrutura de conexão a um banco de dados SQLite;

2. Ao iniciar a aplicação pela primeira vez, devemos criar e popular tabelas para
armazenar todas as UFs e todos os municípios, consultando a API de localidades.

Armazenamos somente os dados essenciais para o uso dentro da aplicação. 

3. Ao realizar as operações que demandam o uso de códigos de UFs e/ou cidades,
utilizamos os dados vindos do banco de dados ao invés da API de localidades.

### Desafio 3

Nesse último desafio coletamos dados da população brasileira residente em 2019 através de um arquivo CSV. Queremos incrementar os resultados das consultas do desafio 1, adicionando em todas
as tabelas exibidas para o usuário, uma nova coluna contendo o percentual que aquele resultado representa dentro do universo escolhido.

Exemplo: Ao consultar o ranking de nomes de mulheres em Angra dos Reis, encontramos
no topo o nome “Maria” com 7.820 pessoas. No CSV com dados da população vimos que
Angra dos Reis possui 203.785 habitantes. Então deveríamos acrescentar uma nova coluna
ao resultado indicando que as 7.820 pessoas chamadas de Maria representam
aproximadamente 3,8% da população da cidade.


### Relação das GEMs utilizadas: 
    `gem install rest-client`
    `gem install rspec`
    `gem install sqlite3`
    `gem csv`

### No inicio do projeto precisei inicializar o rspec 
    `rspec --init`


### Excutando o projeto

  1. Oriento que use o RVM para instalar o Ruby 2.6.3, se voce usa ubuntu pode seguir esse manual https://www.edivaldobrito.com.br/como-instalar-o-ruby-version-manager-no-ubuntu/    
  2. Clone o projeto na sua maquina 
  3. Dentro da pasta do projeto rode o comando `bin/setup`
  4. Para executar o programa use 
     a. Para o desafio 1 `ruby lib/desafio1.rb` 
     b. Para o desafio 2 `ruby lib/desafio2.rb`
     c. Para o desafio 3 `ruby lib/desafio3.rb`
     d. Menu com todos os desafios `ruby lib/desafioapp.rb`
  5. Siga as intruções na tela de cada programa