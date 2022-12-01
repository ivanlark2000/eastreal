--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1+b3)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1+b3)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buildings (
    new_building_name text,
    address text NOT NULL,
    structure character varying(40),
    offical_builder text,
    year_of_construction smallint,
    floors_in_the_hourse smallint,
    passenger_bodice character varying(10),
    service_lift character varying(10),
    in_home text,
    pemolition_planned character varying(10),
    type_of_bilding character varying(40),
    yard character varying(40),
    participation_type character varying(40),
    deadline character varying(40),
    parking character varying(70)
);


ALTER TABLE public.buildings OWNER TO postgres;

--
-- Name: flats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flats (
    flat_id numeric NOT NULL,
    address text NOT NULL,
    price integer NOT NULL,
    district character varying(50) NOT NULL,
    number_of_rooms smallint NOT NULL,
    time_of_add date DEFAULT now(),
    square_of_kitchen numeric(4,1),
    living_space numeric(4,1),
    floor smallint NOT NULL,
    furniture text,
    technics text,
    balcony_or_loggia character varying(50),
    room_type character varying(50),
    ceiling_height numeric(3,1),
    bathroom character varying(50),
    widow character varying(50),
    repair character varying(50),
    seilling_method character varying(50),
    transaction_type character varying(50),
    decorating character varying(50),
    total_space numeric(4,1) NOT NULL,
    status character varying(15) DEFAULT 'active'::character varying
);


ALTER TABLE public.flats OWNER TO postgres;

--
-- Name: history_of_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history_of_price (
    id_flat numeric NOT NULL,
    price integer NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.history_of_price OWNER TO postgres;

--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    test01 text,
    test02 text
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buildings (new_building_name, address, structure, offical_builder, year_of_construction, floors_in_the_hourse, passenger_bodice, service_lift, in_home, pemolition_planned, type_of_bilding, yard, participation_type, deadline, parking) FROM stdin;
\.


--
-- Data for Name: flats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flats (flat_id, address, price, district, number_of_rooms, time_of_add, square_of_kitchen, living_space, floor, furniture, technics, balcony_or_loggia, room_type, ceiling_height, bathroom, widow, repair, seilling_method, transaction_type, decorating, total_space, status) FROM stdin;
\.


--
-- Data for Name: history_of_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.history_of_price (id_flat, price, date) FROM stdin;
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (test01, test02) FROM stdin;
Null	Null
\N	\N
\.


--
-- Name: flats flats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats
    ADD CONSTRAINT flats_pkey PRIMARY KEY (flat_id);


--
-- Name: buildings pk_address_buildpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT pk_address_buildpk PRIMARY KEY (address);


--
-- Name: flats fk_address_flats_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats
    ADD CONSTRAINT fk_address_flats_fk FOREIGN KEY (address) REFERENCES public.buildings(address);


--
-- Name: history_of_price flat_idfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_of_price
    ADD CONSTRAINT flat_idfk_1 FOREIGN KEY (id_flat) REFERENCES public.flats(flat_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

