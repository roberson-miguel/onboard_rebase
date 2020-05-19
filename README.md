# onboard_rebase

### Desafio 1

A primeira etapa do desafio consta na criação de uma aplicação Ruby para uso no terminal.

Ao ser executada essa aplicação deve oferecer ao seu usuário as seguintes opções de consulta:

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

Além da qualidade e organização do seu código, vamos avaliar também a facilidade de uso das interfaces e a qualidade da exibição dos resultados de cada consulta. Então dedique algum tempo para formatar minimamente as tabelas solicitadas. A sua aplicação pode ser executada de duas formas:

1. Como uma aplicação que fica em execução de forma constante e conta com um
menu para o usuário escolher a consulta a ser realizada ou sair da plicação.

2. Como um CLI, similar a comandos como `git` e `rails` que você executa em seu terminal. Nesse formato você deve ter uma opção `--help` que traz todas as opções possíveis para execução (todas as consultas e como o usuário deve passar os parâmetros necessários em cada consulta)

  # instale as GEM 
    `gem install rest-client`
    `gem install rspec`
    `gem install sqlite3`
    `gem csv`
  # inicialize o rspec 
    `rspec --init`


### Desafio 2

Nesta etapa, queremos otimizar nossa aplicação. As UFs e as cidades do país raramente
sofrem alterações, então não faz muito sentido consultar a API de localidades várias vezes
para exibir o resultado, especialmente nas consultas 1 e 2 da etapa anterior.
Nessa etapa você deve:

1. Criar uma estrutura de conexão a um banco de dados SQLite em sua aplicação

2. Ao iniciar sua aplicação pela primeira vez, você deve criar e popular tabelas para
armazenar todas as UFs e todos os municípios, consultando a API de localidades.
Lembre-se de armazenar somente os dados essenciais para o uso dentro da sua
aplicação. A organização das tabelas fica a seu critério.

3. Ao realizar as operações que demandam o uso de códigos de UFs e/ou cidades,
utilizar os dados vindos do banco de dados ao invés da API de localidades.

### Desafio 3
A última etapa traz dados da população brasileira residente em 2019 através de um arquivo
CSV. Queremos incrementar os resultados das consultas da etapa 1, adicionando em todas
as tabelas exibidas para o usuário, uma nova coluna contendo o percentual que aquele
resultado representa dentro do universo escolhido.

Exemplo: Ao consultar o ranking de nomes de mulheres em Angra dos Reis, encontramos
no topo o nome “Maria” com 7.820 pessoas. No CSV com dados da população vimos que
Angra dos Reis possui 203.785 habitantes. Então deveríamos acrescentar uma nova coluna
ao resultado indicando que as 7.820 pessoas chamadas de Maria representam
aproximadamente 3,8% da população da cidade.

Considerações:

1. O arquivo CSV deve ser armazenado junto com sua aplicação em um diretório a seu
critério

2. A leitura do arquivo pode ser feita em tempo real, de acordo com as consultas
realizadas ou, pode ser incluído como parte do processo de inicialização do banco
de dados. No CSV as UFs e municípios possuem o mesmo código utilizado pela API
de localidades do IBGE.

### Excutando o projeto

  1. Oriento que use o RVM para instalar o Ruby 2.6.3, se voce usa ubuntu pode seguir esse manual https://www.edivaldobrito.com.br/como-instalar-o-ruby-version-manager-no-ubuntu/    
  2. Clone o projeto na sua maquina 
  3. Dentro da pasta do projeto rode o comando `bin/setup`
  4. Execute o comando `bundle install` 
  5. Para executar o programa use 
     a. Para o desafio 1 `ruby lib/desafio1.rb` 
     b. Para o desafio 2 `ruby lib/desafio2.rb`
     c. Para o desafio 3 `ruby lib/desafio3.rb`
  6. Siga as intruções na tela de cada programa