"use strict";
// Include our "db"
const db = require("../../db");

// Exports all the functions to perform on the db
module.exports = { getUsersAll, getUser, updateUser, createUser };

//GET /users operationId
async function getUsersAll(req, res, next) {
  try {
    const { rows } = await db.query(
      "SELECT customer.id as id, first_name, middle_name, last_name, email_address, password_hash, locked_out FROM public.customer as customer JOIN public.customer_login as customer_login ON customer.id = customer_login.customer_id"
    );
    if (rows[0]) {
      res.status(200).json({ users: rows });
    } else {
      res.status(204).json({ message: `No user data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /users/{userId} operationId
async function getUser(req, res, next) {
  const userId = req.swagger.params.userId.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT customer.id as id, first_name, middle_name, last_name, email_address, password_hash, locked_out FROM public.customer as customer JOIN public.customer_login as customer_login ON customer.id = customer_login.customer_id AND customer.id = $1",
      [userId]
    );
    if (rows[0]) {
      res.status(200).json({ user: rows[0] });
    } else {
      res.status(204).json({ message: `User ${userId} not found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//PUT /users/{userId} operationId
async function updateUser(req, res, next) {
  try {
    const userId = req.swagger.params.userId.value; //req.swagger contains the path parameters
    const {
      first_name,
      middle_name,
      last_name,
      email_address,
    } = req.swagger.params.body.value.user; //req.swagger contains the body parameters
    await db.query(
      "UPDATE public.customer SET first_name = $1, middle_name = $2, last_name = $3, email_address = $4 WHERE id = $5",
      [first_name, middle_name, last_name, email_address, userId]
    );
    res.status(201).json({ message: `User ${userId} updated` });
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//POST /register operationId
async function createUser(req, res, next) {
  const {
    first_name,
    middle_name,
    last_name,
    email_address,
    password,
  } = req.swagger.params.body.value.user; //req.swagger contains the body parameters
  const today = new Date();
  const created_at = today.toISOString().substring(0, 10);
  try {
    await db.query("BEGIN");
    const {
      rows,
    } = await db.query(
      "INSERT INTO public.customer (first_name, middle_name, last_name, email_address,created_at) VALUES ($1, $2, $3, $4,$5) RETURNING id,first_name, middle_name, last_name, email_address",
      [first_name, middle_name, last_name, email_address, created_at]
    );
    const newUserId = rows[0].id;
    await db.query(
      "INSERT INTO public.customer_login (customer_id, password_hash, locked_out) VALUES ($1, $2, false) RETURNING id",
      [newUserId, password]
    );
    await db.query("COMMIT");
    res.status(200).json({ user: rows[0] });
  } catch (e) {
    await db.query("ROLLBACK");
    res.status(500).json({ message: e });
  }
}
