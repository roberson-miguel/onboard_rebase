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
  # inicialize o rspec 
    `rspec --init`