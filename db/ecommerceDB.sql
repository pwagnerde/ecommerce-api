CREATE TABLE public.customer
(
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(50),
    last_name character varying(150) NOT NULL,
    email_address character varying(200) NOT NULL,
    created_at date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.customer_address
(
    id integer NOT NULL,
    customer_id integer NOT NULL,
    address_street_no character varying(50) NOT NULL,
    address_street_name character varying(100) NOT NULL,
    address_city character varying(50) NOT NULL,
    address_state character varying(50),
    address_postal_code character varying(25) NOT NULL,
    address_country_code character varying(2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.customer_login
(
    id integer NOT NULL,
    customer_id integer NOT NULL,
    password_hash character varying(256) NOT NULL,
    locked_out boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public."order"
(
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status_code_id integer NOT NULL,
    customer_comments character varying(300),
    created_at date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.order_item
(
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price money NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.order_status_code
(
    id integer NOT NULL,
    status_code character varying(20) NOT NULL,
    description character varying(200) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.product
(
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    sku character varying(50) NOT NULL,
    description character varying(500) NOT NULL,
    price money NOT NULL,
    vendor_id integer NOT NULL,
    category_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.product_category
(
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(500) NOT NULL,
    code character varying(3) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.product_vendor
(
    id integer NOT NULL,
    company_code character varying(50) NOT NULL,
    name character varying(150) NOT NULL,
    description character varying(500) NOT NULL,
    address_street_no character varying(50) NOT NULL,
    address_street_name character varying(100) NOT NULL,
    address_city character varying(50) NOT NULL,
    address_state character varying(50),
    address_postal_code character varying(25) NOT NULL,
    address_country_code character varying(2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.shopping_cart
(
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status_code_id integer NOT NULL,
    created_at date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.shopping_cart_item
(
    id integer NOT NULL,
    shopping_cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price money NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.shopping_cart_status
(
    id integer NOT NULL,
    status_code character varying(20) NOT NULL,
    description character varying(200) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public.customer_address
    ADD FOREIGN KEY (customer_id)
    REFERENCES public.customer (id)
    NOT VALID;


ALTER TABLE public.customer_login
    ADD FOREIGN KEY (customer_id)
    REFERENCES public.customer (id)
    NOT VALID;


ALTER TABLE public."order"
    ADD FOREIGN KEY (customer_id)
    REFERENCES public.customer (id)
    NOT VALID;


ALTER TABLE public."order"
    ADD FOREIGN KEY (status_code_id)
    REFERENCES public.order_status_code (id)
    NOT VALID;


ALTER TABLE public.order_item
    ADD FOREIGN KEY (order_id)
    REFERENCES public."order" (id)
    NOT VALID;


ALTER TABLE public.order_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.product (id)
    NOT VALID;


ALTER TABLE public.product
    ADD FOREIGN KEY (category_id)
    REFERENCES public.product_category (id)
    NOT VALID;


ALTER TABLE public.product
    ADD FOREIGN KEY (vendor_id)
    REFERENCES public.product_vendor (id)
    NOT VALID;


ALTER TABLE public.shopping_cart
    ADD FOREIGN KEY (customer_id)
    REFERENCES public.customer (id)
    NOT VALID;


ALTER TABLE public.shopping_cart
    ADD FOREIGN KEY (status_code_id)
    REFERENCES public.shopping_cart_status (id)
    NOT VALID;


ALTER TABLE public.shopping_cart_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.product (id)
    NOT VALID;


ALTER TABLE public.shopping_cart_item
    ADD FOREIGN KEY (shopping_cart_id)
    REFERENCES public.shopping_cart (id)
    NOT VALID;
