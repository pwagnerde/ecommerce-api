const { Pool } = require("pg");
const pool = new Pool({
  user: "dbuser",
  host: "localhost",
  database: "ecommerce",
  password: "password",
  port: 5432,
});

module.exports = {
  query: (text, params) => pool.query(text, params),
};
