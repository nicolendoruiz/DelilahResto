const { sequelize, QueryTypes } = require('./conexion-bd');

async function consultarProductos(req, res) {
    await sequelize.query('SELECT * FROM producto',
        { type: QueryTypes.SELECT })
        .then(result => res.status(200).json(result));
};

async function consultarDetalleProducto(req, res) {
    const idProducto = req.params.id
    await sequelize.query(`SELECT * FROM producto where prod_id = ${idProducto}`,
        { type: QueryTypes.SELECT })
        .then(result => res.status(200).json(result));
};

async function crearProducto(req, res) {
    await sequelize.query(`INSERT INTO producto(prod_nombre, prod_descripcion, prod_imagen, prod_precio) 
    VALUES (:prod_nombre, :prod_descripcion, :prod_imagen, :prod_precio)`,
        { replacements: req.body })
        .then(result => console.log(result) || res.status(200).json('El producto se ha registrado correctamente.'))
        .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
};

async function modificarProducto(req, res) {
    await sequelize.query(`UPDATE producto SET 
    prod_precio=${req.body.prod_precio}
    ,prod_estado=${req.body.prod_estado}
    WHERE prod_id = ${req.params.id}`,
        { type: sequelize.QueryTypes.SET })
        .then(result => console.log(result) || res.status(200).json('La información del producto se ha actualizado correctamente'))
        .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
};

async function eliminarProducto(req, res) {
    let datosProducto = await sequelize.query(`SELECT * FROM producto WHERE prod_id = ${req.params.id}`,
        { type: sequelize.QueryTypes.SELECT });
    if (JSON.stringify(datosProducto) !== '[]') {
        await sequelize.query(`DELETE FROM producto WHERE prod_id = ${req.params.id}`,
            { type: sequelize.QueryTypes.DELETE })
            .then(result => console.log(result) || res.status(200).json('El producto se ha eliminado correctamente'))
            .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
    } else {
        res.status(400).send('Información inválida, no se ha encontrado un producto con los datos ingresados.')
    }
};

module.exports = {
    consultarProductos,
    consultarDetalleProducto,
    crearProducto,
    modificarProducto,
    eliminarProducto
};