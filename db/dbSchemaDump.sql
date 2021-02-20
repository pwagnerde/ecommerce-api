--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(50),
    last_name character varying(150) NOT NULL,
    email_address character varying(200) NOT NULL,
    created_at date NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.customer_address_id_seq OWNER TO postgres;

--
-- Name: customer_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_address (
    id integer DEFAULT nextval('public.customer_address_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    address_street_no character varying(50) NOT NULL,
    address_street_name character varying(100) NOT NULL,
    address_city character varying(50) NOT NULL,
    address_state character varying(50),
    address_postal_code character varying(25) NOT NULL,
    address_country_code character varying(2) NOT NULL
);


ALTER TABLE public.customer_address OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_id_seq OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;


--
-- Name: customer_login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_login (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    password_hash character varying(256) NOT NULL,
    locked_out boolean NOT NULL
);


ALTER TABLE public.customer_login OWNER TO postgres;

--
-- Name: customer_login_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_login_id_seq OWNER TO postgres;

--
-- Name: customer_login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_login_id_seq OWNED BY public.customer_login.id;


--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status_code_id integer NOT NULL,
    customer_comments character varying(300),
    created_at date NOT NULL
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price money NOT NULL
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- Name: order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_item_id_seq OWNER TO postgres;

--
-- Name: order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_item_id_seq OWNED BY public.order_item.id;


--
-- Name: order_status_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status_code (
    id integer NOT NULL,
    status_code character varying(20) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.order_status_code OWNER TO postgres;

--
-- Name: order_status_code_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_status_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_status_code_id_seq OWNER TO postgres;

--
-- Name: order_status_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_status_code_id_seq OWNED BY public.order_status_code.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    sku character varying(50) NOT NULL,
    description character varying(500) NOT NULL,
    price money NOT NULL,
    vendor_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(500) NOT NULL,
    code character varying(3) NOT NULL
);


ALTER TABLE public.product_category OWNER TO postgres;

--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_category_id_seq OWNER TO postgres;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: product_vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_vendor (
    id integer NOT NULL,
    company_code character varying(50) NOT NULL,
    name character varying(150) NOT NULL,
    description character varying(500) NOT NULL,
    address_street_no character varying(50) NOT NULL,
    address_street_name character varying(100) NOT NULL,
    address_city character varying(50) NOT NULL,
    address_state character varying(50),
    address_postal_code character varying(25) NOT NULL,
    address_country_code character varying(2) NOT NULL
);


ALTER TABLE public.product_vendor OWNER TO postgres;

--
-- Name: product_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_vendor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_vendor_id_seq OWNER TO postgres;

--
-- Name: product_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_vendor_id_seq OWNED BY public.product_vendor.id;


--
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    status_code_id integer NOT NULL,
    created_at date NOT NULL
);


ALTER TABLE public.shopping_cart OWNER TO postgres;

--
-- Name: shopping_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_id_seq OWNER TO postgres;

--
-- Name: shopping_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_cart_id_seq OWNED BY public.shopping_cart.id;


--
-- Name: shopping_cart_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart_item (
    id integer NOT NULL,
    shopping_cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price money NOT NULL
);


ALTER TABLE public.shopping_cart_item OWNER TO postgres;

--
-- Name: shopping_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_item_id_seq OWNER TO postgres;

--
-- Name: shopping_cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_cart_item_id_seq OWNED BY public.shopping_cart_item.id;


