"use strict";
// Include our "db"
const db = require("../../db");

// Exports all the functions to perform on the db
module.exports = { getOrdersAll, getOrdersCustomer, getOrderItems };

//GET /orders operationId
async function getOrdersAll(req, res, next) {
  try {
    const { rows } = await db.query(
      "SELECT id as order_id,customer_id,status_code_id,customer_comments,created_at FROM public.order"
    );
    if (rows[0]) {
      res.status(200).json({ orders: rows });
    } else {
      res.status(204).json({ message: `No order data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /orders/{customerId} operationId
async function getOrdersCustomer(req, res, next) {
  const customerId = req.swagger.params.customer_id.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT id as order_id,customer_id,status_code_id,customer_comments,created_at FROM public.order WHERE customer_id=$1",
      [customerId]
    );
    if (rows[0]) {
      res.status(200).json({ orders: rows });
    } else {
      res.status(204).json({ message: `No order data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /orders/{orderId}/items operationId
async function getOrderItems(req, res, next) {
  const orderId = req.swagger.params.order_id.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT O.id as item_id,product_id, P.name as product_name,O.price as price, quantity FROM public.order_item as O JOIN public.product as P ON O.product_id = P.id and O.order_id = $1",
      [orderId]
    );
    if (rows[0]) {
      res.status(200).json({ order: rows });
    } else {
      res
        .status(204)
        .json({ message: `Order ${orderId} not found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}
