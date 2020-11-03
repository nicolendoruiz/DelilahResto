const { sequelize, QueryTypes } = require('./conexion-bd');

async function consultarPedidos(req, res) {
    await sequelize.query(`SELECT DISTINCT espe.espe_nombre estado
            ,pedi.pedi_fecha fecha
            ,pedi.pedi_id numero
            ,tipa.tipa_nombre formapago
            ,CONCAT(usua.usua_nombre, ' ', usua.usua_apellido) usuario
            ,usua.usua_direccion direccion
            ,usua.usua_telefono telefono
            ,usua.usua_correo correo
            ,usua.usua_username username
            FROM pedido pedi
            INNER JOIN detalle_pedido depe ON pedi.pedi_id = depe.pedi_id 
            INNER JOIN producto prod ON depe.prod_id = prod.prod_id
            INNER JOIN usuario usua ON usua.usua_id = pedi.usua_id
            INNER JOIN tipo_pago tipa ON tipa.tipa_id = pedi.tipa_id
            INNER JOIN historial_estado_pedido hiep ON hiep.hiep_id = (SELECT MAX(hiep_id) FROM historial_estado_pedido WHERE pedi_id=pedi.pedi_id)
            INNER JOIN estado_pedido espe ON espe.espe_id = hiep.espe_id`,
        { type: QueryTypes.SELECT })
        .then(result => res.status(200).json(result));
};

async function consultarDetallePedido(req, res) {
    await sequelize.query(`SELECT 
            pedi.pedi_id numero
            ,prod.prod_nombre producto
            ,depe.depe_cantidad cantidad
            ,prod.prod_precio precio_unitario
            ,prod.prod_precio * depe.depe_cantidad subtotal
            FROM pedido pedi
            INNER JOIN detalle_pedido depe ON pedi.pedi_id = depe.pedi_id 
            INNER JOIN producto prod ON depe.prod_id = prod.prod_id
            WHERE pedi.pedi_id=${req.params.id}`,
        { type: QueryTypes.SELECT })
        .then(result => res.status(200).json(result));
};

async function crearPedido(req, res) {
    var idPedido;
    var idUsuario = req.user.datosUsuario[0].usua_id;
    await sequelize.query(`INSERT INTO pedido(tipa_id, usua_id) VALUES (${req.body.tipa_id}, ${idUsuario})`)
        .then((result) => {
            req.body.detalles.forEach(detalle => {
                idPedido = JSON.stringify(result[0]);
                sequelize.query(`INSERT INTO detalle_pedido(pedi_id, prod_id, depe_cantidad) VALUES (${JSON.stringify(result[0])},${detalle.prod_id},${detalle.depe_cantidad})`)
            })
        }).then((result) => {
            sequelize.query(`INSERT INTO historial_estado_pedido(pedi_id, espe_id) VALUES (${idPedido},1)`)
        }).then(result => console.log(result) || res.status(200).json('El pedido se ha registrado correctamente'))
        .catch(err => console.log(err) || res.status(400).send('Información inválida, intente nuevamente.'))
};

async function eliminarPedido(req, res) {
    var estadopedidoconst;
    const pedido = await sequelize.query(`SELECT * FROM pedido WHERE pedi_id = ${req.params.id}`,
        { type: sequelize.QueryTypes.SELECT });
    if (pedido != "") {
        estadopedidoconst = await sequelize.query(`SELECT * FROM historial_estado_pedido hiep
                INNER JOIN estado_pedido espe ON hiep.espe_id= espe.espe_id 
                where hiep_id IN 
                (SELECT MAX(hiep_id) FROM historial_estado_pedido WHERE pedi_id=${result[0].pedi_id})`,
            { type: sequelize.QueryTypes.SELECT })
    } else {
        return res.status(400).json(`No hay pedidos registrados con número ${req.params.id}`);
    }
    if (estadopedidoconst[0].espe_id == "1") {
        sequelize.query(`DELETE FROM pedido WHERE pedi_id = ${req.params.id}`, { type: sequelize.QueryTypes.DELETE })
        sequelize.query(`DELETE FROM detalle_pedido WHERE pedi_id = ${req.params.id}`, { type: sequelize.QueryTypes.DELETE })
        sequelize.query(`DELETE FROM historial_estado_pedido WHERE pedi_id = ${req.params.id}`, { type: sequelize.QueryTypes.DELETE })
            .then(result => (console.log(result)) || res.status(200).json(`El pedido No.${req.params.id} se ha eliminado correctamente`))
            .catch(error => console.log(error) || res.status(400).send('Información inválida, intente nuevamente.'))
    } else {
        return res.status(400).json(`El pedido está en estado '${estadopedidoconst[0].espe_nombre}', no podrá eliminar el registro, deberá cambiar el estado a Cancelado`);
    }
};

module.exports = {
    consultarPedidos,
    crearPedido,
    consultarDetallePedido,
    eliminarPedido
};