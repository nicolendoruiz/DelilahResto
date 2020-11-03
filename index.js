const express = require('express');
const bodyParser = require("body-parser");
const cors = require("cors");
const server = express();
const jwt = require('jsonwebtoken');
const firma = 'd3l1l4hR3st0';

const usuarios = require("./gestion-usuarios");
const productos = require("./gestion-productos");
const pedidos = require("./gestion-pedidos");

server.listen(3000, () => { console.log("Servidor puerto 3000"); });
server.get('/', function (req, res) { res.send('Delilah Restó! Nicol Endo Ruiz'); });
server.use(bodyParser.json());
server.use(cors());

//Middlewares
function validacionAdministrador(req, res, next) {
    try {
        const token = req.headers.authorization.split(' ')[1]
        const tokenVerify = jwt.verify(token, firma);
        if (tokenVerify) {
            if (tokenVerify.datosUsuario[0].rol_id == 2) {
                return next()
            } else {
                res.status(401).send('No puede realizar la acción, sólo puede realizarla usuario con rol administrador')
            }
        }
    } catch (err) {
        res.status(400).send('Ha ocurrido un error al validar el usuario');
    }
};

function validarUsuarioLog(req, res, next) {
    try {
        const token = req.headers.authorization.split(' ')[1]
        const tokenVerify = jwt.verify(token, firma)
        if (tokenVerify) {
            req.user = tokenVerify;
            return next()
        } else {
            res.status(401).send('Ha ocurrido un error al validar la sesión del usuario')
        }
    } catch (err) {
        res.status(400).send('Ha ocurrido un error al validar el usuario');
    }
}

//Gestión de productos
server.get('/productos', productos.consultarProductos)
server.post('/productos', validacionAdministrador, productos.crearProducto)
server.put('/productos/:id', validacionAdministrador, productos.modificarProducto)
server.delete('/productos/:id', validacionAdministrador, productos.eliminarProducto)

//Gestión de usuarios
server.get("/usuarios", validacionAdministrador, usuarios.consultarUsuarios);
server.post("/usuarios/login", usuarios.iniciarSesion);
server.post("/usuarios/", usuarios.crearUsuario);
server.put("/usuarios/", validarUsuarioLog, usuarios.modificarUsuario);
server.delete("/usuarios/:id", validacionAdministrador, usuarios.eliminarUsuario);

//Gestión de pedidos
server.get('/pedidos', validacionAdministrador, pedidos.consultarPedidos)
server.post('/pedidos', validarUsuarioLog, pedidos.crearPedido)
server.get('/pedidos/:id', validarUsuarioLog, pedidos.consultarDetallePedido)
// server.put('/pedidos/:id', )
server.delete('/pedidos/:id', validacionAdministrador, pedidos.eliminarPedido) 