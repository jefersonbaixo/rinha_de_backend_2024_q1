# RinhaDeBackend2024Q1

Olá!! Meu nome é Jeferson esse é meu projeto para participar da rinha.

contato: [@jefersonjjb](https://www.instagram.com/jefersonjjb/)

# Rodando o projeto

Para rodar o projeto são necessários alguns comandos. Infelizmente não consegui fazer funcionar incluindo os comandos no arquivo do compose :/

`$ docker-compose up -d`

`$ docker exec api01-phoenix sh -c "mix ecto.migrate && mix run priv/repo/seeds.exs"`

`$ ./executar-test-local.sh`

- Caso for rodar os testes novamente é importante apagar a pasta `postgres` dentro do projeto para limpar o banco de dados.

## Stack

- Elixir
- Phoenix
- Postgres
- Nginx

### Obrigado e boa rinha pra nós :D
