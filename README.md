# README

# Prueba técnica Jesús Martínez -> jesus.alberto.vk@gmail.com

* Según el documento que recibi, por experiencia ya trabajando como dev android agrege versionamiento al api. (V1)
* Ocupe mysql/postgresql para dev y production respectivamente
* Integre seeds con el respaldo para mostrarlo en production
* Ocupe Heroku para facilidad
* Integre Auth_Token
* Integre internalizacion
* Desarroller el API & pagina web
* Ocupen namespaces para versionamiento es/en
* Devise para sesiones web
* Ocupe cache con el buscador de activity logs
* Agrege el campo status al buscador activity logs
* Integre JS en el buscador de  activity logs
* Integre HAML para las vistas
* Ocupe FormBuilder para los formularios
* Paginacion
* Realice 90 pruebas del api

## Desarrolle pruebas TDD
  * Babies
  * Activities
  * Assinstant
  * Activity logs
  * Tokens
  * Users
## Para TDD ocupe
* byebug
* rspec
* factory_bot_rails
* faker
* shoulda
* shoulda-matchers
* rails-controller-testing
* database_cleaner
## Validaciones
* Fecha
* Required
* Inclusion
* Fecha de inicio mayor a la de finalizacion
* Formato de fecha
## Comandos para ejecutar
* ``` bundle install --without production ```
* ``` rails db:create ```
* ``` rails db:migrate ```
* ``` rails db:seed ```
## Ejecutar pruebas
* ``` bundle exec rspec ```
* ``` bundle exec rspec --format documentation ```