"use strict";
// Include our "db"
const db = require("../../db/db.js")();
// Exports all the functions to perform on the db
module.exports = { getAll, getOne, getCategory };

//GET /products operationId
function getAll(req, res, next) {
  res.json({ products: db.findItems() });
}

//GET /products/{categoryCode} operationId
function getCategory(req, res, next) {
  const category = req.swagger.params.categoryCode.value; //req.swagger contains the path parameters
  let products = db.findCategoryItems(category);
  if (products) {
    res.json(products);
  } else {
    res.status(204).send();
  }
}

//GET /products/item/{id} operationId
function getOne(req, res, next) {
  const id = req.swagger.params.productId.value; //req.swagger contains the path parameters
  let product = db.findItems(id);
  if (product) {
    res.json(product);
  } else {
    res.status(204).send();
  }
}