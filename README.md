# RinhaDeBackend2024Q1

Olá!! Meu nome é Jeferson esse é meu projeto para participar da rinha.

contato: [@jefersonjjb](https://www.instagram.com/jefersonjjb/)

# Rodando o projeto

Para rodar o projeto são necessários alguns comandos. Infelizmente não consegui fazer funcionar incluindo os comandos no arquivo do compose :/

- Comando para subir os containers
  `$ docker-compose up -d`
- Comando para rodar as migrations e popular o banco
  `$ docker exec api01-phoenix sh -c "mix ecto.migrate && mix run priv/repo/seeds.exs"`
- Executar os testes
  `$ ./executar-test-local.sh`

## Stack

- Elixir
- Phoenix
- Postgres
- Nginx

### Obrigado e boa rinha pra nós :D
