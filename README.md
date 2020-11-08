# Delilah Restó

API Rest para la gestión de pedidos en un restaurante: CRUD Usuarios, CRUD Productos yCRUD Pedidos

# Configuración

- Para iniciar el servidor se deben instalar las respectivas dependencias de npm relacionadas en el archivo 'package.json' (npm install).

- El archivo 'bd.sql' tiene el script que deberá ejecutarse para la creación de la base de datos que utiliza la aplicación. Dentro de la información relacionada en el script están algunos usuarios con roles de administrador y cliente.

- Los datos de conexión a la bd tendrán que ser configurados de acuerdo a las credenciales establecidas para tu instancia local de MySQL en el archivo 'conexion-bd.js'.

- El archivo principal es index.js el cual se deberá ejecutar (node index.js). La aplicación está utilizando el puerto 3000.

- En el archivo swaggerDELILAH.yaml se encuentra la documentación de la api relacionando los endpoints y las peticiones respectivas. Se recomienda usar Postman.

# Dependencias 

•	BODY-PARSER
•	CORS
•	EXPRESS
•	JSONWEBTOKEN
•	MYSQL2
•	SEQUELIZE
