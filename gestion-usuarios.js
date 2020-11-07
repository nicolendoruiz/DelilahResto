const { sequelize, QueryTypes } = require('./conexion-bd');
const jwt = require('jsonwebtoken')
const firma = 'd3l1l4hR3st0';

async function consultarUsuarios(req, res) {
    await sequelize.query('SELECT * FROM usuario',
        { type: QueryTypes.SELECT })
        .then(result => res.status(200).json(result));
};

async function crearUsuario(req, res) {
    await sequelize.query(`INSERT INTO usuario(usua_nombre, usua_apellido, usua_username, usua_password, usua_direccion, usua_telefono, usua_correo) 
    VALUES (:usua_nombre, :usua_apellido, :usua_username, :usua_password, :usua_direccion, :usua_telefono, :usua_correo)`,
        { replacements: req.body })
        .then(result => console.log(result) || res.status(200).json('El usuario se ha registrado correctamente.'))
        .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
};

async function modificarUsuario(req, res) {
    var idUsuario = req.user.datosUsuario[0].usua_id;
    await sequelize.query(`UPDATE usuario SET usua_direccion='${req.body.usua_direccion}',usua_telefono=${req.body.usua_telefono},usua_correo='${req.body.usua_correo}' WHERE usua_id = ${idUsuario}`,
        { type: sequelize.QueryTypes.SET })
        .then(result => console.log(result) || res.status(200).json('La información se ha actualizado correctamente'))
        .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
};

async function eliminarUsuario(req, res) {
    let datosUser = await sequelize.query(`SELECT * FROM usuario WHERE usua_id = ${req.params.id}`,
        { type: sequelize.QueryTypes.SELECT });
    if (JSON.stringify(datosUser) !== '[]') {
        await sequelize.query(`DELETE FROM usuario WHERE usua_id = ${req.params.id}`,
            { type: sequelize.QueryTypes.DELETE })
            .then(result => console.log(result) || res.status(200).json('El usuario se ha eliminado correctamente'))
            .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
    } else {
        res.status(400).send('Información inválida, no se ha encontrado un usuario con los datos ingresados.')
    }
};

async function iniciarSesion(req, res) {
    const nombreUsuario = req.body.usuario;
    const contraUsuario = req.body.contrasenia;
    let datosUsuario = await sequelize.query(`SELECT usua_id, usua_username, usua_password,rol_id FROM usuario WHERE usua_username="${nombreUsuario}"`,
        { type: sequelize.QueryTypes.SELECT });
    if (JSON.stringify(datosUsuario) !== '[]') {
        if (datosUsuario[0].usua_password == contraUsuario) {
            const token = jwt.sign({ datosUsuario }, firma);
            res.json({ token });
        } else {
            res.status(400).send('Información inválida, usuario o contraseña incorrectos.')
        }
    } else {
        res.status(400).send('Información inválida, no se ha encontrado un usuario con los datos ingresados.')
    }
};

module.exports = {
    consultarUsuarios,
    crearUsuario,
    modificarUsuario,
    eliminarUsuario,
    iniciarSesion
};