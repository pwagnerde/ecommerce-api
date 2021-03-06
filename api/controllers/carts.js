"use strict";
// Include our "db"
const db = require("../../db");

// Exports all the functions to perform on the db
module.exports = {
  getCartsAll,
  getCartsCustomer,
  getCartItems,
  orderCartItems,
  addCartItems,
  removeCartItems,
};

//GET /carts operationId
async function getCartsAll(req, res, next) {
  try {
    const { rows } = await db.query(
      "SELECT id as cart_id,customer_id,status_code_id,created_at FROM public.shopping_cart"
    );
    if (rows[0]) {
      res.status(200).json({ orders: rows });
    } else {
      res
        .status(204)
        .json({ message: `No shopping cart data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /carts/{customerId} operationId
async function getCartsCustomer(req, res, next) {
  const customerId = req.swagger.params.customer_id.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT id as cart_id,customer_id,status_code_id,created_at FROM public.shopping_cart WHERE customer_id=$1",
      [customerId]
    );
    if (rows[0]) {
      res.status(200).json({ orders: rows });
    } else {
      res
        .status(204)
        .json({ message: `No shopping cart data found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//GET /carts/{cartId}/items operationId
async function getCartItems(req, res, next) {
  const cartId = req.swagger.params.cart_id.value; //req.swagger contains the path parameters
  try {
    const {
      rows,
    } = await db.query(
      "SELECT O.id as item_id,product_id, P.name as product_name,O.price as price, quantity FROM public.shopping_cart_item as O JOIN public.product as P ON O.product_id = P.id and O.shopping_cart_id = $1",
      [cartId]
    );
    if (rows[0]) {
      res.status(200).json({ order: rows });
    } else {
      res
        .status(204)
        .json({ message: `Shopping cart ${cartId} not found in database` });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//PUT /carts/{cartId}/items/add operationId
async function addCartItems(req, res, next) {
  const cartId = req.swagger.params.cart_id.value;
  const productId = req.swagger.params.body.value.shopping_cart_item.product_id;
  const productPrice = req.swagger.params.body.value.shopping_cart_item.price;
  const productQty = req.swagger.params.body.value.shopping_cart_item.quantity;
  try {
    let result = await db.query(
      "SELECT id FROM public.shopping_cart_item WHERE product_id = $1 AND shopping_cart_id = $2",
      [productId, cartId]
    );
    if (result.rows[0]) {
      // Update price & quantity
      await db.query(
        "UPDATE public.shopping_cart_item SET price = $1, quantity = $2 WHERE id = $3",
        [productPrice, productQty, result.rows[0].id]
      );
      res
        .status(200)
        .json({ message: "Product quantity & price updated in shopping card" });
    } else {
      await db.query(
        "INSERT INTO public.shopping_cart_item (shopping_cart_id, product_id, price, quantity) VALUES ($1, $2, $3,$4)",
        [cartId, productId, productPrice, productQty]
      );
      res.status(200).json({ message: "New product added to shopping card" });
    }
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//DELETE /carts/{cartId}/items operationId
async function removeCartItems(req, res, next) {
  const cartId = req.swagger.params.cart_id.value; //req.swagger contains the path parameters
  try {
    await db.query(
      "DELETE FROM public.shopping_cart_item WHERE shopping_cart_id = $1",
      [cartId]
    );
    res.status(200).json({ message: "All shopping cart items removed" });
  } catch (e) {
    res.status(500).json({ message: e });
  }
}

//POST /carts/{cartId}/checkout
async function orderCartItems(req, res, next) {
  const cartId = req.swagger.params.cart_id.value; //req.swagger contains the path parameters
  const today = new Date();
  const created_at = today.toISOString().substring(0, 10);
  const completedOrderStatus = 6; //Completed
  const orderedShoppingCardStatus = 3; //checked out
  const newShoppingCardStatus = 1; //open
  try {
    await db.query("BEGIN");
    console.log("START");
    const {
      rows,
    } = await db.query(
      "INSERT INTO public.order (customer_id, status_code_id, created_at) VALUES((SELECT customer_id from public.shopping_cart WHERE id = $1),$2,$3) RETURNING id",
      [cartId, completedOrderStatus, created_at]
    );
    const newOrderId = rows[0].id;
    const result = await db.query(
      "SELECT product_id, quantity, price FROM shopping_cart_item WHERE shopping_cart_id = $1",
      [cartId]
    );
    const cart_items = result.rows;
    for (let i = 0; i < cart_items.length; i++) {
      await db.query(
        "INSERT INTO public.order_item (order_id, product_id, quantity, price) VALUES($1,$2,$3,$4)",
        [
          newOrderId,
          cart_items[i].product_id,
          cart_items[i].quantity,
          cart_items[i].price,
        ]
      );
    }
    await db.query(
      "UPDATE public.shopping_cart SET status_code_id = $1 WHERE id = $2",
      [orderedShoppingCardStatus, cartId]
    );
    await db.query(
      "INSERT INTO public.shopping_cart (customer_id, status_code_id, created_at) VALUES((SELECT customer_id from public.shopping_cart WHERE id = $1),$2,$3)",
      [cartId, newShoppingCardStatus, created_at]
    );
    await db.query("COMMIT");
    res
      .status(200)
      .json({ message: `Shopping card ordered. Order id: ${newOrderId}` });
  } catch (e) {
    console.log("CATCH");
    res.status(500).json({ message: e });
  }
}
