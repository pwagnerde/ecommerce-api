"use strict";
// Include our "db"
const db = require("../../db");

// Exports all the functions to perform on the db
module.exports = { getProductsAll, getProductsCategory, getProduct };

//GET /products operationId
async function getProductsAll(req, res, next) {
  try {
    const { rows } = await db.query(
      "SELECT id,name,description,category_id,vendor_id,sku,price FROM public.product"
    );
    if (rows[0]) {
      res.status(200).json({ products: rows });
    } else {
      res.status(204).json({ message: `No product data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /products/{categoryCode} operationId
async function getProductsCategory(req, res, next) {
  const categoryCode = req.swagger.params.category_id.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT id,name,description,category_id,vendor_id,sku,price FROM public.product WHERE category_id=$1",
      [categoryCode]
    );
    if (rows[0]) {
      res.status(200).json({ products: rows });
    } else {
      res.status(204).json({ message: `No product data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /products/item/{id} operationId
async function getProduct(req, res, next) {
  const productId = req.swagger.params.productId.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT id,name,description,category_id,vendor_id,sku,price FROM public.product WHERE id=$1",
      [productId]
    );
    if (rows[0]) {
      res.status(200).json({ product: rows[0] });
    } else {
      res
        .status(204)
        .json({ message: `Product ${productId} not found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}
