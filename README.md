# README

Como preparar el ambiente

1. Clonar el repositorio
2. Navegar a la carpeta del repositorio creada
3. Ejecutar bundle install para instalar las dependencias del proyecto
4. Ejecutar el comando rails db:create para crear la base de datos
5. Ejecutar el comando rails db:migrate para migrar la base de datos
6. Ejecutar el comando rails db:seed para popular la base de datos
7. Ejecutar el comando rails s para encender el servidor
8. Ingresar a localhost:3000 

Usuario default
  Username: default
  Password: default

Test

Los test se ejecutar con rspec de la siguiente forma - bundle exec rspec spec/controllers/nombre_del_test_a_ejecutar


Documentacion de la API 
Ejemplos

post /usuarios
 	send: curl -X POST localhost:3000/usuarios -H "Content-Type:application/json" -d '{"username": "pablo", "passwd": "123"}'
 	receive: {"id":8,"username":"pablo","passwd":"123","created_at":"2019-12-10T01:16:46.278Z","updated_at":"2019-12-10T01:16:46.278Z"}

post /sesiones
	send: curl -X POST localhost:3000/sesiones -H "Content-Type:application/json" -d '{"u": "Joe", "p": "123"}'
	receive: {"authentication":"371a52a78f29762e399494eb53fd4c1b3a2409e8"}

get /productos
	send: curl localhost:3000/productos -H "Content-Type:application/json" [-d '{q:[scarce/all/in_stock]}']
	receive: 