--
-- Name: shopping_cart_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart_status (
    id integer NOT NULL,
    status_code character varying(20) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.shopping_cart_status OWNER TO postgres;

--
-- Name: shopping_cart_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_cart_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_status_id_seq OWNER TO postgres;

--
-- Name: shopping_cart_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_cart_status_id_seq OWNED BY public.shopping_cart_status.id;


--
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq'::regclass);


--
-- Name: customer_login id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_login ALTER COLUMN id SET DEFAULT nextval('public.customer_login_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: order_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item ALTER COLUMN id SET DEFAULT nextval('public.order_item_id_seq'::regclass);


--
-- Name: order_status_code id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_code ALTER COLUMN id SET DEFAULT nextval('public.order_status_code_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- Name: product_vendor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_vendor ALTER COLUMN id SET DEFAULT nextval('public.product_vendor_id_seq'::regclass);


--
-- Name: shopping_cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart ALTER COLUMN id SET DEFAULT nextval('public.shopping_cart_id_seq'::regclass);


--
-- Name: shopping_cart_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_item ALTER COLUMN id SET DEFAULT nextval('public.shopping_cart_item_id_seq'::regclass);


--
-- Name: shopping_cart_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_status ALTER COLUMN id SET DEFAULT nextval('public.shopping_cart_status_id_seq'::regclass);


--
-- Name: customer_address customer_address_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_customer_id_key UNIQUE (customer_id);


--
-- Name: customer_address customer_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_pkey PRIMARY KEY (id);


--
-- Name: customer customer_email_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_email_address_key UNIQUE (email_address);


--
-- Name: customer_login customer_login_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_login
    ADD CONSTRAINT customer_login_customer_id_key UNIQUE (customer_id);


--
-- Name: customer_login customer_login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_login
    ADD CONSTRAINT customer_login_pkey PRIMARY KEY (id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_status_code order_status_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_code
    ADD CONSTRAINT order_status_code_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_vendor product_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_vendor
    ADD CONSTRAINT product_vendor_pkey PRIMARY KEY (id);


--
-- Name: shopping_cart_status shopping_card_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_status
    ADD CONSTRAINT shopping_card_status_pkey PRIMARY KEY (id);


--
-- Name: shopping_cart_item shopping_cart_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_pkey PRIMARY KEY (id);


--
-- Name: shopping_cart shopping_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pkey PRIMARY KEY (id);


--
-- Name: fki_order_customer_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_order_customer_id_fkey ON public."order" USING btree (customer_id);


--
-- Name: fki_order_item_order_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_order_item_order_id_fkey ON public.order_item USING btree (order_id);


--
-- Name: fki_order_item_product_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_order_item_product_id_fkey ON public.order_item USING btree (product_id);


--
-- Name: fki_order_status_code_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_order_status_code_id_fkey ON public."order" USING btree (status_code_id);


--
-- Name: fki_product_category_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_category_id_fkey ON public.product USING btree (category_id);


--
-- Name: fki_shopping_cart_item_customer_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_shopping_cart_item_customer_id_fkey ON public.shopping_cart_item USING btree (shopping_cart_id);


--
-- Name: fki_shopping_cart_item_product_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_shopping_cart_item_product_id_fkey ON public.shopping_cart_item USING btree (product_id);


--
-- Name: customer_address customer_address_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT customer_address_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE CASCADE;


--
-- Name: customer_login customer_login_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_login
    ADD CONSTRAINT customer_login_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE CASCADE;


--
-- Name: order order_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE SET NULL;


--
-- Name: order_item order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(id) ON DELETE RESTRICT;


--
-- Name: order_item order_item_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE RESTRICT;


--
-- Name: order order_status_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_status_code_id_fkey FOREIGN KEY (status_code_id) REFERENCES public.order_status_code(id) ON DELETE RESTRICT;


--
-- Name: product product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.product_category(id) ON DELETE RESTRICT;


--
-- Name: product product_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.product_vendor(id) ON DELETE RESTRICT;


--
-- Name: shopping_cart shopping_cart_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON DELETE SET NULL;


--
-- Name: shopping_cart_item shopping_cart_item_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: shopping_cart_item shopping_cart_item_shopping_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_shopping_cart_id_fkey FOREIGN KEY (shopping_cart_id) REFERENCES public.shopping_cart(id) ON DELETE CASCADE NOT VALID;


--
-- Name: shopping_cart shopping_cart_status_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_status_code_id_fkey FOREIGN KEY (status_code_id) REFERENCES public.shopping_cart_status(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

