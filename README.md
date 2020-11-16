# ao3_Brunno

Teste feito para processo seletivo na AO3

# Configurações:
 - Ruby 2.7.2
 - Rails 6.0.2
 - Postgresql 12
 - Docker
 
  # Instruções para iniciar a aplicação via docker:
 ```sh
$ docker-compose up
```
Aplicação estará disponível em http://localhost:3000/

# Instruções para iniciar a aplicação sem docker:
- Configurar .env com as variáveis de acordo com o exemplo `.env.sample`
 ```sh
$ bundle install
$ yarn install
$ rails db:setup
```
# Como executar suite de testes:
 ```sh
$ bundle exec rspec spec
```
