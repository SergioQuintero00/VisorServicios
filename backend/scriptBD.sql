--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-04-04 12:38:30

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4853 (class 1262 OID 16405)
-- Name: TareaServicios; Type: DATABASE; Schema: -; Owner: sergio
--

CREATE DATABASE "TareaServicios" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';


ALTER DATABASE "TareaServicios" OWNER TO sergio;

\connect "TareaServicios"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16407)
-- Name: Entidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Entidad" (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    dni character varying(20) NOT NULL,
    telefono character varying(20) NOT NULL,
    "contraseña" character varying(200) NOT NULL,
    tipo character varying(50) NOT NULL
);


ALTER TABLE public."Entidad" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24625)
-- Name: EstadoServicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EstadoServicio" (
    id integer NOT NULL,
    "Estado" character varying NOT NULL
);


ALTER TABLE public."EstadoServicio" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24624)
-- Name: EstadoServicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."EstadoServicio_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."EstadoServicio_id_seq" OWNER TO postgres;

--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 224
-- Name: EstadoServicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."EstadoServicio_id_seq" OWNED BY public."EstadoServicio".id;


--
-- TOC entry 227 (class 1259 OID 24646)
-- Name: Log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Log" (
    id integer NOT NULL,
    "idTabla" integer NOT NULL,
    observacion character varying(500),
    "idEmpleado" integer NOT NULL,
    "fechaHora" timestamp(2) with time zone NOT NULL
);


ALTER TABLE public."Log" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24645)
-- Name: Log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Log_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Log_id_seq" OWNER TO postgres;

--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 226
-- Name: Log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Log_id_seq" OWNED BY public."Log".id;


--
-- TOC entry 221 (class 1259 OID 24599)
-- Name: Serv_Historial; Type: TABLE; Schema: public; Owner: sergio
--

CREATE TABLE public."Serv_Historial" (
    id integer NOT NULL,
    "idServicio" integer NOT NULL,
    detalle character varying(500) NOT NULL,
    fechayhora timestamp(2) with time zone NOT NULL
);


ALTER TABLE public."Serv_Historial" OWNER TO sergio;

--
-- TOC entry 220 (class 1259 OID 16416)
-- Name: Servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Servicio" (
    id integer NOT NULL,
    idcliente integer NOT NULL,
    servicio character varying(100) NOT NULL,
    detalles character varying(500),
    "memoTecnico" character varying(500),
    "fecha_Entrada" timestamp(2) with time zone NOT NULL,
    "fecha_Salida" timestamp(2) with time zone,
    "fecha_Creacion" timestamp(2) with time zone NOT NULL,
    "idEstado" integer NOT NULL,
    contactar boolean,
    prioridad integer,
    "idTipoServicio" integer NOT NULL
);


ALTER TABLE public."Servicio" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24618)
-- Name: TipoServicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TipoServicio" (
    id integer NOT NULL,
    "TipoServicio" character varying(50) NOT NULL
);


ALTER TABLE public."TipoServicio" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24617)
-- Name: TipoServicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TipoServicio_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TipoServicio_id_seq" OWNER TO postgres;

--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 222
-- Name: TipoServicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TipoServicio_id_seq" OWNED BY public."TipoServicio".id;


--
-- TOC entry 217 (class 1259 OID 16406)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 217
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public."Entidad".id;


--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: servicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicio_id_seq OWNER TO postgres;

--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 219
-- Name: servicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicio_id_seq OWNED BY public."Servicio".id;


--
-- TOC entry 4665 (class 2604 OID 16410)
-- Name: Entidad id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Entidad" ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 4668 (class 2604 OID 24628)
-- Name: EstadoServicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstadoServicio" ALTER COLUMN id SET DEFAULT nextval('public."EstadoServicio_id_seq"'::regclass);


--
-- TOC entry 4669 (class 2604 OID 24649)
-- Name: Log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Log" ALTER COLUMN id SET DEFAULT nextval('public."Log_id_seq"'::regclass);


--
-- TOC entry 4666 (class 2604 OID 16419)
-- Name: Servicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Servicio" ALTER COLUMN id SET DEFAULT nextval('public.servicio_id_seq'::regclass);


--
-- TOC entry 4667 (class 2604 OID 24621)
-- Name: TipoServicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TipoServicio" ALTER COLUMN id SET DEFAULT nextval('public."TipoServicio_id_seq"'::regclass);


--
-- TOC entry 4838 (class 0 OID 16407)
-- Dependencies: 218
-- Data for Name: Entidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Entidad" VALUES (1, 'sergio', '22222222R', '601058114', '$2y$10$wBIh.IlfPQjt/VNQn87Fh.xrq7e9x4zXNQgGfvsYvHlVOQGYZx1KO', 'Cliente');


--
-- TOC entry 4843 (class 0 OID 24618)
-- Dependencies: 223
-- Data for Name: TipoServicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TipoServicio" VALUES (1, 'Reparación');
INSERT INTO public."TipoServicio" VALUES (2, 'Instalación');
INSERT INTO public."TipoServicio" VALUES (3, 'Mantenimiento');

--
-- TOC entry 4845 (class 0 OID 24625)
-- Dependencies: 225
-- Data for Name: EstadoServicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."EstadoServicio" VALUES (1, 'Pendiente');
INSERT INTO public."EstadoServicio" VALUES (2, 'En proceso');
INSERT INTO public."EstadoServicio" VALUES (3, 'Completado');


