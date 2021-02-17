"use strict";
// Include our "db"
const db = require("../../db");

// Exports all the functions to perform on the db
module.exports = { getAll, getCategory, getOne };

//GET /products operationId
async function getAll(req, res, next) {
  const { rows } = await db.query(
    "SELECT id,name,description,category_id,vendor_id,sku,price FROM public.product"
  );
  if (rows) {
    res.json({ products: rows });
  } else {
    res.status(204).send();
  }
}

//GET /products/{categoryCode} operationId
async function getCategory(req, res, next) {
  const categoryCode = req.swagger.params.category_id.value; //req.swagger contains the path parameters
  const {
    rows,
  } = await db.query(
    "SELECT id,name,description,category_id,vendor_id,sku,price FROM public.product WHERE category_id=$1",
    [categoryCode]
  );
  if (rows) {
    res.json({ products: rows });
  } else {
    res.status(204).send();
  }
}

//GET /products/item/{id} operationId
async function getOne(req, res, next) {
  const productId = req.swagger.params.productId.value; //req.swagger contains the path parameters
  const {
    rows,
  } = await db.query(
    "SELECT id,name,description,category_id,vendor_id,sku,price FROM public.product WHERE id=$1",
    [productId]
  );
  if (rows) {
    res.json({ products: rows });
  } else {
    res.status(204).send();
  }
}
