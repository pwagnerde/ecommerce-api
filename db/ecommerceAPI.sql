CREATE TABLE "customer" (
  "id" integer PRIMARY KEY NOT NULL,
  "first_name" "character varying(100)" NOT NULL,
  "middle_name" "character varying(50)",
  "last_name" "character varying(150)" NOT NULL,
  "email_address" "character varying(200)" NOT NULL,
  "created_at" date NOT NULL
);

CREATE TABLE "customer_address" (
  "id" integer PRIMARY KEY NOT NULL,
  "customer_id" integer NOT NULL,
  "address_street_no" "character varying(50)" NOT NULL,
  "address_street_name" "character varying(100)" NOT NULL,
  "address_city" "character varying(50)" NOT NULL,
  "address_state" "character varying(50)",
  "address_postal_code" "character varying(25)" NOT NULL,
  "address_country_code" "character varying(2)" NOT NULL
);

CREATE TABLE "customer_login" (
  "id" integer PRIMARY KEY NOT NULL,
  "customer_id" integer NOT NULL,
  "password_hash" "character varying(256)" NOT NULL,
  "locked_out" boolean NOT NULL
);

CREATE TABLE "order" (
  "id" integer PRIMARY KEY NOT NULL,
  "customer_id" integer NOT NULL,
  "status_code_id" integer NOT NULL,
  "customer_comments" "character varying(300)",
  "created_at" date NOT NULL
);

CREATE TABLE "order_item" (
  "id" integer PRIMARY KEY NOT NULL,
  "order_id" integer NOT NULL,
  "product_id" integer NOT NULL,
  "quantity" integer NOT NULL,
  "price" money NOT NULL
);

CREATE TABLE "order_status_code" (
  "id" integer PRIMARY KEY NOT NULL,
  "status_code" "character varying(20)" NOT NULL,
  "description" "character varying(200)" NOT NULL
);

CREATE TABLE "product" (
  "id" integer PRIMARY KEY NOT NULL,
  "name" "character varying(100)" NOT NULL,
  "sku" "character varying(50)" NOT NULL,
  "description" character(500) NOT NULL,
  "price" money NOT NULL,
  "vendor_id" integer NOT NULL,
  "category_id" integer NOT NULL
);

CREATE TABLE "product_category" (
  "id" integer PRIMARY KEY NOT NULL,
  "name" "character varying(50)" NOT NULL,
  "description" "character varying(500)" NOT NULL,
  "code" "character varying(3)"
);

CREATE TABLE "product_vendor" (
  "id" integer PRIMARY KEY NOT NULL,
  "company_code" "character varying(50)" NOT NULL,
  "name" "character varying(150)" NOT NULL,
  "description" "character varying(500)" NOT NULL,
  "address_street_no" "character varying(50)" NOT NULL,
  "address_street_name" "character varying(100)" NOT NULL,
  "address_city" "character varying(50)" NOT NULL,
  "address_state" "character varying(50)",
  "address_postal_code" "character varying(25)" NOT NULL,
  "address_country_code" "character varying(2)" NOT NULL
);

CREATE TABLE "shopping_cart" (
  "id" integer PRIMARY KEY NOT NULL,
  "customer_id" integer NOT NULL,
  "status_code_id" integer NOT NULL,
  "created_at" date NOT NULL
);

CREATE TABLE "shopping_cart_item" (
  "id" integer PRIMARY KEY NOT NULL,
  "shopping_cart_id" integer NOT NULL,
  "product_id" integer NOT NULL,
  "quantity" integer NOT NULL,
  "price" money NOT NULL
);

CREATE TABLE "shopping_cart_status" (
  "id" integer PRIMARY KEY NOT NULL,
  "status_code" "character varying(20)" NOT NULL,
  "description" "character varying(200)" NOT NULL
);

ALTER TABLE "customer_address" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

ALTER TABLE "customer_login" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

ALTER TABLE "order" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

ALTER TABLE "order" ADD FOREIGN KEY ("status_code_id") REFERENCES "order_status_code" ("id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("order_id") REFERENCES "order" ("id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "product" ADD FOREIGN KEY ("category_id") REFERENCES "product_category" ("id");

ALTER TABLE "product" ADD FOREIGN KEY ("vendor_id") REFERENCES "product_vendor" ("id");

ALTER TABLE "shopping_cart" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

ALTER TABLE "shopping_cart" ADD FOREIGN KEY ("status_code_id") REFERENCES "shopping_cart_status" ("id");

ALTER TABLE "shopping_cart_item" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "shopping_cart_item" ADD FOREIGN KEY ("shopping_cart_id") REFERENCES "shopping_cart" ("id");