--
-- TOC entry 4847 (class 0 OID 24646)
-- Dependencies: 227
-- Data for Name: Log; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 4840 (class 0 OID 16416)
-- Dependencies: 220
-- Data for Name: Servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Servicio" VALUES (1, 1, 'Reparación de notebook', 'Pantalla rota, no enciende.', NULL, '2025-03-25 11:00:00+01', NULL, '2025-03-24 10:30:00+01', 2, false, 4, 1);
INSERT INTO public."Servicio" VALUES (2, 1, 'Instalación de software', 'Instalación de Office y antivirus.', 'Todo correcto, actualizado.', '2025-03-20 15:00:00+01', '2025-03-20 17:30:00+01', '2025-03-19 13:15:00+01', 3, true, 2, 2);
INSERT INTO public."Servicio" VALUES (3, 1, 'Formateo y backup', 'Cliente solicita respaldo antes de formatear.', NULL, '2025-03-27 09:45:00+01', NULL, '2025-03-26 16:00:00+01', 1, false, 1, 3);



--
-- TOC entry 4841 (class 0 OID 24599)
-- Dependencies: 221
-- Data for Name: Serv_Historial; Type: TABLE DATA; Schema: public; Owner: sergio
--

INSERT INTO public."Serv_Historial" VALUES (1, 1, 'Recepción ordenador que no enciende', '2025-03-25 11:00:00+01');
INSERT INTO public."Serv_Historial" VALUES (2, 1, 'Arreglando pantalla rota, no enciende.', '2025-03-25 17:00:00+01');
INSERT INTO public."Serv_Historial" VALUES (3, 2, 'Recepción de equipo para instalación de software', '2025-03-20 15:00:00+01');
INSERT INTO public."Serv_Historial" VALUES (5, 2, 'Office y antivirus Instalado.', '2025-03-20 17:30:00+01');
INSERT INTO public."Serv_Historial" VALUES (6, 3, 'Cliente solicita respaldo antes de formatear.', '2025-03-27 09:45:00+01');
INSERT INTO public."Serv_Historial" VALUES (4, 2, 'En proceso de instalación', '2025-03-20 16:15:00+01');



--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 224
-- Name: EstadoServicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."EstadoServicio_id_seq"', 1, false);


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 226
-- Name: Log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Log_id_seq"', 1, false);


--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 222
-- Name: TipoServicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TipoServicio_id_seq"', 1, false);


--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 217
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 4, true);


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 219
-- Name: servicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicio_id_seq', 2, true);


--
-- TOC entry 4683 (class 2606 OID 24632)
-- Name: EstadoServicio EstadoServicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EstadoServicio"
    ADD CONSTRAINT "EstadoServicio_pkey" PRIMARY KEY (id);


--
-- TOC entry 4685 (class 2606 OID 24653)
-- Name: Log Log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Log"
    ADD CONSTRAINT "Log_pkey" PRIMARY KEY (id);


--
-- TOC entry 4679 (class 2606 OID 24605)
-- Name: Serv_Historial Serv_Historial_pkey; Type: CONSTRAINT; Schema: public; Owner: sergio
--

ALTER TABLE ONLY public."Serv_Historial"
    ADD CONSTRAINT "Serv_Historial_pkey" PRIMARY KEY (id);


--
-- TOC entry 4681 (class 2606 OID 24623)
-- Name: TipoServicio TipoServicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TipoServicio"
    ADD CONSTRAINT "TipoServicio_pkey" PRIMARY KEY (id);


--
-- TOC entry 4671 (class 2606 OID 16414)
-- Name: Entidad cliente_dni_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Entidad"
    ADD CONSTRAINT cliente_dni_key UNIQUE (dni);


--
-- TOC entry 4673 (class 2606 OID 16412)
-- Name: Entidad cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Entidad"
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 4677 (class 2606 OID 16421)
-- Name: Servicio servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Servicio"
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (id);


--
-- TOC entry 4674 (class 1259 OID 24644)
-- Name: fki_servicio_estadoServicio_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_servicio_estadoServicio_fkey" ON public."Servicio" USING btree ("idEstado");


--
-- TOC entry 4675 (class 1259 OID 24638)
-- Name: fki_servicio_tipoServicio_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_servicio_tipoServicio_fkey" ON public."Servicio" USING btree ("idTipoServicio");


--
-- TOC entry 4689 (class 2606 OID 24606)
-- Name: Serv_Historial FK_HIST_SERVICIO; Type: FK CONSTRAINT; Schema: public; Owner: sergio
--

ALTER TABLE ONLY public."Serv_Historial"
    ADD CONSTRAINT "FK_HIST_SERVICIO" FOREIGN KEY ("idServicio") REFERENCES public."Servicio"(id);


--
-- TOC entry 4690 (class 2606 OID 24659)
-- Name: Log log_entidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Log"
    ADD CONSTRAINT log_entidad_fkey FOREIGN KEY ("idEmpleado") REFERENCES public."Entidad"(id);


--
-- TOC entry 4691 (class 2606 OID 24654)
-- Name: Log log_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Log"
    ADD CONSTRAINT log_servicio_fkey FOREIGN KEY ("idTabla") REFERENCES public."Servicio"(id);


--
-- TOC entry 4686 (class 2606 OID 24639)
-- Name: Servicio servicio_estadoServicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Servicio"
    ADD CONSTRAINT "servicio_estadoServicio_fkey" FOREIGN KEY ("idEstado") REFERENCES public."EstadoServicio"(id);


--
-- TOC entry 4687 (class 2606 OID 16422)
-- Name: Servicio servicio_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Servicio"
    ADD CONSTRAINT servicio_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES public."Entidad"(id) ON DELETE CASCADE;


--
-- TOC entry 4688 (class 2606 OID 24633)
-- Name: Servicio servicio_tipoServicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Servicio"
    ADD CONSTRAINT "servicio_tipoServicio_fkey" FOREIGN KEY ("idTipoServicio") REFERENCES public."TipoServicio"(id);


-- Completed on 2025-04-04 12:38:31

--
-- PostgreSQL database dump complete
--

