--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: data_access_values; Type: TYPE; Schema: public; Owner: arnau
--

CREATE TYPE data_access_values AS ENUM (
    'Open Access',
    'Constrained Access',
    'Very Constrained Access',
    'No Access'
);


ALTER TYPE data_access_values OWNER TO arnau;

--
-- Name: geometries; Type: TYPE; Schema: public; Owner: arnau
--

CREATE TYPE geometries AS ENUM (
    'Conical scanning',
    'Cross-track scanning',
    'Earth disk scanning',
    'Limb-scanning',
    'Nadir-viewing',
    'Occultation',
    'Push-broom scanning',
    'Side-looking',
    'Steerable viewing',
    'Whisk-broom scanning',
    'TBD'
);


ALTER TYPE geometries OWNER TO arnau;

--
-- Name: sampling_values; Type: TYPE; Schema: public; Owner: arnau
--

CREATE TYPE sampling_values AS ENUM (
    'Imaging',
    'Sounding',
    'Other',
    'TBD'
);


ALTER TYPE sampling_values OWNER TO arnau;

--
-- Name: technologies; Type: TYPE; Schema: public; Owner: arnau
--

CREATE TYPE technologies AS ENUM (
    'Absorption-band MW radiometer/spectrometer',
    'Atmospheric lidar',
    'Broad-band radiometer',
    'Cloud and precipitation radar',
    'Communications system',
    'Data collection system',
    'Doppler lidar',
    'Electric field sensor',
    'GNSS radio-occultation receiver',
    'GNSS receiver',
    'Gradiometer/accelerometer',
    'High resolution optical imager',
    'High-resolution nadir-scanning IR spectrometer',
    'High-resolution nadir-scanning SW spectrometer',
    'Imaging radar (SAR)',
    'Laser retroreflector',
    'Lidar altimeter',
    'Lightning imager',
    'Limb-scanning IR spectrometer',
    'Limb-scanning MW spectrometer',
    'Limb-scanning SW spectrometer',
    'Magnetometer',
    'Medium-resolution IR spectrometer',
    'Medium-resolution spectro-radiometer',
    'Multi-channel/direction/polarisation radiometer',
    'Multi-purpose imaging MW radiometer',
    'Multi-purpose imaging Vis/IR radiometer',
    'Narrow-band channel IR radiometer',
    'Non-scanning MW radiometer',
    'Radar altimeter',
    'Radar scatterometer',
    'Radio-positioning system',
    'Satellite-to-satellite ranging system',
    'Solar irradiance monitor',
    'Space environment monitor',
    'Star tracker'
);


ALTER TYPE technologies OWNER TO arnau;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agencies; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE agencies (
    id integer NOT NULL,
    name character varying,
    country character varying,
    website character varying
);


ALTER TABLE agencies OWNER TO arnau;

--
-- Name: agencies_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE agencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE agencies_id_seq OWNER TO arnau;

--
-- Name: agencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE agencies_id_seq OWNED BY agencies.id;


--
-- Name: broad_measurement_categories; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE broad_measurement_categories (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE broad_measurement_categories OWNER TO arnau;

--
-- Name: broad_measurement_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE broad_measurement_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE broad_measurement_categories_id_seq OWNER TO arnau;

--
-- Name: broad_measurement_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE broad_measurement_categories_id_seq OWNED BY broad_measurement_categories.id;


--
-- Name: designers; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE designers (
    agency_id integer,
    instrument_id integer
);


ALTER TABLE designers OWNER TO arnau;

--
-- Name: geometry_of_instrument; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE geometry_of_instrument (
    instrument_id integer,
    instrument_geometry_id integer
);


ALTER TABLE geometry_of_instrument OWNER TO arnau;

--
-- Name: geometry_types; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE geometry_types (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE geometry_types OWNER TO arnau;

--
-- Name: geometry_types_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE geometry_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geometry_types_id_seq OWNER TO arnau;

--
-- Name: geometry_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE geometry_types_id_seq OWNED BY geometry_types.id;


--
-- Name: instrument_types; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE instrument_types (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE instrument_types OWNER TO arnau;

--
-- Name: instrument_types_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE instrument_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE instrument_types_id_seq OWNER TO arnau;

--
-- Name: instrument_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE instrument_types_id_seq OWNED BY instrument_types.id;


--
-- Name: instrument_wavebands; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE instrument_wavebands (
    instrument_id integer,
    waveband_id integer
);


ALTER TABLE instrument_wavebands OWNER TO arnau;

--
-- Name: instruments; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE instruments (
    id integer NOT NULL,
    name character varying,
    full_name character varying,
    status character varying,
    maturity character varying,
    technology technologies,
    sampling sampling_values,
    data_access data_access_values,
    data_format character varying,
    measurements_and_applications character varying,
    resolution_summary character varying,
    best_resolution character varying,
    swath_summary character varying,
    max_swath character varying,
    accuracy_summary character varying,
    waveband_summary character varying
);


ALTER TABLE instruments OWNER TO arnau;

--
-- Name: instruments_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE instruments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE instruments_id_seq OWNER TO arnau;

--
-- Name: instruments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE instruments_id_seq OWNED BY instruments.id;


--
-- Name: instruments_in_mission; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE instruments_in_mission (
    mission_id integer,
    instrument_id integer
);


ALTER TABLE instruments_in_mission OWNER TO arnau;

--
-- Name: measurement_categories; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE measurement_categories (
    id integer NOT NULL,
    name character varying,
    description character varying,
    broad_measurement_category_id integer
);


ALTER TABLE measurement_categories OWNER TO arnau;

--
-- Name: measurement_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE measurement_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE measurement_categories_id_seq OWNER TO arnau;

--
-- Name: measurement_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE measurement_categories_id_seq OWNED BY measurement_categories.id;


--
-- Name: measurements; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE measurements (
    id integer NOT NULL,
    name character varying,
    description character varying,
    measurement_category_id integer
);


ALTER TABLE measurements OWNER TO arnau;

--
-- Name: measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE measurements_id_seq OWNER TO arnau;

--
-- Name: measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE measurements_id_seq OWNED BY measurements.id;


--
-- Name: measurements_of_instrument; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE measurements_of_instrument (
    instrument_id integer,
    measurement_id integer
);


ALTER TABLE measurements_of_instrument OWNER TO arnau;

--
-- Name: missions; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE missions (
    id integer NOT NULL,
    name character varying,
    full_name character varying,
    status character varying,
    launch_date timestamp without time zone,
    eol_date timestamp without time zone,
    applications character varying,
    orbit_type character varying,
    orbit_period character varying,
    orbit_sense character varying,
    orbit_inclination character varying,
    orbit_altitude character varying,
    orbit_longitude character varying,
    "orbit_LST" character varying,
    repeat_cycle character varying
);


ALTER TABLE missions OWNER TO arnau;

--
-- Name: missions_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE missions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE missions_id_seq OWNER TO arnau;

--
-- Name: missions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE missions_id_seq OWNED BY missions.id;


--
-- Name: operators; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE operators (
    agency_id integer,
    mission_id integer
);


ALTER TABLE operators OWNER TO arnau;

--
-- Name: type_of_instrument; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE type_of_instrument (
    instrument_id integer,
    instrument_type_id integer
);


ALTER TABLE type_of_instrument OWNER TO arnau;

--
-- Name: wavebands; Type: TABLE; Schema: public; Owner: arnau
--

CREATE TABLE wavebands (
    id integer NOT NULL,
    name character varying,
    wavelengths character varying
);


ALTER TABLE wavebands OWNER TO arnau;

--
-- Name: wavebands_id_seq; Type: SEQUENCE; Schema: public; Owner: arnau
--

CREATE SEQUENCE wavebands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wavebands_id_seq OWNER TO arnau;

--
-- Name: wavebands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arnau
--

ALTER SEQUENCE wavebands_id_seq OWNED BY wavebands.id;


--
-- Name: agencies id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY agencies ALTER COLUMN id SET DEFAULT nextval('agencies_id_seq'::regclass);


--
-- Name: broad_measurement_categories id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY broad_measurement_categories ALTER COLUMN id SET DEFAULT nextval('broad_measurement_categories_id_seq'::regclass);


--
-- Name: geometry_types id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY geometry_types ALTER COLUMN id SET DEFAULT nextval('geometry_types_id_seq'::regclass);


--
-- Name: instrument_types id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instrument_types ALTER COLUMN id SET DEFAULT nextval('instrument_types_id_seq'::regclass);


--
-- Name: instruments id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instruments ALTER COLUMN id SET DEFAULT nextval('instruments_id_seq'::regclass);


--
-- Name: measurement_categories id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurement_categories ALTER COLUMN id SET DEFAULT nextval('measurement_categories_id_seq'::regclass);


--
-- Name: measurements id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurements ALTER COLUMN id SET DEFAULT nextval('measurements_id_seq'::regclass);


--
-- Name: missions id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY missions ALTER COLUMN id SET DEFAULT nextval('missions_id_seq'::regclass);


--
-- Name: wavebands id; Type: DEFAULT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY wavebands ALTER COLUMN id SET DEFAULT nextval('wavebands_id_seq'::regclass);


--
-- Data for Name: agencies; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY agencies (id, name, country, website) FROM stdin;
181	UCL-Geomatics	UK	http://www.ucl.ac.uk/geomatics
184	CMUG	Europe	http://www.esa-cmug-cci.org/
188	VAST	Vietnam	http://www.vast.ac.vn/en/
186	CRP-GL	Luxembourg	http://www.crpgl.lu/
185	UKMO	UK	http://www.metoffice.gov.uk/
190	DFO	Canada	
189	DND	Canada	
191	AAFC	Canada	
197	INTA	Spain	
195	21AT	China	
193	PSC	Canada	
194	KAI	Korea	
192	EnvCan	Canada	
196	U.S. Naval Research Laboratory	USA	
198	HISDESAT	Spain	
199	CSIC	Spain	
201	HRC	Germany	https://www.helmholtz.de/en/
200	AEB	Brazil	www.aeb.gov.br
53	USGS	U.S.A.	http://www.usgs.gov
61	ONIITT		
60	IRE		
64	CKI PAS (Poland)	Poland	
62	SKTB FTINT		
63	Bulgarian Academy of Science	Bulgaria	
109	IOC		
110	UNEP		
111	GCOS		
108	WMO		
112	GOOS		
115	ICSU		
113	IGBP		
116	UNOOSA		
114	COM	Europe	http://ec.europa.eu
118	FAO		
120	IGOS		
117	WCRP		
119	ROSHYDROMET	Russia	http://www.meteorf.ru
121	GTOS		
122	IOCCG		
125	NIES (Japan)	Japan	
127	DNSC	Denmark	
126	NSO	Netherlands	http://www.spaceoffice.nl/
123	KARI	Korea	http://www.kari.re.kr
124	CRCSS		
129	SANSA	South Africa	http://www.sansa.org.za/
128	ISR (Italy)	Italy	
130	CRESDA	China	http://www.cresda.com/n16/n92006/index.html
131	Uni of Stellenbosh	South Africa	
132	UCAR		
134	NASRDA	Nigeria	http://www.nasrda.net
133	NSPO		
136	CDTI	Spain	http://www.cdti.es/
139	NSOAS	China	
137	ISA	Israel	
138	TEKES	Finland	
135	TUBITAK	Turkey	http://www.tubitak.gov.tr
141	NICT	Japan	http://www.nict.go.jp/en/
142	JCAB	Japan	
140	NSMC-CMA	China	http://nsmc.cma.gov.cn/newsite/NSMC_EN/Home/Index.html
144	NASDA	Japan	http://www.jaxa.jp/index_e.html
143	MoD (Italy)	Italy	
148	TAS-i	Italy	http://www.thalesgroup.com/
146	ASTRIUM	Europe	http://www.astrium.eads.net/
145	MITI (Japan)	Japan	
147	E-LOP		
149	FMI	Finland	
150	BNISS		
154	Orbital	USA	http://www.orbital.com/
155	DMI	Europe	http://www.deimos-imaging.com
152	CNSA	China	
151	NIVR	Netherlands	http://www.nivr.nl/
156	GeoEye	Global	http://www.geoeye.com
153	KMA	Korea	http://web.kma.go.kr/eng/index.jsp
157	MDA	Canada	http://www.mdacorporation.com
159	NIER	Korea	http://eng.nier.go.kr/
158	KORDI	Korea	http://www.kordi.re.kr/english
162	Digital Globe	USA	http://www.digitalglobe.com/
161	ITT	USA	www.itt.com
163	RAL	UK	http://www.stfc.ac.uk/About%20STFC/51.aspx
7	DARA	Germany	
1	ASI	Italy	http://www.asi.it/en
2	UKSA	United Kingdom	http://www.bnsc.gov.uk/
3	CAST	China	http://www.cast.cn/CastEN/index.asp
5	CSA	Canada	http://www.asc-csa.gc.ca
4	CNES	France	http://www.cnes.fr
8	ESA	Europe	http://www.esa.int
6	CSIRO	Australia	http://www.csiro.au
10	INPE	Brazil	http://www.inpe.br
9	EUMETSAT	Europe	http://www.eumetsat.int
15	NSAU	Ukraine	http://www.nkau.gov.ua
11	ISRO	India	http://www.isro.org
17	SNSB	Sweden	http://www.rymdstyrelsen.se
13	JAXA	Japan	http://www.jaxa.jp/index_e.html
14	NOAA	U.S.A.	http://www.noaa.gov
18	CCRS	Canada	
19	CRI		
12	NASA	U.S.A.	http://www.nasa.gov
16	ROSKOSMOS	Russia	http://www.roscosmos.ru
23	STA		
22	OSTC	Belgium	
20	NRSCC	China	http://www.nrscc.gov.cn
21	NSC	Norway	http://www.spacecentre.no
24	CONAE	Argentina	http://www.conae.gov.ar
25	GISTDA	Thailand	http://www.gistda.or.th
28	ASA		
29	UK (RAL)		
30	DLR	Germany	http://www.dlr.de
31	JMA	Japan	http://www.jma.go.jp
32	METI	Japan	http://www.meti.go.jp
33	USAF	U.S.A.	
26	SPPS		
34	UK Meteorological Office	U.K.	
36	University of Chicago	U.S.A.	
37	NRCAN	Canada	http://www.nrcan.gc.ca/
38	Lockheed	U.S.A.	
27	EEC		
39	University of Bergen		
40	US Naval Research Lab	U.S.A.	
41	MOE (Japan)	Japan	
35	DoD (USA)	U.S.A.	
42	France (CRPE)	France	
43	Others (TBD)		
47	GSFC	U.S.A.	
46	JPL	U.S.A.	
49	Russia	Russia	
48	Data purchase agreement		
51	SSC		
56	NPO PLANETA		
57	KB YUZNOYE		
52	TIFR		
58	ROSKARTOGRAPHIYA		
59	NIIRI		
165	BELSPO	Belgium	http://www.belspo.be/
160	NDRCC	China	
164	GFZ	Germany	http://www.gfz-potsdam.de
168	DWD	Germany	http://www.dwd.de/
167	BATC		
171	CM SAF	Europe	http://www.cmsaf.eu/bvbw/appmanager/bvbw/cmsafInternet
170	MetNo	Norway	http://met.no/English/
169	Swansea Univ	UK	www.swansea.ac.uk
166	SAO	USA	
172	GLIMS	USA	http://www.glims.org/
173	NSIDC	USA	http://nsidc.org/
176	Univ of Hamburg	Germany	http://www.uni-hamburg.de/index_e.html
174	Univ of Zurich	Switzerland	http://www.uzh.ch/index_en.html
177	Univ of Cambridge	UK	http://www.cam.ac.uk/
179	LSCE	France	http://www.lsce.ipsl.fr/en/
178	Technische Universitaet Wien	Austria	http://www.tuwien.ac.at/
180	MPI	Germany	http://www.mpimet.mpg.de/en/home.html
182	UCL	Belgium	https://www.uclouvain.be/index.html
183	JRC	Europe	http://ec.europa.eu/dgs/jrc/
\.


--
-- Name: agencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('agencies_id_seq', 1, false);


--
-- Data for Name: broad_measurement_categories; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY broad_measurement_categories (id, name, description) FROM stdin;
1000	Other	Other
5	Gravity and Magnetic Fields	The main focus of gravity and magnetic field measurements is the calculation of the Earth’s geoid, also known as the surface of equal gravitational potential at mean sea level.
4	Snow  and  Ice	Measurements of ice and snow include a number of parameters covering topography, and cover, edge and thickness/depth.
3	Ocean	Measurements of ocean include a number of parameters covering colour, salinity, temperature, waves, topography, current and winds.
2	Land	Measurements of land include a number of parameters covering albedo and reflectance, topography, temperature, soils and vegetation.
1	Atmosphere	Measurements of atmosphere include a number of parameters covering temperature, humidity, component gas concentration, clouds, and radiation.
\.


--
-- Name: broad_measurement_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('broad_measurement_categories_id_seq', 1, false);


--
-- Data for Name: designers; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY designers (agency_id, instrument_id) FROM stdin;
14	184
12	645
30	697
24	730
16	1562
119	1562
139	988
3	988
3	1733
10	1733
130	1730
10	817
3	817
4	391
12	391
140	1625
11	459
10	1732
3	1732
10	1698
8	768
14	138
13	81
30	699
12	642
3	406
10	406
188	1680
4	966
188	1681
130	1776
20	14
3	14
13	77
1	718
13	78
31	78
1	1676
12	1539
14	412
12	412
9	257
12	402
11	67
20	684
3	684
140	684
24	1637
4	404
17	404
114	404
8	1504
9	1504
114	1504
8	1664
21	1742
14	137
8	942
114	942
16	855
8	860
11	1602
8	941
114	941
9	949
8	949
136	1513
30	1697
16	247
12	1546
12	1536
14	679
12	679
12	1770
14	1770
12	764
12	1715
14	1724
8	1724
12	1724
16	246
119	485
16	485
14	275
20	906
3	906
140	906
12	765
12	415
13	415
12	763
2	721
20	685
3	685
12	414
14	1743
53	327
12	327
53	1524
12	1524
1	719
53	1746
12	1746
24	1712
12	644
119	1573
20	1506
3	1506
14	1725
133	1725
11	923
13	1655
41	1655
24	959
13	905
41	905
12	349
13	1654
41	1654
13	904
41	904
4	1644
14	141
14	875
8	771
14	953
15	569
15	568
11	929
14	329
12	156
14	741
129	908
14	742
8	861
14	636
14	453
8	1556
14	452
14	740
14	634
14	454
14	635
14	451
14	633
14	738
16	254
14	632
8	903
114	903
12	1672
14	739
12	1671
13	1671
12	1558
8	321
8	369
14	330
12	868
4	761
11	789
12	1529
13	663
13	1587
12	419
12	1763
14	880
17	743
4	760
20	975
3	975
140	975
8	902
114	902
2	769
16	253
20	1632
3	1632
140	1632
2	944
8	688
119	781
16	1755
14	874
16	252
16	1694
16	1693
12	626
13	901
3	1624
140	1624
119	218
140	1780
14	683
14	65
9	302
8	302
140	1781
21	1518
8	367
30	367
14	637
14	952
20	974
3	974
140	974
12	427
5	1704
13	455
119	1512
16	1512
13	869
11	752
4	1645
11	1703
8	345
11	1749
4	864
14	318
14	177
11	1665
12	657
9	1631
8	1631
4	382
3	826
11	1521
24	731
16	251
14	737
16	249
16	250
11	922
1	704
1	706
24	963
11	790
10	971
5	456
123	1695
119	800
5	703
5	946
37	946
189	946
190	946
191	946
192	946
12	655
14	189
12	348
16	348
12	357
16	357
12	659
12	1598
12	656
4	675
12	821
11	927
1	715
4	1509
1	1509
16	978
5	1706
14	136
4	766
1	958
24	958
9	1628
8	1628
119	194
15	194
1	899
11	899
16	193
13	89
16	210
16	227
119	783
14	1744
1	716
16	837
16	839
12	1716
1	717
12	1738
16	840
10	968
11	995
11	1640
135	912
135	913
8	379
16	245
16	198
8	378
16	834
119	834
16	197
13	1516
16	836
13	443
4	1723
8	1723
4	762
16	286
140	1761
4	1633
13	337
12	337
4	829
4	751
4	898
11	930
12	1661
4	18
4	793
13	793
4	390
13	390
4	182
12	646
16	283
1	712
14	1649
12	1649
1	707
12	100
14	1650
12	1650
5	1517
8	1722
136	1514
5	1601
16	802
119	802
24	962
5	1600
6	613
136	914
8	914
3	700
1	1592
11	446
1	832
130	1659
11	1610
25	857
130	1675
11	917
3	867
10	867
11	436
11	1647
11	796
130	1728
11	1586
4	989
20	1747
16	845
13	364
32	364
16	244
20	977
3	977
130	1729
13	1589
12	1718
14	1718
14	681
3	1623
140	1623
123	734
13	437
20	686
3	686
13	336
5	662
17	662
12	1769
53	1769
14	450
16	1754
16	791
126	630
12	630
8	896
114	896
16	1560
119	1560
53	897
12	897
13	359
16	838
16	850
12	425
12	1527
11	935
12	1597
11	464
24	1638
134	1595
14	561
134	916
24	812
5	812
13	1710
5	1710
12	647
14	647
134	915
9	1663
8	1663
12	1531
20	672
3	672
140	672
11	925
20	895
3	895
140	895
11	1611
3	1622
140	1622
16	222
9	1629
3	1621
140	1621
8	185
12	1668
8	262
9	1630
8	1630
24	803
20	667
3	667
3	13
20	13
16	274
20	671
3	671
130	1775
20	669
3	669
140	669
9	394
8	394
20	180
3	180
140	180
130	1774
130	1726
12	1540
10	1731
3	1731
10	818
3	818
130	1658
130	1727
130	1674
12	1532
31	563
16	792
12	1525
119	674
16	673
119	673
31	1500
16	196
15	570
16	779
119	779
16	191
15	191
16	195
119	777
119	852
16	852
16	192
15	192
16	1692
119	1692
16	229
16	784
119	784
16	1691
16	980
119	980
119	228
15	567
16	243
14	328
119	848
16	835
119	835
13	80
15	794
11	465
8	940
114	940
53	326
12	326
8	938
9	296
30	831
119	780
20	976
3	976
123	735
20	1748
119	776
16	1690
14	872
119	217
16	216
11	462
16	209
16	208
25	858
16	1689
5	119
12	119
21	1700
12	353
12	395
24	722
12	126
24	807
10	807
46	725
127	725
24	725
16	233
123	1741
8	689
12	396
16	223
15	795
16	232
119	215
5	1709
8	338
11	996
12	1548
9	965
30	965
9	304
20	670
3	670
123	894
153	894
13	79
20	1620
3	1620
140	1620
20	1759
3	1759
140	1759
20	893
3	893
140	893
8	320
9	295
12	428
20	892
3	892
140	892
14	149
5	702
11	918
11	919
11	920
12	1768
14	878
8	368
12	653
14	1501
1	1594
11	865
4	865
8	1557
24	1713
2	770
12	1667
14	1721
8	1721
12	1721
1	708
1	1510
12	106
1	106
188	1678
20	891
3	891
140	891
11	1639
188	1679
11	461
12	110
11	1773
11	438
11	444
11	439
11	934
12	1533
12	654
12	628
13	335
32	335
12	1526
11	1526
9	890
8	890
1	772
30	1777
12	986
12	1554
10	819
4	29
12	1764
8	767
12	1542
1	711
119	221
16	849
12	1544
119	214
24	804
1	804
16	801
119	801
119	190
16	234
16	230
12	1545
13	559
119	220
12	107
16	231
12	1541
4	1541
31	695
16	241
12	661
1	727
24	727
16	213
14	1745
4	749
20	665
3	665
140	665
3	410
10	410
5	1708
3	866
10	866
9	950
8	950
119	889
130	1673
20	666
3	666
140	666
12	651
119	785
24	732
12	1547
12	1528
3	825
30	1590
4	1590
11	298
12	1538
145	332
13	332
4	747
20	668
3	668
14	331
1	728
24	728
31	466
11	788
6	593
16	778
119	778
41	333
13	333
16	1688
16	240
16	239
16	854
41	334
13	334
16	238
4	696
4	750
1	714
4	746
4	729
24	729
20	888
1	833
9	1662
8	1662
11	1607
4	748
9	1626
4	1626
11	1608
11	926
12	627
11	1612
9	305
4	305
11	924
11	994
12	798
1	713
11	1613
24	724
1	705
3	824
30	964
24	805
30	698
10	442
12	442
24	1636
11	1605
30	1696
4	26
17	26
24	1711
24	723
11	1604
4	19
4	759
11	1606
3	1520
10	1520
8	1757
11	1609
12	97
11	1603
4	183
16	1561
119	1561
14	309
9	564
14	564
31	1653
4	887
32	1634
12	351
2	351
6	650
14	313
12	1737
14	871
12	1551
16	1753
12	350
31	1652
24	961
123	1740
12	1660
16	237
16	1686
9	306
8	306
16	1687
12	1553
12	987
8	987
30	987
16	1752
14	682
8	943
24	105
12	105
12	983
12	856
12	1552
8	786
8	366
1	710
8	370
12	726
24	726
12	881
133	881
14	562
12	773
9	307
8	307
13	299
31	299
3	1619
140	1619
13	816
14	877
123	886
146	886
8	1720
140	1779
12	421
12	631
13	813
16	1685
13	362
16	841
16	853
119	853
9	303
8	303
123	1583
159	1583
12	1543
16	1684
16	847
119	847
16	844
119	844
12	1717
14	879
3	1618
140	1618
5	1707
8	1778
9	885
8	885
14	951
5	1705
119	782
14	1648
12	1648
14	876
8	293
20	884
3	884
140	884
14	1582
12	1582
20	1617
3	1617
140	1617
53	322
12	322
12	1537
14	873
12	143
123	733
12	1615
14	1615
8	691
14	148
8	294
1	709
11	170
16	843
8	862
5	862
12	1714
13	774
16	842
4	1508
16	285
4	389
30	1734
16	236
4	1507
12	1669
14	1669
24	957
119	775
4	181
24	955
10	1505
24	1635
14	135
14	954
10	822
3	822
10	758
119	1511
119	799
10	970
13	188
3	163
10	163
3	828
1	1519
14	325
123	1523
12	1767
12	649
13	372
135	909
12	1534
8	745
14	680
6	623
12	1535
123	1739
3	827
21	1701
12	1736
13	1666
12	660
12	1530
13	1782
13	814
8	720
2	720
14	1646
16	207
5	1656
11	787
12	432
30	432
30	431
12	397
4	430
3	823
24	1762
3	409
10	409
4	956
24	956
4	806
24	806
130	1657
12	1735
8	939
16	212
16	219
11	171
16	1751
12	820
11	921
12	652
119	226
16	287
135	910
135	911
16	1750
16	1756
16	284
119	900
16	900
16	225
16	248
8	937
13	363
16	282
11	460
10	405
14	324
13	358
2	408
6	408
4	383
9	403
14	403
2	407
6	407
14	310
14	276
11	933
8	374
32	416
12	416
3	1616
140	1616
9	308
8	308
12	413
14	413
4	859
12	998
8	261
16	1599
16	846
119	846
4	154
12	154
14	694
8	344
8	260
119	851
16	851
13	664
12	664
12	736
12	985
24	985
12	1555
12	984
24	984
11	1772
14	312
2	312
14	323
2	323
12	1719
4	1719
8	1719
9	1719
14	1719
8	434
12	882
13	883
13	815
8	435
13	360
8	433
14	678
16	235
12	422
139	973
3	973
1	1593
4	931
11	928
11	932
21	1699
123	1614
12	347
123	1522
5	947
31	1651
119	1568
8	375
123	1574
119	1565
119	1564
119	1567
123	1575
153	1575
119	1570
119	1566
119	1569
119	1572
12	418
8	863
14	870
5	701
13	301
12	693
119	1571
2	411
9	1627
8	1627
16	211
119	211
\.


--
-- Data for Name: geometry_of_instrument; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY geometry_of_instrument (instrument_id, instrument_geometry_id) FROM stdin;
988	55
1733	49
1730	49
817	49
391	52
459	53
1732	49
1698	49
81	46
642	49
406	46
966	55
1681	51
14	47
77	47
78	47
1676	51
1539	46
412	46
402	46
67	55
684	46
1637	49
404	46
1504	51
137	47
942	49
1602	55
941	51
949	47
1513	49
1546	49
1536	49
679	46
1770	46
1715	46
1724	50
485	49
275	46
906	46
721	51
685	46
327	46
1524	51
1746	51
1712	49
1573	46
1506	55
923	51
1655	49
959	49
905	49
349	49
1654	51
904	51
953	55
929	55
329	46
908	53
636	45
453	45
1556	55
452	45
634	45
454	45
635	45
451	45
633	45
632	45
903	49
1672	51
1671	53
1558	53
330	47
789	55
1529	49
663	50
1587	48
1763	46
902	46
769	51
944	51
688	49
1755	55
991	55
1694	55
1693	55
901	46
901	51
683	46
302	47
1518	55
367	53
952	55
427	45
1512	55
752	45
1645	45
1703	45
972	45
1749	45
864	46
318	48
177	48
1665	52
1631	52
382	46
826	52
1521	55
731	52
922	52
704	52
706	52
963	55
790	52
971	52
456	52
800	52
703	52
946	52
348	48
357	48
659	48
1598	48
675	49
821	52
927	50
1509	55
978	55
958	50
1628	50
194	52
899	50
837	49
1716	46
968	45
995	55
1640	48
967	49
912	51
913	51
378	49
834	46
1516	52
836	49
443	51
1633	49
337	46
829	49
930	55
18	49
793	49
390	49
182	49
1517	47
1722	52
1514	52
1601	47
802	46
962	55
1600	47
613	46
914	51
1592	51
446	53
832	51
1659	51
1610	55
857	51
917	53
867	53
436	53
1647	53
796	53
1728	53
1586	53
989	55
1747	46
1747	51
845	55
364	52
977	51
1729	53
1589	52
681	46
734	54
437	46
686	46
336	46
662	48
1769	51
450	45
1754	51
630	49
896	49
897	51
359	46
1527	50
935	55
1597	46
464	49
1638	49
1595	51
916	53
812	51
647	49
915	51
1663	46
1531	55
672	45
925	46
1611	55
185	49
262	49
1630	45
803	51
667	46
13	46
671	46
669	46
394	47
180	46
1774	49
1726	49
1540	54
1731	49
818	49
1658	49
1727	49
1532	49
1525	49
673	55
779	46
852	46
1692	46
784	47
1691	47
980	46
567	46
328	46
835	46
80	45
794	49
465	45
940	51
326	46
938	49
831	51
976	51
735	51
1748	46
1748	51
1690	46
462	49
858	51
1689	46
119	49
353	48
395	46
722	51
126	48
396	51
795	49
338	52
996	55
1548	48
965	46
304	46
670	46
894	47
79	46
893	46
320	46
702	50
918	55
919	55
920	55
1768	51
1501	55
1594	49
865	46
1557	55
1713	46
1713	51
1510	55
1639	48
461	46
969	46
1773	53
438	49
444	46
439	46
934	46
1533	49
335	52
1526	52
890	47
772	55
986	45
1554	45
819	53
1542	49
1544	55
801	46
1545	55
1541	49
695	47
665	47
410	46
866	46
950	47
666	46
1547	49
1528	49
1590	49
1538	49
332	49
668	46
331	47
466	47
788	49
593	46
778	46
333	50
1688	55
334	50
1662	45
1607	55
1626	46
1608	55
926	46
1612	55
305	46
924	46
994	55
1613	55
724	49
705	51
964	51
805	52
442	46
1636	49
1605	55
26	46
1711	49
723	51
1604	55
19	46
759	46
1606	55
1520	49
1609	55
1603	55
183	46
309	46
564	46
887	46
1634	51
351	48
313	46
1737	46
1551	49
1753	55
350	49
961	55
1660	55
1686	55
306	50
1687	55
1553	50
987	55
1752	55
682	46
943	55
105	50
1552	50
366	50
726	50
881	50
773	45
307	46
816	46
886	49
421	49
813	46
1685	55
362	45
853	55
303	47
1583	49
1543	49
1684	51
847	55
844	51
885	47
951	55
1582	49
322	46
1537	49
733	51
1615	49
170	55
774	46
1669	51
1505	49
1635	55
954	55
1511	46
970	49
828	51
1519	52
990	55
325	46
1523	49
649	49
372	49
909	51
1534	49
680	46
1535	49
827	46
1736	49
1666	49
1530	49
1782	49
720	51
1646	49
787	55
432	50
397	49
1762	53
409	53
806	55
1657	51
1735	49
939	52
1751	52
820	49
921	55
910	51
911	51
1750	52
1756	55
900	52
937	49
363	46
460	49
405	49
324	46
358	46
408	45
383	49
403	46
407	45
310	46
276	46
933	55
374	49
308	52
413	46
998	49
261	46
846	55
154	55
260	46
851	50
664	45
985	51
1555	46
984	51
1772	53
312	46
323	46
1719	49
434	52
883	45
815	45
435	52
360	45
433	52
678	46
422	51
973	49
1593	49
931	49
928	55
932	55
1614	51
347	46
1522	51
947	49
1651	47
1568	55
375	52
1574	49
1565	46
1564	46
1567	45
1575	47
1570	50
1566	46
1569	52
701	50
411	45
1627	51
\.


--
-- Data for Name: geometry_types; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY geometry_types (id, name) FROM stdin;
45	Conical scanning
46	Cross-track scanning
47	Earth disk scanning
48	Limb-scanning
49	Nadir-viewing
50	Occultation
51	Push-broom scanning
52	Side-looking
53	Steerable viewing
54	Whisk-broom scanning
55	TBD
\.


--
-- Name: geometry_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('geometry_types_id_seq', 55, true);


--
-- Data for Name: instrument_types; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY instrument_types (id, name) FROM stdin;
97	Atmospheric chemistry
98	Atmospheric temperature and humidity sounders
99	Cloud profile and rain radars
100	Communications
101	Data collection
102	Earth radiation budget radiometers
103	Gravity instruments
104	High resolution optical imagers
105	Hyperspectral imagers
106	Imaging microwave radars
107	Imaging multi-spectral radiometers (passive microwave)
108	Imaging multi-spectral radiometers (vis/IR)
109	In situ
110	Lidars
111	Lightning sensors
112	Magnetic field
113	Multiple direction/polarisation radiometers
114	Ocean colour instruments
115	Other
116	Precision orbit
117	Radar altimeters
118	Scatterometers
119	Space environment
120	TBD
\.


--
-- Name: instrument_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('instrument_types_id_seq', 120, true);


--
-- Data for Name: instrument_wavebands; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY instrument_wavebands (instrument_id, waveband_id) FROM stdin;
184	73
645	90
645	73
697	80
697	85
730	91
988	80
988	85
1733	74
1733	75
1730	74
1730	75
817	74
817	75
391	74
391	75
1625	84
1625	86
459	74
459	75
459	76
1732	74
1732	75
1698	74
1698	75
768	75
138	80
81	74
81	78
699	74
699	75
642	74
406	74
406	75
1680	75
966	74
966	75
1681	74
1776	75
14	74
14	75
14	78
77	74
77	78
718	74
718	75
78	74
78	78
1676	74
1676	75
1676	76
1539	74
1539	75
1539	76
412	74
412	75
412	76
412	77
412	78
257	74
402	74
402	76
402	77
402	78
67	74
67	75
67	78
684	74
684	76
684	77
684	78
1637	74
1637	75
1637	76
1637	78
404	74
404	75
404	76
1504	73
1504	74
1504	75
1504	76
1664	74
1664	75
1664	76
942	73
942	74
942	75
942	76
860	91
1602	90
1602	80
941	73
941	74
941	75
949	73
949	74
949	75
1513	73
1513	74
1513	75
1697	85
247	74
1546	73
1546	74
1536	73
1536	74
1536	75
679	73
679	74
679	75
679	76
1770	90
764	90
1724	91
246	80
485	74
275	75
906	73
765	80
415	73
763	80
721	74
685	73
414	80
327	74
327	75
327	76
327	78
1524	78
719	78
1746	78
1712	78
644	91
1573	74
1573	75
1573	76
923	74
1655	75
1655	76
1655	77
1655	78
959	91
905	75
905	76
905	77
905	78
349	77
349	78
1654	73
1654	74
1654	75
1654	76
904	73
904	74
904	75
904	76
1644	84
141	73
771	90
569	90
568	74
929	78
329	76
156	73
741	90
908	74
908	75
742	90
861	91
636	90
453	80
452	80
740	90
634	90
454	80
635	90
451	80
633	90
738	90
254	74
632	90
903	80
903	84
903	86
1672	73
1672	74
739	90
1671	76
1558	76
321	74
321	75
321	76
321	77
369	80
330	74
330	75
330	76
330	77
330	78
868	75
868	76
761	90
761	91
789	74
789	77
789	78
1529	74
1529	75
1529	76
663	75
663	77
663	78
1587	80
419	73
743	79
743	80
760	73
760	74
975	73
975	74
975	79
902	74
902	75
902	76
902	78
769	74
769	75
253	80
1632	73
1632	74
1632	79
944	74
944	75
688	80
688	84
781	90
1755	74
1755	75
1755	76
252	74
1694	74
1694	75
1693	74
1693	75
626	73
626	74
626	75
626	76
901	73
901	74
901	75
901	76
901	78
1502	75
218	73
218	74
683	90
65	75
302	74
302	75
302	76
302	77
302	78
367	73
367	74
367	75
367	76
637	90
974	73
427	77
427	80
455	74
1512	80
1512	84
752	80
1645	84
1703	80
972	80
345	80
1749	80
864	73
864	74
864	78
864	79
318	73
177	73
1665	80
1665	87
657	90
1631	86
382	73
382	74
382	78
382	79
826	80
826	87
1521	80
1521	85
731	88
251	80
737	90
249	80
250	80
922	80
922	88
704	80
704	85
706	80
706	85
963	80
790	80
790	86
971	80
456	80
456	86
1695	85
800	80
800	85
703	80
703	86
946	80
946	86
189	80
189	86
348	73
348	74
348	75
348	76
357	73
357	74
357	75
659	73
659	74
659	75
1598	73
1598	74
1598	75
1598	76
675	80
821	75
821	76
821	77
821	78
927	91
715	77
715	78
715	79
1509	80
1509	82
136	80
766	90
766	91
958	80
958	88
1628	88
194	80
899	80
899	88
193	80
89	74
210	75
227	75
783	90
716	78
837	74
837	75
1716	73
1716	74
1716	75
1716	76
1716	77
1716	78
1716	79
717	78
717	79
1738	84
968	79
995	80
1640	80
967	80
912	74
913	74
379	80
379	84
379	87
245	80
198	80
378	80
378	84
834	74
834	75
197	80
1516	74
836	74
836	75
443	74
1723	84
1723	86
762	73
762	74
286	75
1633	84
1633	86
337	80
829	80
829	84
829	86
751	74
751	75
930	80
18	80
18	84
793	74
793	75
390	74
390	75
182	80
182	84
182	86
646	90
283	75
712	75
712	76
712	77
712	78
712	79
707	90
100	73
1517	74
1517	75
1517	76
1517	77
1517	78
1722	89
1514	80
1514	85
1601	75
1601	76
1601	77
1601	78
802	90
962	74
1600	73
613	74
914	74
914	75
700	74
700	75
1592	74
1592	75
446	74
832	74
1659	74
1659	75
1610	74
857	74
1675	74
1675	75
917	74
867	74
867	75
436	74
1647	74
796	74
1728	74
1728	75
1586	74
1747	74
845	91
364	80
364	88
244	73
977	74
1729	74
1729	75
1589	80
1589	88
1718	73
1718	74
1718	75
1718	76
1718	77
1718	78
681	73
681	74
681	75
681	76
681	77
681	78
734	74
734	75
437	75
686	73
336	74
336	76
662	73
662	74
662	75
662	76
1769	74
1769	75
1769	76
450	74
450	75
450	78
1754	74
1754	75
791	74
791	75
630	73
630	74
896	74
896	75
897	74
897	75
897	76
359	74
359	75
359	76
359	78
425	74
935	74
935	75
1597	73
1597	74
1597	75
1597	76
464	74
464	75
1638	74
1638	75
1638	76
1638	78
1595	74
1595	75
561	80
916	74
916	75
812	77
812	78
647	73
647	74
647	75
647	76
647	77
647	78
647	79
915	74
915	75
1663	80
1531	74
1531	75
1531	76
672	80
925	74
925	75
895	80
1611	75
222	80
185	80
185	82
262	80
1630	80
803	80
803	82
803	83
667	80
13	74
13	75
13	78
274	75
671	74
671	76
671	77
671	78
1775	77
669	80
394	74
394	75
394	78
180	74
180	75
180	76
180	77
180	78
1774	74
1774	75
1726	74
1726	75
1540	77
1540	78
1731	74
1731	75
818	74
818	75
1658	74
1658	75
1727	74
1727	75
1674	74
1674	75
1532	73
1532	74
563	80
792	74
792	75
1525	75
674	74
674	78
674	80
673	80
1500	80
196	74
570	74
570	75
779	74
779	75
779	76
779	77
779	78
191	74
191	75
195	74
777	74
777	75
852	74
852	75
192	90
1692	77
1692	78
229	74
784	74
784	75
784	76
784	77
784	78
1691	74
1691	75
1691	76
1691	77
1691	78
980	74
980	75
228	74
228	75
567	74
567	75
243	74
328	80
835	74
835	75
80	80
794	74
794	75
465	80
940	74
940	76
326	74
326	75
938	74
938	76
938	78
296	80
831	74
831	75
780	90
976	74
976	75
735	74
735	75
1748	74
1748	75
776	90
1690	74
1690	75
1690	76
217	74
217	75
216	74
216	75
462	74
462	75
462	76
209	74
208	74
858	74
858	75
1689	74
1689	75
119	75
119	77
353	79
353	80
395	74
395	75
395	76
395	77
395	78
722	74
722	75
722	76
126	80
807	74
807	75
725	90
233	74
689	80
689	88
396	73
396	74
396	75
223	80
795	76
232	74
215	80
338	75
338	77
338	78
996	80
1548	80
965	73
965	74
965	75
965	76
965	77
965	78
304	80
670	75
670	78
670	80
894	74
894	76
894	77
894	78
79	74
79	75
893	74
893	75
320	74
320	75
320	80
295	80
892	74
892	75
892	76
892	77
892	78
149	75
702	73
702	74
702	75
918	90
919	90
920	90
1768	73
1768	74
1768	75
1768	76
368	80
1594	74
1594	75
1594	76
1594	77
865	80
1713	74
1713	75
770	80
770	88
1721	91
708	90
1510	74
106	91
1678	85
891	75
1639	74
1639	75
1679	85
461	74
461	75
969	75
110	75
1773	74
438	74
438	75
444	74
444	75
444	76
439	74
439	75
934	74
934	75
934	76
1533	74
1533	75
628	75
628	76
335	80
335	88
1526	80
1526	87
1526	88
890	75
772	74
1777	80
1777	88
986	80
986	88
1554	88
819	80
819	88
29	73
767	91
1542	79
711	80
221	74
1544	80
1544	84
1544	85
214	78
801	74
801	75
190	75
234	74
230	74
1545	80
1545	83
559	80
220	75
107	80
231	74
1541	80
1541	82
695	74
695	77
695	78
241	75
661	90
727	90
213	73
665	74
665	77
665	78
410	74
410	75
410	76
410	78
866	74
866	75
866	76
866	78
950	77
950	78
1673	78
666	74
666	75
666	76
666	77
666	78
785	90
732	90
1547	76
1528	78
1528	79
825	75
825	76
825	77
825	78
1590	76
298	80
1538	76
1538	77
332	75
668	80
331	74
331	75
728	90
466	74
466	77
466	78
788	74
788	76
788	77
788	78
593	74
593	78
778	78
333	75
333	78
1688	77
1688	78
240	80
239	80
334	75
334	77
334	78
238	80
696	78
714	90
746	90
729	90
729	91
1662	80
1607	76
1626	77
1626	78
1608	75
926	74
926	75
627	74
627	75
627	76
1612	75
305	77
305	78
924	74
924	75
994	90
798	90
713	74
1613	75
1613	76
724	74
724	75
705	74
705	75
705	76
824	74
824	75
964	74
964	75
964	76
805	74
805	75
698	77
698	78
442	80
1636	74
1636	75
1605	74
1696	85
26	74
26	75
26	76
1711	74
723	74
723	75
1604	76
19	74
19	75
759	74
1606	74
1606	75
1520	74
1609	78
97	74
97	75
1603	74
1603	75
183	74
183	75
183	76
309	74
309	75
309	76
309	77
309	78
564	74
564	75
564	76
564	77
564	78
1653	83
887	74
887	75
1634	74
1634	75
1634	76
351	78
351	79
650	90
313	74
313	75
313	76
313	77
313	78
313	79
1737	74
1737	75
1551	73
1551	76
350	75
350	78
1652	83
961	74
1740	74
237	80
1686	74
1686	75
306	80
1687	74
1687	75
1553	91
987	80
1752	74
1752	75
682	90
943	80
583	90
105	80
983	91
1552	91
786	80
366	73
366	74
366	75
710	90
370	73
370	75
726	91
881	80
562	80
773	80
307	73
307	74
307	75
299	80
816	74
816	75
816	76
816	78
877	75
886	74
886	75
1720	91
421	74
421	75
631	77
362	74
362	75
362	76
362	77
362	78
303	73
303	74
303	75
303	76
303	77
303	78
303	79
1583	74
1543	80
1684	74
1684	75
847	91
844	74
844	75
1717	75
885	74
885	75
885	76
885	77
885	78
1705	75
782	90
603	90
293	80
884	73
884	74
884	75
884	76
884	77
884	78
884	79
322	74
322	75
322	76
322	78
1537	74
143	73
143	74
143	75
143	76
143	77
143	78
143	79
733	74
1615	74
1615	75
691	91
148	75
294	80
709	90
862	91
1714	78
774	80
774	82
774	84
1508	80
285	75
389	80
1734	74
1734	75
236	75
1507	80
1669	88
775	80
181	80
135	80
758	87
1511	74
799	90
188	80
163	80
828	74
1519	80
1519	85
325	75
325	77
325	78
1523	80
1523	85
649	80
649	81
372	80
372	81
909	74
909	75
1534	76
680	80
623	90
1535	76
1739	74
1739	75
827	74
827	75
827	78
1736	74
1736	75
1736	76
1736	78
1736	79
1666	78
660	90
1530	80
1782	78
720	74
720	75
1646	73
1646	74
1646	75
1646	76
1646	77
1646	78
1646	79
207	78
787	74
787	75
787	76
432	80
431	90
397	73
397	74
397	75
397	76
397	77
397	78
397	79
823	74
823	75
1762	74
1762	75
409	74
409	75
956	91
1657	74
1735	74
1735	75
939	80
939	86
212	73
219	73
171	80
1751	85
820	74
820	75
921	80
921	85
226	74
287	75
910	74
910	75
911	74
911	75
1750	87
1756	77
1756	78
284	75
900	80
900	85
225	75
248	74
937	73
937	74
937	75
937	76
937	77
937	78
937	79
363	74
363	75
282	75
460	74
460	75
460	76
405	74
405	75
405	77
405	78
324	74
358	74
358	75
408	74
408	75
408	76
408	77
408	78
408	80
383	76
383	77
403	74
403	75
403	76
403	77
403	78
403	79
407	78
310	74
310	75
310	77
310	78
276	75
933	74
933	75
374	73
416	74
416	75
416	76
416	78
308	80
308	86
413	80
998	74
261	80
261	86
1599	80
1599	85
1599	88
846	91
154	80
694	80
344	80
344	86
260	80
260	86
851	91
664	80
736	74
736	75
736	76
985	80
985	88
1555	80
984	80
984	88
1772	74
312	80
323	80
1719	80
434	80
434	86
882	80
883	80
435	80
435	86
360	77
433	80
433	86
678	90
235	74
422	74
422	75
422	76
973	80
1593	74
1593	75
931	80
931	82
931	83
928	80
932	74
932	75
932	76
1614	74
1614	75
1614	77
347	74
347	75
347	77
347	78
1522	74
1522	75
1651	74
1651	75
1651	76
1651	77
1651	78
1568	80
375	73
1574	74
1574	75
1565	74
1565	75
1564	74
1564	75
1564	76
1564	77
1564	78
1567	80
1575	74
1575	75
1575	76
1575	77
1575	78
1570	91
1566	77
1566	78
1569	80
1569	85
418	73
418	74
418	75
418	76
418	77
863	91
870	74
870	75
870	76
870	77
870	78
701	76
701	77
701	78
301	80
693	90
1571	90
411	74
411	75
411	76
411	77
411	78
1627	74
1627	75
1627	76
211	78
\.


--
-- Data for Name: instruments; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY instruments (id, name, full_name, status, maturity, technology, sampling, data_access, data_format, measurements_and_applications, resolution_summary, best_resolution, swath_summary, max_swath, accuracy_summary, waveband_summary) FROM stdin;
184	X-ray astronomy payload	X-ray astronomy payload	No longer operational		Solar irradiance monitor	Sounding	\N	\N	Study of time variability and spectral characteristics of cosmic X-ray sources.	\N	\N	\N	\N	\N	\N
645	XPS	XUV Photometer System	Operational		Solar irradiance monitor	Imaging	Open Access	CDF	Measure the extreme UV solar irradiance from 1 - 35 nm with absolute accuracy of 20% and relative stability of 1% per year.	\N	\N	\N	\N	20% (0.2)	UV: 1 - 35 nm
697	X-Band SAR	X-Band Synthetic Aperture Radar	Operational	High Heritage - Operational	Imaging radar (SAR)	Other	Open Access	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	Spotlight: 1.2 x 1 - 4 m Stripmap: 3 x 3 - 6 m ScanSAR: 16 x 16 m	1m	Spotlight: 5-10km x 10 km, Stripmap: 30 km, ScanSAR: 100 km	100 km	\N	9.65 GHz, 300 MHz bandwidth, all 4 polarisation modes
730	WTE	Whale Tracker Experiment	No longer operational		Data collection system	Other	Constrained Access	\N	Tracking of Eubalean Australis and environmental data collection system.	\N	\N	\N	\N	\N	\N
1562	WSMSC	Wide-Swath Multi-Spectral Surveying Instrument	No longer operational		Medium-resolution spectro-radiometer	TBD	Very Constrained Access	\N	Wide-swath multi-spectral surveying instrument with high and medium spatial resolution.	\N	\N	\N	\N	\N	\N
988	WSAR	WSAR	Proposed		Imaging radar (SAR)	Other	\N	\N	High resolution radar measurements of land and ocean features.	3 modes: 1 m, 5 m, 10 m	1m	3 swaths: 40 km, 80 km, 150 km	150 km	\N	X-Band: 8 - 12 GHz
1733	WPM	Wide Swath Panchromatic and Multispectral Camera	Proposed		High resolution optical imager	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use, urban studies.	8 m multispectral, 2 m panchromatic	\N	90 km	90 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm, 0.45 - 0.90 µm
1730	WFV	Wide Field View	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use.	16 m Nadir	16m	800 km	800 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm; 0.77 - 0.89 µm
817	WFI-2 (CBERS)	Wide Field Imager-2 (CBERS)	Operational	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use. WFI-2 (Amazonia-1) is the same instrument as WFI-2 (CBERS), however due differences in orbital altitude, they have different spatial resolutions.	64 m Nadir	64m	866 km	866 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm; 0.77 - 0.89 µm
391	WINDII	WINDII	No longer operational		Limb-scanning SW spectrometer	Imaging	\N	\N	Day and night wind measurements between 80 and 300 km altitude. Measures atmospheric temperature and concentration of emitting species.	\N	\N	\N	\N	\N	\N
1625	WindRAD	Wind Radar	Prototype		Radar scatterometer	\N	Constrained Access	\N	Measures sea-surface wind.	\N	\N	\N	\N	\N	C and Ku band.
459	WiFS	Wide Field Sensor	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Vegetation and crop monitoring, resource assessment (regional scale), forest mapping, land cover/ land use mapping, and change detection.	188 m	188m	810 km	810 km	\N	2 channels: R-IR
1732	WFI (CBERS-4A)	Wide Field Imager	Proposed		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GEOTIFF	Agriculture; Forestry; Geology; Natural disaster management; Cartography; Environment monitoring; Fire detection, localization and counting; Hydrology, coastal water mapping; Land use; Surveillance and law enforcement	55  m	55m	690 km	690 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
1698	WFI-2 (Amazonia-1)	Wide Field Imager-2 (Amazonia-1)	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GEOTIFF	Used for fire extent detection measurement, coastal and vegetation monitoring, land cover and land use mapping. WFI-2 (Amazonia-1) is the same instrument as WFI-2 (CBERS), however due differences in orbital altitude, they have different spatial resolutions.	VIS - NIR: 60 m	60m	740 km	740 km	\N	VIS: 0.45 - 0.50 µm, 0.52 - 0.57 µm, 0.63 - 0.69 µm, NIR: 0.76 - 0.90 µm
768	WALES	Water vApour Lidar Experiment in Space	No longer considered		Atmospheric lidar	Other	\N	\N	Accurate profiles of water vapour globally and at high vertical resolution, with the horizontal resolution expected for global atmospheric models.	Typically 100 km sampling	\N	1 - 2 km vertical sampling	\N	< 5 % systematic error	NIR: 935 nm range
138	WEFAX	Weather Facsimile	No longer operational	High Heritage - Operational	\N	Imaging	\N	\N	Weather facsimile.	\N	\N	\N	\N	\N	\N
81	VTIR	Visible and Thermal Infrared Radiometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Medium resolution visible and thermal infrared imaging of ocean and atmosphere.	VIS: 900m, TIR: 2700m	\N	1500km	\N	\N	VIS: 0.5-0.7μm, TIR: 6.0-7.0μm, 10.5-11.5μm, 11.5-12.5μm
699	WAOSS-B	Wide-Angle Optoelectronic Stereo Scanner	No longer operational		High resolution optical imager	Imaging	\N	\N	Vegetation and Cloud coverage.	185 m	\N	533 km	\N	\N	VIS: 600 - 670nm, NIR: 840 - 900 nm
642	WFC	Wide Field Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF	Scene Context	IFOV 125 m, Swath 61 km	125m	61 km	61 km	\N	VIS: 620 to 670 nm
406	WFI	Wide Field Imager	No longer operational	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Data used for coastal and vegetation monitoring.	258 m	258m	890 km	890 km	0.3 pixels	VIS: 0.63 - 0.69 µm, NIR: 0.77 - 0.89 µm
1680	VNREDSat 1 HS	VNREDSat 1 Hyperspectral	No longer considered		High resolution optical imager	\N	\N	\N	The VNREDSat 1b hyperspectral instrument is designed for land cover measurements and applications.	\N	\N	\N	\N	\N	Hyperspectral NIR.
966	VSC	Venus Superspectral Camera	Being developed		High resolution optical imager	Imaging	Open Access	\N	High resolution superspectral images (12 spectral bands) for vegetation and landcover applications.	5.3 m spatial resolution with 27 km swath	5.3m	27 km	27 km	\N	420 nm centre wavelength (width: 40 nm); 443 nm (40); 490 nm (40); 555 nm (40); 620 nm (40); 620 nm (40);  667 nm (30);  702 nm (24); 742 nm (16);  782 nm (16);  865 nm (40); 910 nm (20)
1681	VNREDSat 1 MS	VNREDSat 1 Multispectral	Operational		Medium-resolution spectro-radiometer	Imaging	Open Access	\N	The VNREDSat 1 multispectral instrument is designed for land cover measurements and applications.	MS bands: 10m; panchromatic 2.5m	2.5m	17.5 km	\N	\N	There are 4 bands of multispectral, visible and infrared and panchromatic
1776	VNIR (GF-4)	Visible and Near-Infrared Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Infrared measurements for environmental and natural disaster monitoring.	50m	50m	400km	400 km	\N	0.45 - 0.90µm, 0.45 - 0.52 µm, 0.52 -0.60 µm, 0.63-0.69 µm, 0.76-0.90 µm
14	VISSR (FY-2)	Multispectral Visible and Infra-red Scan Radiometer (3 channels)	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Multispectral Visible and Infra-red Scan Radiometer.	\N	\N	\N	\N	\N	\N
77	VISSR (GMS-4)	Visible and Infra-red Spin Scan Radiometer (GMS-4)	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Data used for cloud type and cloud motion detection. Also measures sea surface temperature.	\N	\N	\N	\N	\N	\N
718	VNIR	Imaging Spectrometer	No longer considered		High resolution optical imager	Imaging	\N	\N	Ocean colour, columnar content of atmospheric aerosol particles bio-geo-chemical fluxes through vegetation, air sea fluxes of energy, hydrological analysis.	\N	\N	\N	\N	\N	VIS - NIR: 412.4 nm, 443 nm, 490 nm, 510 nm, 555 nm, 570 nm, 665 nm, 680 nm, 705 nm, 765 nm, 865 nm, 946 nm
78	VISSR (GMS-5)	Visible and Infra-red Spin Scan Radiometer (GMS-5)	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Data used for cloud type and motion detection wind. Also measures sea surface temperature and atmospheric water vapour.	Visible: 1.25 km, TIR: 5 km	\N	Full Earth disk in all channels, every 1 hour	\N	\N	VIS: 0.55 - 0.9 µm, TIR: 6.5 - 7 µm, 10.5 - 11.5 µm, 11.5 - 12.5 µm
876	EUVS	Extreme Ultraviolet Sensor	No longer considered		Solar irradiance monitor	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1676	VHR PAN Camera  and MS Camera	Very High Resolution Panchromatic Camera and Multi-Spectral Camera	No longer considered		High resolution optical imager	Imaging	Constrained Access	'GeoTiff	Land use, risk, agriculture and forestry, topographic mapping and cartography, vegetation and agriculture, natural resources, security, cultural heritage.	PAN = 0.5 m; MS = 2 m	0.5m	10 km x 10 km	10 km	\N	PAN = 450-900 nm; BLUE = 450-520 nm; GREEN = 520-600 nm; RED = 630-690 nm; NIR = 760-900 nm
1539	Visible imaging spectrometer (HyspIRI)	Visible imaging spectrometer (HyspIRI)	Proposed	Medium Heritage	High resolution optical imager	Imaging	Open Access	\N		60 m at nadir; 3 week revisit time	60m	90 km	90 km	Spectral accuracy < .5 nm	400 - 2500 nm
412	VIIRS	Visible/Infrared Imager Radiometer Suite	Operational	Medium Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Global observations of land, ocean, and atmosphere parameters: cloud/weather imagery, sea-surface temperature, ocean colour, land surface vegetation indices.	400 m - 1.6 km	400m	3000 km	3000 km	SST 0.35 K	VIS - TIR: 0.4 - 12.5 µm (22 channels)
257	VIRI	VIRI	No longer considered		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Discontinued - functionality will be "included" on the AVHRR on MetOp-C.	\N	\N	\N	\N	\N	\N
402	VIRS	Visible Infra-red Scanner	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF	Data to be used in conjunction with data from CERES instrument to determine cloud radiation. Will enable 'calibration' of precipitation indices derived from other satellite sources.	2 km at nadir	2000m	720 km	\N	\N	VIS: 0.63 µm, SWIR - MWIR: 1.6 µm and 3.75 µm, TIR: 10.8 µm and 12 µm
67	VHRR	Very High Resolution Radiometer	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Cloud cover, rainfall, wind velocity, sea surface temperature, outgoing longwave radiation, reflected solar radiation in spectral band 0.55 - 0.75 µm, emitted radiation in 10.5 - 12.5 µm range.	2 km in visible, 8 km in IR	2000m	Full Earth disk every 30 minutes	\N	\N	VIS: 0.55 - 0.75 µm, NIR: 5.7 - 7.1 µm, TIR: 10.5 - 12.5 µm
684	VIRR	Multispectral Visible and Infra-red Scan Radiometer (10 channels)	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	L-1 data: HDF 5.0	Multispectral Visible and Infra-red Scan Radiometer.	1.1 km at nadir	1100m	2800 km	\N	1.1 km	Instrument features 10 channels over 0.43 - 10.5 µm
1637	VIS-NIR	Multi-spectral Optical Camera - Visible & Near Infrared	Approved		High resolution optical imager	Imaging	\N	\N	Ocean Colour - Open ocean, coastal & in-land waters.	200m - 800 m	200m	1400 km	1400 km	\N	Visible & Near Infrared, 11 bands:  412 - 443 - 490 - 510 - 555 - 620 - 665 - 680 - 710 - 765 - 865 nm
404	VEGETATION	VEGETATION	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Data of use for crop forecast and monitoring, vegetation monitoring, and biosphere/ geosphere interaction studies.	1.15 km at nadir - minimal variation for off-nadir viewing	1150m	2200 km	\N	\N	Operational mode: VIS: 0.61 - 0.68 µm, NIR: 0.78 - 0.89 µm, SWIR: 1.58 - 1.75 µm, Experimental mode: VIS: 0.43 - 0.47 µm
1504	UVNS (Sentinel-5)	Ultra-violet Visible Near-infrared Shortwave-infrared spectrometer	Being developed		High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	NetCDF-4	Supporting atmospheric composition and air quality monitoring services. Measurements of atmospheric trace gases, primarily O3, NO2, SO2, HCHO, CH4 and CO.	7.5 km at SSP for wavelengths > 300 nm, 45 km for wavelengths < 300 nm	\N	Daily global coverage	2670 km	TBD	UV-1: 270 – 310 nm, UV-2-VIS: 300 - 500 nm, NIR: 710 nm & 755 – 773 nm , SWIR-1: 1590 - 1675 nm SWIR-3: 2305 - 2385 nm
1664	Vegetation	Vegetation	Operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Global coverage every two days for uses including climate impact assessments, surface water resource management, agricultural monitoring, and food security estimates.	100 m resolution at Nadir, 350 m on full field of view	100m	102° field of view with 2250 km wide swath	2250 km	\N	Equivalent spectral bands to Spot Vegetation: VNIR: Blue (438-486 nm), Red (615-696 nm), Near IR (772-914 nm), SWIR (1564-1634 nm).
1742	VDES Test Mission	VHF Data Exchange System Test Mission	Approved		Communications system	\N	\N	\N	VHF data exchange system enabling bidirectional communications at higher data rates than AIS.	\N	\N	\N	\N	\N	\N
137	VAS	VISSR Atmospheric Sounder	No longer operational		Narrow-band channel IR radiometer	Sounding	\N	\N	VISSR Atmospheric Sounder., Spin scan radiometer/atmospheric sounder., 8 detectors for 1 visible channel, 6 detectors for 3 IR channels.	\N	\N	\N	\N	\N	\N
942	UVNS (Sentinel-5 precursor)	TROPOMI	Proposed		High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	\N	Supporting atmospheric composition and air quality monitoring services.	5 - 15 km at SSP, possibly relaxed to 50 km for wavelengths < 300 nm	\N	Daily global coverage	\N	TBD	UV-1: 270 - 300 nm, UV-2: 300 - 400 nm, VIS: 400 - 500 nm, NIR: 710 - 775 nm, SWIR-3: 2305 - 2385 nm
855	Variant	variant	No longer operational		\N	TBD	\N	\N		\N	\N	\N	\N	\N	\N
860	VFM	Vector Field Magnetometer	Operational		Magnetometer	Other	Open Access	\N	Magnetic field vector measurements.	<0.1nT	\N	N/A	\N	<0.5 nT/15 days	N/A
1602	TSU	Temperature Sounding Unit	No longer considered		Data collection system	Sounding	Open Access	\N	Atmospheric soundings, atmospheric stability, thermal gradient winds.	40 - 96 km	\N	1550 km	\N	\N	17 Channel , 1 channel each in 23.8 and 31.5 GHz and 15 channels in 50 - 60 GHz
941	UVN (Sentinel-4)	UV-visible- near infrared imaging spectrometer (Sentinel-4)	Proposed		High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	\N	Supporting atmospheric composition and air quality monitoring services.	< 5 km at SSP, possibly relaxed to 50 km for wavelengths < 308 nm	\N	FOV E-W: 30°W-45°E @ 40°N, N-S: 30°N-65°N	\N	TBD	UV-1: 290 - 308 nm, UV-2: 308 - 400 nm, VIS: 400 - 500 nm, NIR: 750 - 775 nm
949	UVN	UV-VIS-NIR Sounder	Approved		High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	netCDF	Measurements of atmospheric trace gases, mainly O3, NO2, SO2, H2CO. The product list is not yet approved, the accuracy summary column lists the breakthrough user requirements.	< 5 km at SSP, possibly relaxed to 50 km for wavelengths < 308 nm	\N	FOV E-W: 30°W-45°E @ 40°N, N-S: 30°N-65°N	\N	H2CO: 50%, NO2: 50%, O3: 10%, SO2: 50%	UV-1: 290 - 308 nm, UV-2: 308 - 400 nm, VIS: 400 - 500 nm, NIR: 750 - 775 nm
1513	UVAS	UVAS (Ultraviolet Visible and near-infrared Atmospheric Sounder)	Being developed	Medium Heritage	High-resolution nadir-scanning SW spectrometer	Sounding	Constrained Access	\N	High spatial resolution observations of air quality and climate gases such as ozone (O3), nitrogen dioxide (NO2), sulphur dioxide (SO2), formaldehyde (HCHO) glyoxal (CHO-CHO), and aerosols over selected zones of interest (urban and industrialized areas, mayor motorways, and special events like forest fires, volcano eruption and sand storms). Also measurements of halogenated compounds will be performed, including bromine monoxide (BrO) and iodine monoxide (IO).	10km	10000m	250	250 km	trace gas profile 10 - 40%	UV/VIS 290 - 490 nm
1697	TSX-NG X-Band SAR	TSX-NG X-Band SAR	No longer considered		Imaging radar (SAR)	Imaging	Open Access	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	HR Spotlight: 0.25 x 0.25 m, HR Stripmap: 0,5 x 1 m, Stripmap: 1 x 1 m ScanSAR: 10 - 25 x 25 m	0.25m	HR Spotlight: 5 km x 10 km, HR Stripmap: 10 km Stripmap: 30 km, ScanSAR: up to 600 km	600 km	\N	9.65 GHz, up to 1200 MHz bandwidth, fully polarimetric
247	TV camera	TV camera	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Survey of cloud cover and Earth surface.	\N	\N	\N	\N	\N	\N
1546	UV Spectrometer (GACM)	UV Spectrometer (GACM)	Proposed	Medium Heritage	High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	\N	Daytime measurements of O3, NO2, SO2, CH2O, and aerosols.	\N	\N	\N	\N	\N	305 - 320 nm and 500 - 650 nm
1536	UV/Vis Near IR Wide Imaging Spectrometer (Geo-Cape)	UV/Vis Near IR Wide Imaging Spectrometer (Geo-Cape)	Proposed	High Heritage - Non-Operational	High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	\N	Measures natural and human-produced  gases and aerosols in the atmosphere, including those that react in sunlight to form polluting low-level ozone.	7 km spatial resolution, single layer vertical resolution, 0.9 nm spectral resolution	7000m	typically uses 2D data array with 1-D north to south in space (7 km wide) and 1D for (oversampled) spectral intervals/bins.  The spatial domain is mechanically scanned for east to west to cover a continental domain (either north or south America).	\N	ozone precision: 1.3 x 10^16 cm^(-2); NO2 precision: 5 x 10^14 cm^(-2)	315 - 600 nm
679	TSIS-1	Total Solar and Spectral Irradiance Sensor 1	Being developed	Medium Heritage	Solar irradiance monitor	Sounding	Open Access	\N	0.2 - 2 µm solar spectral irradiance monitor and total spectra monitor	\N	\N	\N	\N	1.5 w/m2	UV - SWIR: 0.2 - 2 µm and total spectra
1770	TROPICS	Microwave Spectrometer (TROPICS)	Being developed		Absorption-band MW radiometer/spectrometer	Sounding	Open Access	HDF	Constellation to provide temperature/moisture sounding and cloud/precipitation imaging with rapid update.	Moisture:  25 km average across the swath; Temperature: 40 km average across the swath	17000m	2000 km	2000 km	1 K	Microwave:  90 to 206 GHz
764	TRSR	Turbo-Rogue Space Receiver	No longer operational		GNSS radio-occultation receiver	Other	Open Access	\N	Precise continuous tracking data of satellite to decimetre accuracy.	\N	\N	\N	\N	\N	\N
1715	TSIS-2	Total Solar and Spectral Irradiance Sensor 2	Being developed		Solar irradiance monitor	Sounding	\N	\N	0.2 - 2 µm solar spectral irradiance monitor and total spectra monitor	\N	\N	\N	\N	1.5 w/m2	UV - SWIR: 0.2 - 2 µm and total spectra
1724	TriG	TriG Receiver for Radio Occultation	Being developed		GNSS radio-occultation receiver	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
246	Travers SAR	Travers SAR	No longer operational		Imaging radar (SAR)	Sounding	\N	\N	Measures vegetation canopy type and state, soil moisture, land topography and ice and sea surface roughness.	\N	\N	\N	\N	\N	\N
485	TRASSER	TRASSER	No longer operational		Multi-channel/direction/polarisation radiometer	Imaging	\N	\N	Imaging multi-spectral radiometer (visible).	\N	\N	\N	\N	\N	\N
275	TOVS (HIRS/2 + MSU + SSU)	TIROS Operational Vertical Sounder	No longer operational		\N	Sounding	\N	\N	TIROS Operational Vertical Sounder suite of instruments.	\N	\N	\N	\N	\N	\N
906	TOU/SBUS	Total Ozone Unit & Solar Backscatter Ultraviolet Sounder	Operational		High-resolution nadir-scanning SW spectrometer	Sounding	Constrained Access	L-1 data: HDF 5.0	Ozone total column vertical profile measurements.	TOU: 50 km total ozone, SBUS: 200 km total ozone	\N	TOU: 3000 km, SBUS: nadir only	\N	50km	TOU: 6 channels in the range 308 - 360 nm, SBUS: in the range 252 - 340 nm
765	TOPEX	TOPEX NASA Radar Altimeter	No longer operational		Radar altimeter	Other	\N	\N	Measurement of global ocean surface topography.	\N	\N	6 km	\N	2.4 cm	Microwave: 126 GHz and 5.3 GHz
415	TOMS	Total Ozone Mapping Spectrometer	No longer operational		High-resolution nadir-scanning SW spectrometer	Imaging	\N	\N	Retrieval of ozone column measurements.	39 x 39 km (nadir)	\N	\N	\N	\N	UV absorption
763	TMR	TOPEX Microwave Radiometer	No longer operational		Non-scanning MW radiometer	Other	\N	\N	Altimeter data to correct for errors caused by water vapour and cloud-cover. Also measures total water vapour and brightness temperature.	44.7 km at 18 GHz, 37.4 km at 21 GHz, 23.6 km at 37 GHz	\N	120 deg cone centred on nadir	\N	Total water vapour: 0.2 g/sq cm, Brightness temperature: 0.3 K	Microwave: 18 GHz, 21 GHz, 37 GHz
721	TOPSAT Telescope	TOPSAT Telescope	No longer operational		High resolution optical imager	Imaging	\N	\N	Experimental medium-resolution imaging satellite supporting a range of possible land applications.	Multi-spectral imagery (RGB). resolution 5.6 m	5.6m	Panchromatic imagery 17 x 17 km; Multi Spectral - Swath 12 x 18 km	17 km	\N	Panchromatic imagery. Resolution 2.8 m
685	TOM	Total Ozone Mapper	No longer considered		High-resolution nadir-scanning SW spectrometer	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
414	TMI	TRMM Microwave Imager	No longer operational		Multi-purpose imaging MW radiometer	Imaging	Open Access	HDF	Measures rainfall rates over oceans (less reliable over land), combined rainfall structure and surface rainfall rates with associated latent heating. Used to produce monthly total rainfall maps over oceans.	Vertical: 2.5 km approx; Horizontal: 18 km	\N	790 km	\N	Liquid water: 3 mg/cm3, Humidity: 3 mg/cm3, Ocean wind speed: 1.5 m/s	Microwave: 10.7 GHz, 19.4 GHz, 21.3 GHz, 37 GHz, and 85.5 GHz
1743	TIP	Tiny Ionospheric Photometer	Operational		Space environment monitor	Other	Open Access	\N	Observes Earth's ionosphere at 135.6 nm and facilitates tomography of the ionosphere (when combined with other instruments aboard the COSMIC satellites).	\N	\N	\N	\N	\N	135.6 nm
327	TM	Thematic Mapper	No longer operational	High Heritage - Operational	High resolution optical imager	Imaging	Open Access	\N	Measures surface radiance and emittance, lands cover state and change (eg vegetation type).  Used as multipurpose imagery for land applications. Declared no longer operational June 4, 2012.	VIS - SWIR, 30 m; TIR: 120 m	30m	185 km	185 km	\N	VIS - TIR: 7 bands: 0.45 - 12.5 µm
1524	TIRS	Thermal Infrared Sensor	Operational		Narrow-band channel IR radiometer	Imaging	Open Access	\N	Measures surface emittance, lands cover state and change).  Used as multipurpose imagery for land applications.	100 m	100m	185 km	185 km	Absolute geodetic accuracy of 44 m;  geometric accuracy of 32 m or better	TIR 10.5 µm and 12 µm
719	TIR	Surface Temperature Imager	No longer considered		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Sea surface Temperature.	\N	\N	\N	\N	\N	11 µm, 12 µm
1746	TIRS-2	Thermal Infrared Sensor - 2	Approved		Narrow-band channel IR radiometer	Imaging	Open Access	\N	Measures surface radiance and emittance, lands cover state and change (eg vegetation type).  Used as multipurpose imagery for land applications. TIRS-2 will adhere to the Landsat 8 TIRS instrument performance specifications, but will be built to NASA Class-B instrument standards (including a 5-year design life).	100 m	100m	185 km	185 km	\N	TIR 10.5 µm and 12 µm
1712	TIR	Two-band Thermal Infrared Camera	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Sea surface temperature measurement	400m	400m	1400 km	1400 km	\N	TIR 2 bands: 10800 - 11800 nm
644	TIM	Total Irradiance Monitor	Operational		Solar irradiance monitor	Imaging	Open Access	HDF	Measurement of total solar irradiance directly traceable to SI units with an absolute accuracy of 0.03% and relative accuracy of 0.001% per year.	\N	\N	Looks at the sun every orbit, providing 15 measurements per day	\N	0.04%	\N
1573	TGSP	Trace Gas Spectrometer	Proposed		Medium-resolution spectro-radiometer	Imaging	Constrained Access	\N	Trace gas measurements.	\N	\N	\N	\N	\N	\N
1506	TBD	\N	No longer considered		\N	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1725	TGRS	TriG (Tri-GNSS) GNSS Radio-occultation System	Proposed		GNSS radio-occultation receiver	\N	\N	\N	TGRS is the radio occultation receiver, which will receive signals from GPS, Galileo, and Glonass.	\N	\N	\N	\N	\N	\N
923	TES PAN	Panchromatic Camera	No longer operational		High resolution optical imager	Imaging	No Access	\N	High resolution images for study of topography, urban areas etc.	1 m	1m	\N	\N	\N	Panchromatic VIS: 0.5 - 0.75 µm
1655	TANSO-FTS-2	Thermal And Near infrared Sensor for carbon Observation - Fourier Transform Spectrometer-2	Being developed		High-resolution nadir-scanning IR spectrometer	Sounding	Open Access	TBD	CO2, CH4, and CO distribution.	9.7km	\N	160km	\N	\N	0.754 - 0.772 µm, 1.56 - 1.69 µm, 1.92 - 2.38 µm, 5.55 -8.41 µm,  8.41 - 14.3 µm
959	TDP	Technological Development Package	No longer operational		GNSS receiver	Other	Constrained Access	\N	Develop, test, and operate the Technological Demonstration Package (TDP) for demonstrating a newly developed GPS receiver for position, velocity, and time determination and an Inertia Reference Unit (IRU) to measure inertial angular velocity.	\N	\N	\N	\N	\N	\N
905	TANSO-FTS	Thermal And Near infrared Sensor for carbon Observation - Fourier Transform Spectrometer	Operational	Low Heritage	High-resolution nadir-scanning IR spectrometer	Sounding	Open Access	HDF5	CO2 and CH4 distribution.	10.5 km	\N	160 km	\N	\N	0.758 - 0.775 µm, 1.56 - 1.72 µm, 1.92 - 2.08 µm, 5.56 - 14.3 µm
349	TES	Tropospheric Emission Spectrometer	Operational		High-resolution nadir-scanning IR spectrometer	Imaging	Open Access	HDF(Level1) , HDF-EOS (Level-2 and 3)	3D profiles on a global scale of all infra-red active species from surface to lower stratosphere. Measures greenhouse gas concentrations, tropospheric ozone, acid rain precursors, gas exchange leading to stratospheric ozone depletion.	In limb mode: 2.3 km vertical resolution. In down-looking mode: 50 x 5 km (global), 5 x 0.5 km (local)	\N	Limb mode: global: 50 x 180 km, local: 5 x 18 km	\N	Ozone: 20 ppb, Trace gases: 3 - 500 ppb	SWIR-TIR: 3.2 - 15.4 µm
1654	TANSO-CAI-2	Thermal And Near infrared Sensor for carbon Observation - Cloud and Aerosol Imager-2	Being developed		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	TBD	Detection and correction of cloud and aerosol for TANSO-FTS, aerosol characteristics	0.5 km (0.343, 0.443, 0.674, 0.869, 0.380, 0.550, 0.674, 0.869 µm bands), 1.0 km (1.63 µm band)	500m	1000 km	\N	\N	0.343 µm, 0.443 µm, 0.674 µm, 0.869 µm, 1.63 µm / tilt angle +20deg.\n0.380 µm, 0.550 µm, 0.674 µm, 0.869 µm, 1.63 µm / tilt angle -20deg.
904	TANSO-CAI	Thermal And Near infrared Sensor for carbon Observation - Cloud and Aerosol Imager	Operational	Medium Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF5	Detection and correction of cloud and aerosol for TANSO-FTS.	0.5 km (0.380, 0.674, 0.870 µm bands), 1.5 km (1.62 µm band)	500m	1000 km (0.380 µm, 0.678 µm, 0.870 µm bands), 750 km (1.62 µm band)	\N	\N	0.380 µm, 0.674 µm, 0.870 µm, 1.60 µm
1644	SWIM	Surface Waves Investigation and Monitoring	Approved		Radar scatterometer	Other	Constrained Access	netcdf	Ku-band Real-aperture radar (RAR) system, multi-incindence beams(0-10°) and azimuth scanning. Measurement of 2D ocean waves spectrum	50x50km on 2D spectra	\N	140 km	\N	accuracy for wave estimates: minimum detectable wavelength of about 70 m, maximum detectable wavelength about 500m, accuracy in wave propagation direction of about 15°, accuracy in wavelength of 10 to 20%, accuracy in significant wave height of 10% or better than 40-50 cm (TBC)	Ku-band
141	SXI	Solar X-ray Imager	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Obtains data on structure of solar corona. Full disk imagery also provides warnings of geomagnetic storms, solar flares, and information on active regions of sun and filaments.	\N	\N	\N	\N	\N	\N
875	SXS	Solar X-Ray Sensor	No longer considered		Solar irradiance monitor	Other	\N	\N		\N	\N	\N	\N	\N	\N
771	SWIFT	Stratospheric Wind Interferometer for Transport studies	No longer considered		Limb-scanning SW spectrometer	Other	\N	\N	Measures a mid-infrared thermal emission line of ozone in order to reach the 20 - 40 km region in the stratosphere and to measure stratospheric winds, as well as ozone.	\N	\N	\N	\N	\N	\N
953	SUVI	Solar Ultraviolet Imager	Being developed	Medium Heritage	Solar irradiance monitor	Other	\N	\N	The SUVI will monitor the entire dynamic range of solar x-ray features, including coronal holes and solar flares, and will provide quantitative estimates of the physical conditions in the Sun’s atmosphere.	\N	\N	\N	\N	\N	\N
569	SU-UMS	Stereo Radiometer with High Resolution	No longer considered		High resolution optical imager	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
568	SU-VR	Visible Radiometer with High Resolution	No longer considered		High resolution optical imager	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
929	SSTM-1 (Oceansat-3)	Sea Surface Temperature Monitor-1	Being developed		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	TIR and OCM combination will support joint analysis for operational potential fishing zones.	1080 m	1080m	1440 km	\N	\N	2 bands
329	SSU	Stratospheric Sounding Unit	No longer operational		Narrow-band channel IR radiometer	Sounding	\N	\N	Temperature profiles in stratosphere, top-of-atmosphere radiation from 25 - 50 km altitude.	\N	\N	\N	\N	\N	\N
156	SUSIM (UARS)	Solar Ultraviolet Irradiance Monitor	No longer operational		Solar irradiance monitor	Sounding	\N	\N	Data on UV and charged particle energy inputs, and on time variation of full-disk solar UV spectrum.	\N	\N	\N	\N	\N	\N
741	SSULI	Special Sensor Ultraviolet Limb Imager	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Measures vertical profiles of the natural airglow radiation from atoms, molecules and ions in the upper atmosphere and ionosphere.	\N	\N	\N	\N	\N	\N
908	SumbandilaSat Imager	SumbandilaSat Imager	No longer operational	Low Heritage	High resolution optical imager	Imaging	Open Access	\N	Primary payload (imager): Support decision making in natural resource management, disaster management, agriculture, urban planning and other applications.	6.25 m GSD	6.25m	Swath width : 45 km; Off-nadir: 530 km	530 km	\N	Blue  440 - 510 nm, XAN  520 - 540 nm, Green  520 - 590 nm, Red  630 - 685 nm, RedEdge 690 - 730 nm, NIR 845 - 890 nm
742	SSUSI	Special Sensor Ultraviolet Spectrographic Imager	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Monitors the composition and structure of the upper atmosphere and ionosphere, as well as auroral energetic particle inputs, with spectrographic imaging and photometry.	\N	\N	\N	\N	\N	\N
861	STR	Star Tracker Set (3)	Operational		Star tracker	Other	Open Access	\N	Precise attitude determination from the combination of two or three star trackers.	<1 arcsec	\N	N/A	\N	< 3 arcsec pointing accuracy around all STR axes	N/A
636	SSZ	SSZ	No longer operational		\N	Sounding	\N	\N	Laser threat detector.	\N	\N	\N	\N	\N	\N
453	SSM/T-2	Special Sensor Microwave Water Vapor Sounder	Operational	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	Water vapour profiler.	Approx 48 km	\N	1500 km	\N	\N	Microwave: 91.6, 150, 183.31 (3 channels) (Total 5 channels)
1556	SSTI	Satellite-to-Satellite Tracking Instrument	No longer operational	Medium Heritage	GNSS receiver	TBD	Open Access	\N	Measurements of low-frequency (coarse-scale) gravity field variations as well as highly precise positioning on GOCE.	\N	\N	\N	\N	\N	\N
452	SSM/T-1	Special Sensor Microwave Temperature Sounder	Operational	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	Measures Earth's surface and atmospheric emission in the 50 - 60 GHz oxygen band.	174 km diameter beam	\N	1500 km	\N	\N	Microwave: 7 channels in the 50 - 60 GHz range
740	SSJ/5	Special Sensor Precipitating Plasma Monitor	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Measurement of transfer energy, mass, and momentum of charged particles through the magnetosphere-ionosphere in the Earth's magnetic field.	\N	\N	\N	\N	\N	\N
634	SSJ/4	Special Sensor Precipitating Plasma Monitor	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Measurement of transfer energy, mass, and momentum of charged particles through the magnetosphere-ionosphere in the Earth's magnetic field.	\N	\N	\N	\N	\N	\N
454	SSM/IS	Special Sensor Microwave Imager Sounder	Operational	High Heritage - Operational	Multi-purpose imaging MW radiometer	Sounding	\N	\N	Measures thermal microwave radiation.  Global measurements of air temp profile, humidity profile, ocean surface winds, rain overland/ocean, ice concentration/age, ice/snow edge, water vapour/clouds over ocean, snow water content, land surface temperature.	Varies with frequency: 25 x 17 km to 70 x 42 km	\N	1700 km	\N	\N	Microwave: 19 - 183 GHz (24 frequencies)
635	SSM	Special Sensor Magnetometer	Operational	High Heritage - Operational	Magnetometer	Other	\N	\N	Measures geomagnetic fluctuations associated with solar geophysical phenomena. With SSIES and SSJ provides heating and electron density profiles in the ionosphere.	\N	\N	\N	\N	\N	\N
1674	MUX (SJ-9A)	Multispectral CCD Camera	Operational		High resolution optical imager	Imaging	Open Access	\N		10 m	10m	30 km	30 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm; 0.77 - 0.89 µm
451	SSM/I	Special Sensor Microwave Imager	Operational	High Heritage - Operational	Multi-purpose imaging MW radiometer	Other	\N	\N	Measures atmospheric, ocean and terrain microwave brightness temperatures to provide: sea surface winds, rain rates, cloud water, precipitation, soil moisture, ice edge, ice age.	15.7 x 13.9 km to 68.9 x 44.3 km (depends on frequency)	\N	1400 km	\N	\N	Microwave: 19.35 GHz, 22.235 GHz, 37 GHz, 85 GHz
633	SSI/ES-2	Special Sensor Ionospheric Plasma Drift/Scintillation Meter	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Measurement of the ambient electron density and temperatures, the ambient ion density, and ion temperature and molecular weight.	\N	\N	\N	\N	\N	\N
738	SSB/X	Special Sensor Gamma Ray Particle Detector	No longer considered		Space environment monitor	Other	\N	\N	Detects the location, intensity, and spectrum of X-rays emitted from the Earth's atmosphere.	\N	\N	\N	\N	\N	\N
254	SROSMO	Spectroradiometer for ocean monitoring	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Spectroradiometer for ocean monitoring with 11 channels.	\N	\N	\N	\N	\N	\N
632	SSB/X-2	Special Sensor Gamma Ray Particle Detector	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Detects the location, intensity, and spectrum of X-rays emitted from the Earth's atmosphere.	\N	\N	\N	\N	\N	\N
903	SRAL	SAR Radar Altimeter	Operational		Radar altimeter	Other	Open Access	\N	Marine and land services.	300 m	300m	Profiling	\N	3 cm in range (1 s average, 2 m SWH including atm. corrections)	Dual freq radar altimeter, Ku-band, C-band
1672	Spectrometer (TEMPO)	Spectrometer (TEMPO)	Being developed		High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	TBD	Hourly measurements of air pollution over North America, from Mexico City to the Canadian oil sands, at high spatial resolution. Measurements in ultraviolet and visible wavelengths will provide a suite of products including the key elements of tropospheric air pollution chemistry. Will be part of the first global geostationary constellation for pollution monitoring, along with European and Korean missions now in development.	2.22 km by 5.15 km at at geodetic location 36.5° N, 100° W	5150m	From 18 degrees N to 58 degrees N	4200 km	Precisions include tropospheric O3 to 10 ppbv in 1 hour, tropospheric NO2 to 1e15 molecules cm-2 in 1 hour, and tropospheric H2CO to 1e16 molecules cm-2 in 3 hours, all geo-located to an accuracy of 4 km.	290 to 750 nm (TBC)
739	SSI/ES-3	Special Sensor Ionospheric Plasma Drift/Scintillation Meter	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Measurement of the ambient electron density and temperatures, the ambient ion density, and ion temperature and molecular weight.	\N	\N	\N	\N	\N	\N
1671	Spectrometer (OCO-3)	Spectrometer (OCO-3)	Being developed		High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	HDF	Global measurements of atmospheric CO2 needed to describe the variability of CO2 sources and sinks.	2.25 km downtrack by 0.7 km cross-track	\N	Soundings ≤ 4.5 km2 in area during Nadir Observation	\N	provide single sounding estimates of XCO2 with one sigma errors of <= 2 ppm	0.765 µm, 1.61 µm, 2.06 µm
1558	Spectrometer (OCO-2)	Spectrometer (OCO-2)	Operational		High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	HDF	Global measurements of atmospheric CO2 needed to describe the variability of CO2 sources and sinks.	2.25 km downtrack, variable cross-track	\N	Varies from 0.1 km at the sub-solar latitude to 10.6 km at terminators	\N	Provide the data needed to yield single sounding estimates of XCO2 with one sigma errors of <= 2 ppm	0.76 µm, 1.61 µm, 2.06 µm
321	SPECTRA	Surface Processes and Ecosystem Changes Through Response Analysis	No longer considered		High resolution optical imager	Imaging	\N	\N	Data for study of land surface processes.	Spatial sampling interval approx 50 m, along track pointing ±30 deg	\N	50 km	\N	\N	VIS - SWIR: 450 - 2350 nm and TIR: 10.3 - 12.3 µm
369	SOPRANO	Sub-millimetre Observation of Processes in the Absorption Noteworthy for Ozone	No longer considered		Limb-scanning MW spectrometer	Imaging	\N	\N	Temperature profiles and trace gases in the upper troposphere to mesosphere including ClO, O3, HCl, NO, BrO as first priority, and HOCl, CH3Cl, H2O, N2O, HO2, HNO3 as second priority.	Vertical: 2 km at lowest level, Limb viewing instrument	\N	10 - 50 km tangent height range	\N	Band a: 2.5 K, Bands b and c: 12 K, Band d: 8 K at 3 MHz resolution, 0.3 secs integration time	Sub-millimetre a) 499.4 - 505 GHz, b) 624.5 - 626.6  GHz and 628.2 - 628.7 GHz, c) 730.5 - 732 GHz, d) 851.3 - 852.8 GHz
330	Sounder	Sounder	Operational	High Heritage - Non-Operational	Narrow-band channel IR radiometer	Sounding	\N	\N	Atmospheric soundings and data on atmospheric stability and thermal gradient winds.	10 km	\N	Horizon to horizon	\N	\N	VIS - TIR: 19 channels
868	Spectrometer (OCO)	Spectrometer (OCO)	No longer operational		High-resolution nadir-scanning SW spectrometer	TBD	\N	\N	Global measurements of atmospheric CO2 needed to describe the variability of CO2 sources and sinks.	\N	\N	\N	\N	\N	0.76 µm, 1.61 µm, 2.06 µm
761	SOVAP	SOlar Variability Picard radiometer	No longer operational		Solar irradiance monitor	Other	\N	\N	Total solar irradiance measurements.	\N	\N	\N	\N	\N	Total irradiance
789	Sounder (INSAT)	IR Sounder	Operational		Narrow-band channel IR radiometer	Sounding	Constrained Access	\N	Atmospheric soundings, atmospheric stability, thermal gradient winds.	10 x 10 km	\N	Full (Full Earth disc sounding), Program (Options provided for for Sector Scans)	\N	\N	SWIR: 3.74 - 4.74 µm; MWIR: 6.51 - 11.03 µm; TIR: 12.02 - 14.71 µm; VIS: 0.55 - 0.75 µm
1529	Solar reflected spectrometer (CLARREO)	Solar reflected spectrometer (CLARREO)	No longer considered	Medium Heritage	High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	\N	Solar reflected spectrometer (CLARREO).	\N	\N	\N	\N	3 parts per 100	300 to 2000 nm.
663	SOFIS	Solar Occultation Fourier transform spectrometer for Inclined Orbit Satellite	No longer considered		Limb-scanning SW spectrometer	Sounding	\N	\N	Monitors ozone and its minor constituents to obtain the global distribution of O3, HNO3, NO2, N2O, CH4, H2O, CO2, CFC-11, CFC-12, ClONO2, aerosols, pressure & temperature. Provides 3D global ozone distribution along with OPUS.	\N	\N	Altitudes of 5 - 150 km	\N	\N	MWIR - TIR: 3.25 - 6.5 µm, 6.5 - 13 µm, 753 - 784 nm
1587	SMILES	Superconducting Submillimeter-Wave Limb-Emission Sounder	No longer operational		Limb-scanning MW spectrometer	Sounding	Constrained Access	HDF5	High-sensitivity observation of stratospheric minor gases related to ozone depletion.	\N	\N	\N	\N	O3: less than 5% (15 - 60 km), 1% (~30 km) HCl: less than 10% (15 - 50%) ClO: less than 30% (25 - 50 km)	624.32 - 625.52GHz, 625.12 - 626.32GHz, 649.12 - 650.32GHz
419	SOLSTICE	SOLar STellar Irradiance Comparison Experiment	Operational		Solar irradiance monitor	Imaging	Open Access	HDF	Measures solar UV spectral irradiance (115 - 310 nm) with resolution of 0.1 nm and  with an absolute accuracy of 2% and relative stability of 0.3% per year. Compares solar UV output with UV radiation of stable bright blue stars.	\N	\N	\N	\N	2% (0.02)	UV: 115 - 310 nm
1763	SMMR	Scanning Multi-channel Microwave Radiometer	No longer operational	Low Heritage	Multi-purpose imaging MW radiometer	Imaging	Open Access	\N	Global sea-ice concentrations and type (age) and sea surface temperatures; sea surface winds; snowcover; soil moisture; atmospheric water vapor over oceans; and rainfall.	Cross-track/along-track sampling intervals range from 14 km x 14 km to 58 km x 28 km over the wavelength interval.	14000m	Forward viewing and scans 390 km to either side of the orbital track	780 km	\N	Scanning radiometer operating at frequencies of 37 (0.81 cm), 21 (1.42 cm), 18 (1.66 cm), 10.69 (2.8 cm), and 6.6 (4.54 cm) GHz.
880	Solar Coronograph	Solar Coronograph	No longer considered		Solar irradiance monitor	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1521	SAR-X	Synthetic Aperature Radiometer (RISAT-2)	Operational		Imaging radar (SAR)	Imaging	Very Constrained Access	\N	For disaster management applications.	3 - 8 m	3m	10 km, 50 km	650 km	\N	X Band (9.0 Ghz)
743	SMR	Submillimetre Radiometer	Operational		Limb-scanning MW spectrometer	Other	Open Access	\N	Measures global distributions of ozone and species of importance for ozone chemistry ClO, HNO3, H2O, N2O, (HO2, H2O2).  Measures temperature in the height range 15 - 100 km.	Vertical resolution 1.5 - 3 km, along track 600 km	\N	Altitudes of 5 - 100 km	\N	2 - 40% depending on species and altitude	Microwave: 118.7 GHz + 4 bands in the region 480 - 580 GHz: Tuneable measures 2 - 3 x 1 GHz regions at a time; ~0.1 cm - ~0.3 cm
760	SODISM	SOlar Diameter Imager and Surface Mapper	No longer operational		Solar irradiance monitor	Other	\N	\N	Measures diameter and differential rotation of the sun - a whole Sun imager.	\N	\N	\N	\N	\N	UV: 230 nm, VIS: 548 nm, Active regions: 160 nm plus Lyman alpha detector
975	SIM	Solar Irradiation Monitor	Operational		Solar irradiance monitor	\N	Constrained Access	L-1 data: HDF 5.0	Solar irradiance monitoring.	\N	\N	\N	\N	\N	0.2 - 50 µm
902	SLSTR	Sea and Land Surface Temperature Radiometer	Operational		Multi-channel/direction/polarisation radiometer	Imaging	Open Access	\N	Marine and land services.	500 m (VNIR/SWIR), 1 km (TIR)	500m	1675 km (near-nadir view), 750km (backward view)	1675 km	0.2 K abs., 80 mK rel.	9 bands in VNIR/SWIR/TIR
769	SLIM-6	Surrey Linear Imager - 6 channel	No longer operational		High resolution optical imager	Imaging	Constrained Access	\N	Visible and NIR imagery in support of disaster management - part of the Disaster Management constellation.	32 m	32m	Two imaging banks each with a 340km swath.  The two swaths overlap by 16km, providing a total swath up to 648km	648 km	S/N 100:1 @ target albedo of 0.1.	VIS: 0.63 - 0.69 µm, 0.52 - 0.60 µm; NIR: 0.77 - 0.90 µm.
253	SLR-3	Side looking Radar	No longer operational		Imaging radar (SAR)	Imaging	\N	\N	Side looking radar with a 3 cm wavelength.	\N	\N	\N	\N	\N	\N
1632	SIM-2	Solar Irradiation Monitor-2	Operational		Solar irradiance monitor	\N	\N	\N	Solar irradiance monitoring.	\N	\N	\N	\N	\N	0.2 - 50 µm
944	SLIM-6-22	Surrey Linear Imager - 6 channel - 22m resolution	Operational		High resolution optical imager	Imaging	Constrained Access	IMI (custom data format)	Visible and NIR imagery in support of disaster management - part of the Disaster Management constellation.	22 m	22m	Two imaging banks each with a 330km swath.  The two swaths overlap by 11km, providing a total swath up to 638km	638 km	S/N 150:1 @ target albedo of 0.1.	VIS: 0.63 - 0.69 µm, 0.52 - 0.61 µm; NIR: 0.77 - 0.90 µm.
688	SIRAL	SAR Interferometer Radar Altimeter	Operational		Radar altimeter	Other	Open Access	\N	Marine ice and terrestrial ice sheet thickness measurement.	Range resolution 45 cm, along-track resolution 250 m	\N	Footprint 15 km	\N	Arctic sea-ice: 1.6 cm/year for 300 km x 300 km cells, Land ice (small scale): 3.3 cm/year for 100 x 100 km cells, Land ice (large scale): 0.17 cm/year for Antarctica size area	Microwave: 13.575 GHz (Ku-Band)
781	SKL-M	Solar ray spectrometer	No longer considered		Solar irradiance monitor	Other	\N	\N	Proton flux density.	\N	\N	\N	\N	\N	2, 4, 6 and > 6 MeV, 30, 50, 100, 300 and > 300 MeV
1755	SHMASR	Medium resolution wide capture multispectral optical sensor	Proposed		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Land surface and ocean monitoring	5; 10; 20	5m	120 km	160 km	\N	0.50-0.80 µm; 0.45-0.51 µm; 0.51-0.58 µm; 0.63-0.69 µm; 0.77-0.89 µm; 0.71-0.75 µm; 0.76-0.80 µm; 0.85-0.89 µm; 0.89-0.96 µm; 1.55-1.70 µm
874	SGPS	Solar and Galactic Proton Sensor	No longer considered		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	\N
991	SI	Star Imager	Operational		Star tracker	TBD	\N	\N	Measurements to determine the orientation of both the satellite and the CSC magnetometer.	\N	\N	\N	\N	\N	\N
252	SILVA	SILVA	No longer operational		\N	Imaging	\N	\N	Optronic equipment for stereophotography with 4 operating ranges.	\N	\N	\N	\N	\N	\N
1694	SHMSA-VR	High resolution wide capture multispectral optical sensor	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Land surface and ocean monitoring	12 m; 23,8 m	12m	97 km	950 km	\N	0.43 - 0.7 µm; 0.43 - 0.51 µm; 0.51 - 0.58 µm; 0.60 - 0.70 µm; 0.70 - 0.80 µm; 0.80 - 0.90 µm;
1693	SHMSA-SR	Medium resolution wide capture multispectral optical sensor	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Land surface and ocean monitoring	60 m; 120 m	60m	441 km	950 km	\N	0.43 - 0.7 µm; 0.43 - 0.51 µm; 0.51 - 0.58 µm; 0.60 - 0.70 µm; 0.70 - 0.80 µm; 0.80 - 0.90 µm;
626	SIM	Spectral Irradiance Monitor	Operational		Solar irradiance monitor	Imaging	Open Access	HDF	Measures solar spectral irradiance in the 200 - 2000 nm range.	\N	\N	\N	\N	2% (0.02)	UV - SWIR: 200 - 2490 nm
901	SGLI	Second-generation Global Imager	Approved	Medium Heritage	Medium-resolution spectro-radiometer	Imaging	No Access	HDF5	Medium resolution multi-spectral imaging of land, ocean and atmosphere. SGLI-VNR is an optical sensor capable of multi-channel nadir observation at wavelengths from near-UV to NIR and forward or backward polarization observation at red and near infrared wavelengths (Push-broom scanning). SGLI-IRS is an optical sensor capable of multi-channel nadir observation at wavelengths from SWIR to TIR wavelengths (Cross-track scanning).	SGLI-VNR: 250 m, 1000 m; SGLI-IRS: 250 m, 500 m, 1000 m	250m	SGLI-VNR: 1150 km; SGLI-IRS: 1400km	1400 km	\N	VIS - NIR: 0.38 - 0.865 µm; SW: 1.05 - 2.21 µm; TIR: 10.8 - 12.0 µm
1624	SES	Space  Environment  Suite, improved SEM	Operational		Space environment monitor	\N	Constrained Access	\N	Measures space environment parameters to support space craft operations.	\N	\N	\N	\N	\N	\N
1502	SEM-N	Space Environment Monitor - NPOESS	Being developed	Medium Heritage	Space environment monitor	Sounding	\N	\N	Used for equipment failure analysis, solar flux measurement, solar storm warning, and magnetic and electric field measurement at satellite.	\N	\N	\N	\N	\N	Senses and quantifies intensity in the sequentially selected energy bands, with energies ranging from 0.05 - 20 keV.  Senses protons, electrons, and ions with energies from 30 keV to levels exceeding 6.9 MeV.
218	SFM-2	UV limb spectrometer	No longer operational		Limb-scanning SW spectrometer	Sounding	\N	\N	Global ozone monitoring.	\N	\N	\N	\N	\N	UV-Visible: 0.2 - 0.51 µm (4 channels)
1780	SEMIP/SEM	Space Environment Monitoring Instrument Package - Space Environmentr Monitor	Prototype		\N	\N	\N	\N		\N	\N	\N	\N	\N	\N
683	SESS	Space Environmental Sensor Suite	No longer considered		Space environment monitor	Sounding	\N	\N	Measures characteristics of auroral boundary, auroral energy deposition, auroral imagery, electric field, electron density profile, geomagnetic field, in-situ plasma fluctuations, ionosphere scintillation. Data aids future space system design.	\N	\N	\N	\N	\N	\N
65	SEM (POES)	Space Environment Monitor	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Used for equipment failure analysis, solar flux measurement, solar storm warning, and magnetic and electric field measurement at satellite.	\N	\N	\N	\N	\N	Senses and quantifies intensity in the sequentially selected energy bands, with energies ranging from 0.05 - 20 keV.  Senses protons, electrons, and ions with energies from 30 keV to levels exceeding 6.9 MeV
731	SAR-L	L-Band Synthetic Aperture Radar	Being developed		Imaging radar (SAR)	Imaging	\N	XML + binary HDF5	Land, ocean, emergencies, soil moisture, interferometry, others.	10 x 10 m – 100 x 100 m	10m	20 – 350 km	350 km	0.5 dB	L-band (1.275 GHz)
251	SAR-70	Synthetic Aperture Radar	No longer operational		Imaging radar (SAR)	Imaging	\N	\N	Synthetic aperture radar with 70 cm wavelength.	\N	\N	\N	\N	\N	\N
737	SARSAT	Search and Rescue Satellite Aided Tracking	No longer considered	High Heritage - Operational	\N	Other	\N	\N	Satellite and ground based system to detect and locate aviators, mariners, and land-based users in distress.	\N	\N	\N	\N	\N	UHF 406.0 MHz
249	SAR-3	Synthetic Aperture Radar	No longer operational		Imaging radar (SAR)	Imaging	\N	\N	Synthetic aperture radar with 3 cm wavelength.	\N	\N	\N	\N	\N	\N
302	SEVIRI	Spinning Enhanced Visible and Infra-Red Imager	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	native	Measurements of cloud cover, cloud top height, precipitation, cloud motion, vegetation, radiation fluxes, convection, air mass analysis, cirrus cloud discrimination, tropopause monitoring, stability monitoring, total ozone and sea surface temperature.	HRV=1 km, All other channels=3 km (spatial sampling distance at SSP)	1000m	9 km swath scanning E-W, moving up S-N a swath width at the end of each swath.  Full Disc Coverage (FDC) or Local Area Coverage (LAC) possible.	9 km	Cloud cover: 10%, Cloud top height: 1 km, Cloud top temperature: 1 K, Cloud type: 8 classes, Surface temperature: 0.7 - 2.0 K, Specific humidity profile: 10%, Wind profile (horizontal component): 2 - 10 m/s, Long wave Earth surface radiation: 5 W/m2	VIS0.6=0.5975 - 0.6725 µm, VIS0.8=0.775 - 0.845 µm, NIR1.6=1.57 - 1.71 µm, IR3.9=3.7 - 4.14 µm, WV6.3=5.8 - 6.7 µm, WV7.3=7.1 - 7.6 µm, IR8.7=8.5 - 8.9 µm, IR9.7=9.52 - 9.8 µm, IR10.8=10.3 - 11.3 µm, IR12.0=11.5 - 12.5 µm, IR13.4=12.9 - 13.9 µm, HRV=~0.48 - 0.91 µm ,unfiltered Si (measured at FWHM)
1781	SEMIP-fields	Space Environment Monitoring Instrument Package - fields	Prototype		\N	\N	\N	\N		\N	\N	\N	\N	\N	\N
1518	SDR	Software Defined Radio	Operational	Low Heritage	Communications system	Other	Very Constrained Access	\N	Software Defined Radio (SDR) for reception of VHF AIS (Automatic Identification System).	\N	\N	\N	\N	Modelling shows that the instrument should detect more than 95% of the vessels carrying AIS within the satellite's field of view in the High North each orbit.	VHF
367	SCIAMACHY	Scanning Imaging Absorption Spectrometer for Atmospheric Chartography	No longer operational	High Heritage - Operational	High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	\N	Measures middle atmosphere temperature. Provides tropospheric and stratospheric profiles of O2, O3, O4, CO, N2O, NO2, CO2, CH4, H2O, and tropospheric and stratospheric profiles of aerosols and cloud altitude.	Limb vertical 3 x 132 km, Nadir horizontal 32 x 215 km	\N	Limb and nadir mode: 1000 km (max)	\N	Radiometric: <4%	UV - SWIR: 240 - 314 nm, 309 - 405 nm, 394 - 620 nm, 604 - 805 nm, 785 - 1050 nm, 1000 - 1750 nm, 1940 - 2040 nm and 2265 - 2380 nm
637	SEM (GOES)	Space Environment Monitor	Operational	High Heritage - Operational	Space environment monitor	Other	\N	\N	Used for equipment failure analysis, solar flux measurement, solar storm warning, and magnetic and electric field measurement at satellite.	\N	\N	\N	\N	\N	\N
952	SEISS	Space Environment In Situ Suite	Being developed	High Heritage - Non-Operational	Space environment monitor	Other	\N	\N	Monitor proton, electron, and alpha particle fluxes.	15 deg, 30 deg, 60 deg, 90 deg	\N	\N	\N	25%	30 eV - 500 MeV
974	SEM	Space  Environment  Monitor	Operational		Space environment monitor	\N	Constrained Access	\N	Measures space environment parameters to support space craft operations.	\N	\N	\N	\N	\N	\N
427	SeaWinds	SeaWinds	Operational		Radar scatterometer	Imaging	Open Access	\N	Measurement of surface wind speed and direction. The SeaWinds antenna on QuikSCAT stopped rotating in November 2009, and the instrument no longer collects ocean wind vector data. However it still provides calibration data for other on-orbit scatterometers, which enables the continuation of a climate-quality wind vector dataset.	25 km	\N	1600 km	\N	Speed: 2 - 3.5 m/s Direction: 20 deg	Microwave: 13.402 GHz
1704	SEI	Suprathermal Electron Imager	Operational		Space environment monitor	Other	Open Access	\N	The SEI measures the electron energy and pitch angle distribution over the energy range of 1 to 200 eV, with particular emphasis on photoelectrons in the 1 to 50 eV range.	N/A	\N	N/A	\N	\N	N/A
455	SEM (JAXA)	Space Environment Monitor (JAXA)	No longer operational		Space environment monitor	Imaging	\N	\N		\N	\N	\N	\N	\N	VIS (~0.40 µm - ~0.75 µm)
1512	SCAT-M3	Scatterometer	Approved	Low Heritage	Radar scatterometer	Imaging	Constrained Access	\N	Ocean surface wind measurements.	25 km	25m	1800 km	1800 km	Wind speed: 2 m/s, direction: 20 grad	Ku-band
869	Scatterometer (JAXA)	Scatterometer	No longer considered		Radar scatterometer	TBD	\N	\N		\N	\N	\N	\N	\N	\N
752	Scatterometer (Oceansat-2)	Scatterometer (Oceansat-2)	No longer operational		Radar scatterometer	Other	Open Access	\N	Ocean surface wind measurements. Instrument failed in February 2014.	50 km	\N	1440 km	\N	\N	13.515 GHz
1645	SCAT	Wind SCATerometer	Being developed		Radar scatterometer	Imaging	Constrained Access	\N	Ocean surface wind vector	\N	\N	\N	\N	\N	Ku-band
1703	Scatterometer (Scatsat-1)	Scatterometer (Scatsat-1)	Operational		Radar scatterometer	Other	Open Access	\N	Ocean surface wind measurements.	50 km	\N	1440 km	\N	\N	13.515 GHz
972	SCAT	Scatterometer	Operational		Radar scatterometer	Imaging	\N	\N	Monitoring global sea surface winds.	50 km	\N	1300 km	\N	0.5 dB	13.2515 GHz, HH, VV
345	SCATTEROMETER	Scatterometer	No longer considered		Radar scatterometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
1749	Scatterometer (Oceansat-3)	Scatterometer (Oceansat-3)	Being developed		Radar scatterometer	Other	Open Access	\N	Ocean surface wind measurements, continuity to ocean vector wind	25 km	\N	1440 km	\N	\N	13.515 GHz
864	ScaRaB/MV2	Scanner for Earth's Radiation Budget	No longer operational		Broad-band radiometer	Imaging	\N	\N	Measures top-of-atmosphere shortwave radiation (0.2 - 4.0 µm) and total radiation (0.2 - 50 µm). Two additional narrow-band channels (0.5 - 0.7 µm and 11 - 12 µm) allow cloud detection and scene identification.	60 km	\N	2200 km	\N	Absolute: ± 2.5 W/m2/sr, Relative: ± 0.7 W/m2/sr	VIS window channel: 0.5 - 0.7 µm, Solar channel UV - SWIR: 0.2 - 4 µm, Total channel UV - FIR: 0.2 - 50 µm, Thermal window channel: 10.5 - 12.5 µm
318	SBUV/2	Solar Backscattter Ultra-Violet Instrument/2	Operational	High Heritage - Operational	High-resolution nadir-scanning SW spectrometer	Sounding	\N	\N	Data on trace gases including vertical profile ozone, and solar irradiance and total ozone concentration measurements.	170 km	\N	\N	\N	Absolute accuracy: 1%	UV: 0.16 - 0.4 µm (12 channels)
177	SBUV/3	Solar Backscattter Ultra-Violet Instrument/3	No longer operational		High-resolution nadir-scanning SW spectrometer	Sounding	\N	\N	Solar Backscatter Ultra-Violet Instrument.	\N	\N	\N	\N	\N	\N
1665	S-band SAR (NISAR)	S-band Synthetic Aperture Radar (SAR) (NISAR)	Proposed		Imaging radar (SAR)	Imaging	Open Access	TBD	3-year mission to study solid earth deformation (earthquakes, volcanoes, landslides), changes in ice (glaciers, sea ice) and changes in vegetation biomass	At 12-day repeat, global coverage, 10m resolution	1m	240 km	240 km	TBD	S-Band: 4-2 GHz
657	SBUV/1	Solar Backscatter Ultraviolet 2 instrument	No longer operational		High-resolution nadir-scanning SW spectrometer	Imaging	\N	\N	Data on trace gases including vertical profile ozone, and solar irradiance and total ozone concentration measurements.	\N	\N	\N	\N	\N	\N
1631	SCA	SCA	Being developed		Radar scatterometer	Sounding	\N	\N	Measures wind speed and direction over ocean, soil moisture, sea ice cover, sea ice type, snow cover and snow parameters and vegetation parameters	25 km	\N	2x 550 km swath width	\N	Wind speeds in range 4 - 24 m/s	Microwave: C Band, 5.355 GHz
382	ScaRaB	Scanner for Earth's Radiation Budget	Operational		Broad-band radiometer	Imaging	Constrained Access	\N	Measures top-of-atmosphere shortwave radiation (0.2 - 4.0 µm) and total radiation (0.2 - 50 µm). Two additional narrow-band channels (0.5 - 0.7 µm and 11 - 12 µm) allow cloud detection and scene identification.	40 km	\N	2200 km	\N	Absolute: ± 2.5 W/m2/sr, Relative: ± 0.7 W/m2/sr	VIS window channel: 0.5 - 0.7 µm, Solar channel UV - SWIR: 0.2 - 4 µm, Total channel UV - FIR: 0.2 - 50 µm, Thermal window channel: 10.5 - 12.5 µm
826	S-Band SAR	S-Band Synthetic Aperture Radar	Operational		Imaging radar (SAR)	Imaging	Open Access	\N	Radar measurements for natural and disaster monitoring.	20 m (4 looks)	20m	100 km	100 km	3 dB	S-Band SAR
250	SAR-10	Synthetic Aperture Radar	No longer operational		Imaging radar (SAR)	Imaging	\N	\N	Synthetic aperture radar with 10 cm wavelength with survey, intermediate and detailed modes.	\N	\N	\N	\N	\N	\N
922	SAR-L	Synthetic Aperture Radiometer (L band)	No longer considered		Imaging radar (SAR)	Imaging	Very Constrained Access	\N	Studies related to soil moisture and ocean salinity.	1.5 m, 2.5 m, 5 m, 20 m, 35 m	1.5m	10 - 120 km	10 km	\N	L Band
704	SAR 2000	Synthetic Aperture Radar - 2000	Operational		Imaging radar (SAR)	Imaging	Constrained Access	HDF5,\nGeoTiff	All-weather images of ocean, land and ice for monitoring of land surface processes, ice, environmental monitoring, risk management, environmental resources, maritime management, Earth topographic mapping.	Single polarisation modes; Spotlight: 1 m. Stripmap: 3 - 15 m, ScanSAR: 30 or 100 m. Two polarisation mode (PING-PONG): 15 m.	1m	Single polarisation modes: Spotlight: 10 km. Stripmap; 40 km. ScanSAR: 100 or 200 m - Two polarisation mode (PING-PONG): 30 km.	200 km	\N	Microwave: X-band, 9.6 GHz, with choice of 5 polarisation modes (VV, HH, HV, VH, HH/HV + VV/VH)
706	SAR (SABRINA)	Synthetic Aperature Radar (SABRINA)	No longer considered		Imaging radar (SAR)	Imaging	\N	\N	All-weather images of ocean, land and ice for monitoring of land surface processes, ice, environmental monitoring, risk management, environmental resources, maritime management, Earth topographic mapping and DEM, moving target indication.	\N	\N	\N	\N	\N	Microwave: X-band, with choice of 4 polarisation modes (VV, HH, VV/HH, HV/HH).
963	SAR components testing	SAR components testing	No longer considered		\N	TBD	\N	\N		\N	\N	\N	\N	\N	\N
790	SAR (RISAT)	Synthetic Aperature Radiometer (RISAT)	Operational		Imaging radar (SAR)	Imaging	Constrained Access	\N	Radar backscatter measurements of land, water and ocean surfaces for applications in soil moisture, crop applications (under cloud cover), terrain mapping, etc.	3 - 6 m (FRS-1), 9 - 12 m (FRS-2), 25/50 m (MRS/CRS)	3m	30 km (HRS), 30 km (FRS-1/FRS-2), 120/240 km (MRS/CRS)	240 km	\N	C-Band (5.350 Ghz)
971	SAR (MAPSAR)	Synthetic Aperture Radar (MAPSAR)	No longer considered	Low Heritage	Imaging radar (SAR)	Imaging	\N	\N	Multi-Application Purpose Radar.	\N	\N	\N	\N	\N	\N
456	SAR (RADARSAT)	Synthetic Aperture Radar (CSA) C band	No longer operational	High Heritage - Operational	Imaging radar (SAR)	Imaging	Constrained Access	CEOS	All-weather images of ocean, ice and land surfaces. Used for monitoring of coastal zones, polar ice, sea ice, sea state, geological features, vegetation and land surface processes.	Nominal resolutions: Standard: 30 m (4 looks); Wide: 30 m (4 looks); Fine: 8 m (1 look); ScanSAR (N/W): 50 m / 100 m (4/8 looks); Extended (H/L): 18 - 27 m / 30 m (4/4 looks).	8m	Standard: 100 km (inc.: 20 - 49 deg); Wide: 150 km (inc.: 20 - 45 deg), Fine: 45 km (inc.: 37 - 47 deg); ScanSAR (N/W): 300/500 km (inc.: 20 - 49 deg); Extended (H/L): 75/170 km (inc.: 52 - 58 / 10 - 22 deg).	500 km	Geometric distortion: < 40 m Relative Radiometric Accuracy (within a 100km scene): <1 dB	Microwave: C band 5.3 GHz, HH polarization.
1695	SAR (KOMPSAT-6)	SAR (KOMPSAT-6)	Approved		Imaging radar (SAR)	\N	Very Constrained Access	\N		\N	\N	\N	\N	\N	X-Band
800	SAR	Synthetic Aperture Radar X band	No longer operational	Medium Heritage	Imaging radar (SAR)	Imaging	Constrained Access	\N	High resolution microwave radar images for ice watch.	1 m, 5 m, 50 m, 200 m, 500 m	1m	10 km, 50 km, 130 km, 600 km, 750 km	750 km	1 dB	X-Band
703	SAR (RADARSAT-2)	Synthetic Aperture Radar (SAR) C band	Operational	High Heritage - Operational	Imaging radar (SAR)	Imaging	Constrained Access	Image Products in a format that uses GeoTIFF for imagery and XML for metadata.	All-weather images of ocean, ice and land surfaces. Used for monitoring of coastal zones, polar ice, sea ice, sea state, geological features, vegetation and land surface processes.	Standard: 27 - 17 x 25 m (4 looks); Wide: 40 - 19 x 25 m (4 looks); Fine: 10 - 7 x 8 m (1 look); ScanSAR (N/W): 80 - 38 x 60 m / 160 - 172 x 100 m (4/8 looks),  Extended (H/L): 18 - 16 x 25 m / 60 - 23 x 25 m (4 looks); Ultra-Fine: 4.6 - 2.1 x 2.8 m (1 lo	0.8m	Standard: 100 km (inc.: 20 - 49 deg); Wide: 150 km (inc.: 20 - 45 deg); Fine: 50 km (inc.: 30 - 50 deg); ScanSAR (N/W): 300/500 km (inc.: 20 - 46 / 20 - 49 deg); Extended (H/L): 75/170 km (inc.: 49 - 60 / 10 - 23 deg); Ultra-Fine: 20 km (inc.: 20 - 49 deg	500 km	Relative Radiometric Accuracy (within a 100 km scene): <1 dB	Microwave: C band 5.405 GHz.  HH, VV, HV, VH polarization - includes Quad polarization imaging modes.
946	SAR (RCM)	Synthetic Aperture Radar (SAR) C band	Being developed	High Heritage - Operational	Imaging radar (SAR)	Imaging	Constrained Access	Image Products in a format that uses GeoTIFF for imagery and XML for metadata, or NITF for imagery and metadata.	All-weather, C-band data to support ecosystem monitoring, maritime surveillance and disaster management.	Low Resolution 100 m and Low Noise: 100 x 100 m (8 looks); Medium Resolution 50 m: 50 x 50 m (4 looks); Medium Resolution 30 m: 30 x 30 m (4 looks); Medium Resolution 16 m: 16 x 16 m (4 looks);  High-Resolution 5 m: 5 x 5 m (1 look); Very High Resolution 3 m: 3 x 3 m @35deg (1 look); Spotlight: 1 x 3 m @35deg (1 look); Quad-Pol: 9 x 9 m (1 look).	1m	Low Resolution 100 m: 500 km; Medium Resolution 50 m: 350 km; Low Noise: 350 km;  Ship Detection: 350 km; Medium Resolution 30 m: 125 km; Medium Resolution 16 m: 30 km;  High-Resolution 5 m: 30 km; Very High Resolution 3 m: 20 km; Spotlight: 20 km [5 km along-track]; Quad-Pol: 20 km.	500 km	Absolute Radiometric Accuracy: +/- 1.0 dB	Microwave: C band 5.405 GHz: HH, VV, HV, VH polarization - includes Quad polarization imaging mode and compact polarimetry.
655	SAM II	Stratospheric Aerosol Measurement II instrument	No longer considered		Limb-scanning SW spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
189	S&R (NOAA)	Search and Rescue Satellite Aided Tracking	Operational	High Heritage - Operational	Communications system	Sounding	\N	\N	Satellite and ground based system to detect and locate aviators, mariners, and land-based users in distress.	\N	\N	\N	\N	\N	\N
348	SAGE III	Stratospheric Aerosol and Gas Experiment-III	No longer operational		Limb-scanning SW spectrometer	Sounding	\N	\N	Profiles of ozone, water vapour, NO2, OCIO, aerosols, temperature and pressure.	1 - 2 km vertical resolution	\N	\N	\N	Temperature: 2 K, Ozone: 6%, Humidity: 3 - 10%, Aerosol and trace gases: 5 - 10%	UV - NIR: 0.29 - 1.55 µm (9 channels)
357	SAGE II	Stratospheric Aerosol and Gas Experiment-II	No longer operational		Limb-scanning SW spectrometer	Sounding	\N	\N	Profiles of ozone, water vapour, NO2, OCIO, aerosols.	0.5 km	\N	\N	\N	\N	7 channels, UV - NIR: 0.385 - 1.02 µm
659	SAGE I	Stratospheric Aerosol and Gas Experiment I instrument	No longer operational		Limb-scanning SW spectrometer	Sounding	\N	\N	Profiles of ozone, water vapour, NO2, OCIO, aerosols, temperature and pressure.	\N	\N	\N	\N	\N	\N
1598	SAGE-III	Stratospheric Aerosol and Gas Experiment	Being developed		Limb-scanning SW spectrometer	Other	\N	\N	Limb-viewing measurements of aerosol, O3, H20, NO2, OClO, NO3, temperature and pressure in the stratosphere, upper troposphere, and mesosphere using solar occultation, lunar occultation and limb scatter measurement techniques.	1 - 2 km vertical	\N	N/A	\N	Aerosol profile: 5%, H20: 10 - 15%; NO2:  10-15%; NO3:  10%; O3: 5%; OClO: 25%; Pressure: 2%; Temperature Profile; 2K	Nine spectral regions between 290 - 1550 nm
656	SAMS	Stratospheric and Mesospheric Sounder instrument	No longer operational		Limb-scanning IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
675	SAPHIR	Sondeur Atmospherique du Profil'd’Humidite Intertropicale par Radiometrie	Operational		Absorption-band MW radiometer/spectrometer	Imaging	Constrained Access	\N	Cross-track sounder with the objective of measuring water vapour profiles in the troposphere in six layers from 2 - 12 km altitudes.	10 km	\N	2200 km	\N	\N	Microwave: 183.3 GHz (6 channels)
821	SABER	Sounding of the Atmosphere usingBroadband Emission Radiometry	No longer considered		Limb-scanning IR spectrometer	TBD	\N	\N	SABER provides measurements of the mesosphere and lower thermosphere globally to support investigations into the fundamental processes governing the energetics, chemistry, dynamics, and transport of the atmospheric region extending from 60 to 180 km.	2 km vertical resolution	\N	\N	\N	\N	NIR - FIR: 1.27  - 17 µm (10 channels)
927	ROSA	Radio Occultation Sensor for Atmosphere	Operational		GNSS radio-occultation receiver	Sounding	Constrained Access	\N	Enables measurement of water vapour and temperature profiles in the tropics.	\N	\N	\N	\N	\N	\N
715	RTER	REFIR total energy radiometer	No longer considered		Broad-band radiometer	Other	\N	\N	Study of radiation processes for climate change, study of water vapour feedback processes and gaseous forcing.	\N	\N	\N	\N	\N	MWIR - FIR: 3 - 30 µm
1509	RTT	Regenerative Transponder and Transparent	No longer considered		\N	TBD	\N	\N	Broadband communication satellite for institutinal services and applications.	\N	\N	Fixed Spot on Italy and France territories plus 7 stearable spots	\N	\N	EHF and Ka
978	S&R	Search and Rescue	No longer considered	High Heritage - Non-Operational	Communications system	TBD	Open Access	\N	For emergency calls.	\N	\N	\N	\N	\N	\N
1706	RRI	Radio Receiver Instrument	Operational		Space environment monitor	Other	Open Access	\N	The RRI measures wave electric fields in the 10Hz - 18MHz range, at magnitudes from 1 µV/m to 1 V/m to study the morphology and dynamics of ionospheric density structures, auroral wave-particle interactions, plasma nonlinear processes created by intense high frequency waves, and the mechanism of coherent wave backscatter.	N/A	\N	N/A	\N	\N	N/A
136	S&R (GOES)	Search and Rescue	Operational	High Heritage - Operational	Communications system	Sounding	\N	\N	Satellite and ground based system to detect and locate aviators, mariners, and land-based users in distress.	\N	\N	\N	\N	\N	\N
766	RRA	Retroreflector Array	Operational		Laser retroreflector	Other	Open Access	\N	Satellite laser ranging for geodynamic measurements.	\N	\N	\N	\N	\N	\N
958	ROSA	Radio Occultation Sounder for the Atmosphere	No longer operational		GNSS radio-occultation receiver	Sounding	Constrained Access	RINEX	Climate change studies. High-vertical resolution temperature-humidity sounding for NWP. Space weather.	300 km (horizontal),\n0.5 km (vertical).	\N	N/A (occultation); about 600 soundings/day.	\N	Bending angle: 0.5 µ rad	Around 1600 MHz (L1) and 1200 MHz (L2).
1628	RO	RO	Being developed		GNSS radio-occultation receiver	Sounding	\N	\N	GNSS receiver for atmospheric temperature and humidity profile sounding.	<1.5 km	\N	Altitude range of 0 - 30 km	\N	Temperature sounding better 1 K rms	L-Band 1575.42, 1176.45, 1176.45 MHz
194	RM-08	Scanning Microwave Radiometer	No longer operational		Multi-purpose imaging MW radiometer	Imaging	\N	\N	Passive microwave images of ocean surface and ice sheets.	15 km	\N	550 km	\N	3 K temperature sensitivity	Microwave: 0.8 cm
899	ROSA	Radio Occultation Sounder for the Atmosphere	Operational		GNSS radio-occultation receiver	Sounding	Constrained Access	RINEX	Climate change studies. High-vertical resolution temperature-humidity sounding for NWP. Space weather.	300 km (horizontal),\n0.5 km (vertical).	\N	N/A (occultation); about 300 soundings/day.	\N	Bending angle: 0.5 µ rad	Around 1600 MHz (L1) and 1200 MHz (L2).
193	RLSBO	Side looking microwave radar	No longer operational		Imaging radar (SAR)	Sounding	\N	\N	Images of ocean surface and ice sheets.	1.3 x 2.5 km or 1.3 x 2.8 km	\N	450 km	\N	\N	Microwave: 3.0 cm
89	RIS	Retroreflector in Space	No longer operational		Laser retroreflector	Sounding	\N	\N	Retro-reflector In Space. Laser beam absorption experiment-ground station points laser at platform and measures returned signal.	\N	\N	\N	\N	\N	VIS (~0.40 µm - ~0.75 µm)
210	RMK-2	Radiation Measurement Complex	No longer operational		Space environment monitor	Sounding	\N	\N	Data on electron and proton fluxes.	\N	\N	\N	\N	\N	\N
227	RMS	Radiation measurement system	No longer operational		Space environment monitor	Sounding	\N	\N	Measures flux of charged particles and EM radiation, and Earth's magnetic field.	\N	\N	\N	\N	\N	\N
783	RIMS-M	Mass-spectrometer	No longer considered		Space environment monitor	Other	\N	\N	Ion composition in upper atmosphere.	\N	\N	\N	\N	\N	1-4 a.e.m., 5-20 a.e.m
1744	RF Beacon	Radio Frequency Beacon	Being developed		Space environment monitor	\N	\N	\N	Transmitter that enables ground‐based measurement of ionospheric scintillation and ionospheric total electron content (TEC). Critical to understanding the impacts of space weather on satellite communication systems and GPS.	\N	\N	\N	\N	\N	\N
716	REI	REFIR Embedded Imager	No longer considered		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Study of radiation processes for climate change, study of water vapour feedback processes and gaseous forcing.	\N	\N	\N	\N	\N	TIR: 10.5 - 12.5 µm
837	RDSA	Multispectral Imager	No longer operational	Medium Heritage	High resolution optical imager	Imaging	\N	\N	Multispectral Earth surface monitoring.	20/40 m	20m	160/890 km	890 km	\N	VIS - NIR: 0.54 - 0.59 µm, 0.63 - 0.68 µm, 0.79 - 0.9 µm
839	RCHA	RCHA	No longer operational		\N	TBD	\N	\N		\N	\N	\N	\N	\N	50 kHz -15 MHz
1716	RBI	Radiation Budget Instrument	Being developed		Broad-band radiometer	Other	Open Access	CCSDS packets	Long term measurement of the Earth's radiation budget and atmospheric radiation from the top of the atmosphere to the surface; provision of an accurate and self-consistent cloud and radiation database.	38 km	\N	Limb to Limb	\N	0.5%, 1%, 0.5% (respectively for the 3 channels)	3 channels: 0.3-100 µm, 0.3 - 5µm, 5- 50 µm
717	RFTS	REFIR  Fourier Transform Spectrometer	No longer considered		Medium-resolution IR spectrometer	Other	\N	\N	Study of radiation processes for climate change, study of water vapour feedback processes and gaseous forcing.	\N	\N	\N	\N	\N	TIR - FIR: 9 - 100 µm
1738	RapidScat	Rapid Scatterometer	Operational		Radar scatterometer	Imaging	Open Access	\N	The RapidScat instrument replaced NASA's QuikScat Earth satellite. The instrument is currently on board the International Space Station and measures Earth's ocean surface wind speed and direction.	790 – 730  m (altitude dependent)	730m	900 – 1100 km (altitude dependent)	1100 km	\N	Microwave: 13.4 GHz
840	RBE	RBE	No longer operational		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	150 MHz, 400 MHz
968	RADIOMETRO	Scanning Radiometer	No longer considered	High Heritage - Operational	Multi-purpose imaging MW radiometer	Imaging	Open Access	\N	Precipitation estimation.	26 / 15 / 10 / 6	\N	1000 km	\N	\N	18-20 GHz, 21-24 GHz, 35-37 GHz, 85-89 GHz
995	Rain Radar	Rain Radar	No longer considered		Cloud and precipitation radar	TBD	\N	\N	Technology development for atmospheric profiles.	\N	\N	\N	\N	\N	\N
1640	RaBIT	Radio Beacon for Ionospheric Tomography	No longer operational		Space environment monitor	Other	Constrained Access	\N	Total Electron Content of atmospheric flux & study structure and dynamics of equatorial ionosphere.	\N	\N	\N	\N	\N	66.7 cm, 200 cm (RF)
967	RAD	Microwave radiometer	Operational		Multi-purpose imaging MW radiometer	Other	\N	\N	Ocean wind and temperature measurements.	100 km, 62 km, 36 km, 30 km, 18 km	\N	1600 km	\N	1 K	6.6 GHz, 10.7 GHz, 18.7 GHz,  23.8 GHz,  37.0 GHz
912	RASAT VIS Panchromatic	RASAR VIS Panchromatic camera	Operational	Low Heritage	High resolution optical imager	Imaging	Open Access	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	7.5 m	7.5m	30 km	30 km	\N	0.42 - 0.73 µm
913	RASAT VIS Multispectral	RASAT VIS Multispectral camera	Operational	Low Heritage	High resolution optical imager	Imaging	Open Access	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	15 m	15m	30 km	30 km	\N	Band 1: 0.42 - 0.55 µm, Band 2: 0.55 - 0.63 µm, Band 3: 0.58 - 0.73 µm
293	ERS Comms	Communication package for ERS	No longer operational		\N	Sounding	\N	\N	Communication package onboard ERS series satellites.	\N	\N	\N	\N	\N	\N
379	RA-2	Radar Altimeter - 2	No longer operational		Radar altimeter	Imaging	Open Access	\N	Measures wind speed, significant wave height, sea surface elevation, ice profile, land and ice topography, and sea ice boundaries.	\N	\N	\N	\N	Altitude: better than 4.5 cm, Wave height: better than 5% or 0.25 m	Microwave: 13.575 GHz (Ku-Band) and 3.2 GHz (S-Band)
245	R-400	R-400	No longer operational		Non-scanning MW radiometer	Sounding	\N	\N	Data of use for investigations of ocean-atmosphere system. Measures sea surface temperature, wind speed, precipitable water content of clouds, cloud liquid water content and rain rate.	\N	\N	\N	\N	\N	\N
198	R-225	Single channel microwave radiometer	No longer operational		Non-scanning MW radiometer	Sounding	\N	\N	Passive microwave measurements for investigations of ocean-atmosphere system.	\N	\N	\N	\N	\N	\N
378	RA	Radar Altimeter	No longer operational		Radar altimeter	Imaging	Open Access	\N	Measures wind speed, significant wave height, sea surface elevation, ice profile, land and ice topography,and sea ice boundaries.	Footprint is 16 - 20 km	\N	\N	\N	Wave height: 0.5 m or 10% (whichever is smaller) Sea surface elevation: better than 10 cm	Microwave: Ku-band: 13.8 GHz
834	PSS	Panchromatic imaging system	Operational	Medium Heritage	High resolution optical imager	Imaging	Constrained Access	\N	Panchromatic data for environmental monitoring, agriculture and forestry.	2.5 m	2.5m	23 km	1020 km	\N	0.54 - 0.86 µm
197	R-600	Single channel microwave radiometer	No longer operational		Non-scanning MW radiometer	Sounding	\N	\N	Single channel microwave radiometer.	\N	\N	\N	\N	\N	\N
1516	PRISM-2 (ALOS-3)	Panchromatic Remote-sensing Instrument for Stereo Mapping-2	No longer considered		High resolution optical imager	Imaging	No Access	CEOS superstructure and GeoTiFF	Stereo imaging with high resolution and wide swath by panchromatic band for disaster monitoring, global mapping and so on. Instrument was considered as a part of ALOS-3.	GSD : 0.8m(nadir)	\N	50km	\N	\N	VIS - NIR: 0.52-0.77 µm
836	PSA	Panchromatic imaging system	No longer operational	Medium Heritage	High resolution optical imager	Imaging	\N	\N	Earth surface monitoring.	8 m	8m	90/780 km	780 km	\N	VIS - NIR: 0.51 - 0.85 µm
443	PRISM	Panchromatic Remote-sensing Instrument for Stereo Mapping	No longer operational	Medium Heritage	High resolution optical imager	Imaging	\N	\N	High resolution panchromatic stereo imager for land applications which include cartography, digital terrain models, civil planning, agriculture and forestry.	2.5 m	2.5m	35 km (triplet stereo observations), 70 km (nadir observations+35 km backward)	70 km	Surface Resolution:2.5 m\nRadiometric: 3%RMS	VIS - NIR: 0.52 - 0.77 µm (panchromatic)
1723	Poseidon-4 Altimeter	Poseidon-4 SAR Radar Altimeter	Being developed		Radar altimeter	\N	Open Access	\N		\N	\N	\N	\N	\N	Microwave: Ku-band (13.575 GHz), C-band (5.3 GHz)
762	PREMOS	PREcision Monitoring of Solar Variability	No longer operational		Solar irradiance monitor	Other	\N	\N	Solar UV and visible flux in selected wavelength bands.	\N	\N	\N	\N	\N	UV: 230 nm, 311 nm, 402 nm; VIS: 548 nm
286	Priroda-5	Priroda-5	No longer considered		High resolution optical imager	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
1761	PR	Precipitation Radar	Proposed	Low Heritage	Cloud and precipitation radar	\N	\N	\N	Precipitation radar.	\N	\N	\N	\N	\N	\N
1633	POSEIDON-3B Altimeter	Positioning Ocean Solid Earth Ice Dynamics Orbiting Navigator (Single frequency solid state radar altimeter)	Operational		Radar altimeter	Sounding	Open Access	\N	Nadir viewing sounding radar for provision of real-time high precision sea surface topography, ocean circulation and wave height data.	Basic measurement: 1/sec (6 km along track), Raw measurement: 20/sec (300 m along track)	\N	On baseline TOPEX/POSEIDON orbit (10 day cycle): 300 km between tracks at equator	\N	Sea level: 3.4 cm, Significant wave height: 0.4 m, Horizontal sea surface wind speed: 1.5 m/s	Microwave: Ku-band (13.575 GHz), C-band (5.3 GHz)
337	PR	Precipitation Radar	No longer operational	Low Heritage	Cloud and precipitation radar	Other	Open Access	HDF-EOS(HDF4)	Measures precipitation rate in tropical latitudes.	Range resolution: 250 m Horizontal resolution: 4.3 km at nadir (post-boost: 5 km)	\N	215 km (post-boost: 245 km) Observable range: from surface to approx 15 km altitude	\N	Rainfall rate 0.7 mm/h at storm top	Microwave: 13.796 GHz and 13.802 GHz
829	POSEIDON-3	Positioning Ocean Solid Earth Ice Dynamics Orbiting Navigator (Single frequency solid state radar altimeter)	Operational		Radar altimeter	Sounding	Open Access	NetCDF	Nadir viewing sounding radar for provision of real-time high precision sea surface topography, ocean circulation and wave height data.	Basic measurement: 1/sec (6 km along track), Raw measurement: 10/sec (600 m along track)	\N	On baseline TOPEX/POSEIDON orbit (10 day cycle): 300 km between tracks at equator	\N	Sea level: 3.9 cm, Significant wave height: 0.5 m, Horizontal sea surface wind speed: 2 m/s	Microwave: Ku-band (13.575 GHz), C-band (5.3 GHz)
751	POLDER-P	POLarization and Directionality of the Earth's Reflectances (PARASOL version)	No longer operational		Multi-channel/direction/polarisation radiometer	Other	\N	\N	Measures polarisation, and directional and spectral characteristics of the solar light reflected by aerosols, clouds, oceans and land surfaces.	5.5 x 5.5 km	\N	1600 km	\N	Radiation budget, land surface, Reflectance: 2%	VIS - NIR: 0.490 µm, 0.670 µm and 0.865 µm at 3 polarisations, and 0.49 µm, 0.565 µm, 0.763 µm, 0.765 µm, 0.91 µm, and 1.02 µm with no polarisation
898	POAM	Polar Ozone and Aerosol Measurement	No longer considered		Limb-scanning SW spectrometer	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
930	PMR	Passive Microwave Radiometer	No longer considered		Medium-resolution IR spectrometer	Imaging	Constrained Access	\N	Mainly for ocean biology and sea state applications including SWH, geoid etc., establishment of global databases, meteorological applications .	20 km, 17 km, 10 km	\N	1500 km	\N	\N	18 GHz, 21 GHz, 37 GHz
1661	Polarimeter	Polarimeter	Proposed		\N	\N	\N	\N		\N	\N	\N	\N	\N	\N
18	POSEIDON-1 (SSALT-1)	Positioning Ocean Solid Earth Ice Dynamics Orbiting Navigator  (Single frequency solid state radar altimeter)	No longer operational		Radar altimeter	Sounding	\N	\N	Nadir viewing sounding radar for provision of real-time high precision sea surface topography, ocean circulation and wave height data.	Typical: 5 - 11 km	\N	\N	\N	\N	KU-Band (13.575 GHz)
793	POLDER-2	POLarization and Directionality of the Earth's Reflectances	No longer operational		Multi-channel/direction/polarisation radiometer	Imaging	\N	\N	Measures polarization, and directional and spectral characteristics of the solar light reflected by aerosols, clouds, oceans and land surfaces.	6 x 7 km	\N	2400 (across track) x 1800 km (along track)	\N	Radiation budget, land surface, Reflectance: 2%	VIS - NIR: 0.443 µm, 0.670 µm and 0.865 µm at 3 polarisations; and 0.443 µm, 0.49 µm, 0.565 µm, 0.763 µm, 0.765 µm and 0.91 µm with no polarisation
390	POLDER	POLarization and Directionality of the Earth's Reflectances	No longer operational		Multi-channel/direction/polarisation radiometer	Imaging	\N	\N	Measures polarization, and directional and spectral characteristics of the solar light reflected by aerosols, clouds, oceans and land surfaces.	6 x 7 km	\N	2400 (across track) x 1800 km (along track)	\N	Radiation budget, land surface, Reflectance: 2%	VIS - NIR: 0.443 µm, 0.670 µm and 0.865 µm at 3 polarisations, and 0.443 µm, 0.49 µm, 0.565 µm, 0.763 µm, 0.765 µm and 0.91 µm with no polarisation
1659	PAN (ZY-1-02C)	Panchromatic and multispectral imager	Operational		High resolution optical imager	Imaging	Very Constrained Access	\N	Earth resources, environmental monitoring, land use	5 m panchromatic and 10 m multispectral	5m	60 km	60 km	\N	0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm, 0.51 - 0.85 µm
1610	PAN (IRS-1A)	PAN Fore and Aft	No longer considered		High resolution optical imager	Imaging	\N	\N		1.25 m	\N	60 km	\N	\N	Panchromatic VIS: 0.5 - 0.75 µm
171	BSS & FSS transponders	BSS & FSS transponders	No longer considered		\N	Sounding	\N	\N	Data collection and communication.	\N	\N	\N	\N	\N	\N
182	POSEIDON-2 (SSALT-2)	Positioning Ocean Solid Earth Ice Dynamics Orbiting Navigator  (Single frequency solid state radar altimeter)	No longer operational		Radar altimeter	Sounding	\N	NetCDF	Nadir viewing sounding radar for provision of real-time high precision sea surface topography, ocean circulation and wave height data.	Basic measurement: 1/sec (6 km along track), Raw measurement: 10/sec (600 m along track)	\N	On baseline TOPEX/POSEIDON orbit (10 day cycle): 300 km between tracks at equator	\N	Sea level: 3.9 cm, Significant waveheight: 0.5 m, Horizontal sea surface wind speed: 2 m/s	Microwave: Ku-band (13.575 GHz), C-band (5.3 GHz)
646	Plasma-Mag	Plasma-Mag	No longer considered		Space environment monitor	Imaging	\N	\N	Sun-viewing instrument to measure the solar wind and magnetic field parameters. Also serves as early-warning for solar-event storms that could damage satellites and equipment on Earth.	\N	\N	\N	\N	\N	\N
283	Pheniks	Pheniks	No longer considered		\N	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
712	PFS	Planetary Fourier Spectrometer	No longer considered		\N	Other	\N	\N	Atmospheric physics, radiative properties, climate change.	\N	\N	\N	\N	\N	NIR - FIR: 1.2 - 45 µm
1649	PHA	Pulse Height Analyzer	Operational		Space environment monitor	\N	\N	\N		\N	\N	\N	\N	\N	\N
707	PDA	Particle Detector Analyser	No longer considered		Space environment monitor	Other	\N	\N	Study of perturbations in the atmosphere and ionosphere caused by electromagnetic waves, shorterm earthquake prediction.	\N	\N	\N	\N	\N	\N
100	PEM	Particle Environment Monitor	No longer operational		Space environment monitor	Sounding	\N	\N	PEM measures UV and charged particle energy inputs: determines type, amount, energy and distribution of charged particles injected into Earth's thermosphere, mesosphere and stratosphere.	\N	\N	\N	\N	\N	\N
1650	Plasma-Mag	Plasma-Mag	Operational		Magnetometer	\N	Open Access	\N	Magnetometer and plasma sensor to measure solar wind properties for forecasting geomagnetic storms. The Plasma-mag instrument comprises a Faraday Cup (measures solar wind) \nand a Fluxgate Magnetometer, as well as two space weather instruments: the \nElectron Spectrometer and the Pulse Height Analyzer.	\N	\N	\N	\N	\N	\N
1517	PCWMP	PCW Meteorological Payload (1 on each PCW S/C)	Proposed	Medium Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	NetCDF or HDF	Continuous high-temporal resolution measurements of atmospheric properties over the Arctic. Associated observations, using additional instruments include in situ space weather and also broadband radiometry of Earth.	Band dependent, varies from 0.5 km GSD (goal) for some of the VNIR bands to 2 km GSD for TIR bands.	500m	Field of Regard for each full acquisition is the entire Earth disc	\N	Cal/Val requirements currently being developed	Multiple bands, non-continuous, from 0.45 µm - 14.5 µm
1722	P-Band SAR	P-Band Synthetic Aperture Radar	Being developed		Imaging radar (SAR)	Imaging	\N	\N	Forest biomass monitoring	Strip mode: 9 m, Interferometric wide swath mode: 20 m, extra-wide swath mode: 50 m, wave mode: 50 m	9m	Strip mode: 80 km; Interferometric wide swath mode: 250 km, extra-wide swath mode: 400 km, Wave mode: sampled images of 20 x 20 km at 100 km intervals	400 km	NESZ: -22 dB; PTAR: -25 dB; DTAR: -22 dB; Radiometric accuracy 1 dB (3 sigma); Radiometric stability: 0.5 dB (3 sigma)	P-band: 435 MHz; four polarization channels - HH, HV, VH, and VV - together with height measurements from polarimetric interferometry; incidence angles ranging from 23 to 31 degrees
1514	Paz SAR-X	X Band Synthetic Aperture Radar	Being developed	High Heritage - Operational	Imaging radar (SAR)	Imaging	Constrained Access	\N	High resolution X-band radar for security, land use, urban management, environmental monitoring, risk management. Different acquisition modes: Spotlight (5 x 5-10 km SSD =<1 m), Scansar (100 x 100 km, SSD <=15 m); Stripmode (strips of 30 x 30 km with SSD 3 m).	Resolution will move between <1 x 1 m and 6 x 18m depending on acquisition modes.	1m	Swath will vary according to the acquisition mode: 5x5 km to 100 km x 100 km.	100 km	Pixel Localization: Pixel Localization: 50 cm to 8.5 m (1s) depending of the product selected.	The Radar will use a frequency close to 9.65 GHz with an BW of 300 MHz.
1601	PCW PHEOS - Atmospheric	Polar Highly Elliptical Orbit Science Weather, Climate & Air Quality Mission	Proposed		High-resolution nadir-scanning IR spectrometer	Imaging	Open Access	NetCDF or HDF	Complement PCW operational numerical weather prediction. Will also collect information about atmospheric gaseous and aerosol composition to better understand transport and climate processes.\n.	10 x 10 km	\N	Field of View is 560 x 560km. Field of Regard is 3024 x 3530 km.	\N	Cal/Val requirements currently being developed	4 non-continuous bands from 0.758 - 14.3 um at a spectral sampling of 0.25 cm-1.
802	Panchromatic imager (RASA)	Panchromatic imager (RASA)	No longer considered		High resolution optical imager	Imaging	\N	\N	Panchromatic data for Earth resources, agriculture and forestry, water resources and vegetation studies.	\N	\N	\N	\N	\N	\N
962	Panchromatic High Sensitivity Camera	Panchromatic High Sensitivity Camera	No longer considered		High resolution optical imager	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1600	PCW PHEOS - Solar-Terrestrial	Polar Highly Elliptical Orbit Science, Solar-Terrestrial Mission	Proposed		Space environment monitor	Imaging	Open Access	Not decided at this stage.	Combination of payloads to study the near-Earth space dominated by plasmas and to observe the electromagnetic and charged particle environments in a highly elliptical orbit. May potentially include both in-situ space weather instruments and an Auroral imager.	40 km for the Auroral imager. Not applicable for the in-situ space weather instruments.	\N	Field of Regard for each full acquisition is the entire Earth disc. N.A. for the in-situ space weather instruments.	\N	Cal/Val requirements currently being developed	Dual band LBH long (160 - 175 nm) and LBH short (140 - 160 nm) for the Auroral imager. N.A. for the in-situ space weather instruments.
613	Panchromatic imager	Panchromatic imager	Prototype		High resolution optical imager	Imaging	\N	\N	Panchromatic data for Earth resources, agriculture and forestry, water resources and vegetation studies.	\N	\N	\N	\N	\N	\N
914	PAN+MS (RGB+NIR)	Ingenio PAN+MS (RGB+NIR)	Being developed	Medium Heritage	High resolution optical imager	Imaging	Constrained Access	\N	High resolution multi–spectral land optical images for applications in cartography, land use, urban management, water management, agriculture and environmental monitoring, risk management and security.	PAN: 2.5 m, MS: 10 m	2.5m	Swath will move between 55 and 60 km depending on latitude.	60 km	SNR: 100 in PAN and 120 in MS. The geo-location accuracy of level 1c PAN data product shall be better than or equal to 2.5 m RMS 2D in nadir view.	VIS+NIR band: 520 - 670 nm, 410 - 480 nm, 520 - 580 nm, 610 - 670 nm, 790 - 880 nm
700	PAN MUX	Panchromatic and multispectral imager	No longer considered		High resolution optical imager	Imaging	\N	\N	Measurements of cloud type and extent and land surface reflectance, and used for global land surface applications.	5 m panchromatic and 10 m multispectral	\N	60 km	\N	\N	VIS: 0.52 - 0.59 µm, 0.63 - 0.69 µm; NIR: 0.77 - 0.89 µm; PAN: 0.51 - 0.85 µm
1592	PAN CAM	Panchromatic Camera	No longer considered		High resolution optical imager	Imaging	Constrained Access	\N	Panchromatic data.	2 m	2m	10 km	10 km	-	400 - 900 nm
446	PAN (IRS-1C/1D)	Panchromatic sensor	No longer operational		High resolution optical imager	Imaging	\N	\N	High resolution stereo images for study of topography, urban areas, development of DTM, run-off models etc. Urban sprawl, forest cover/timber volume, land use change.	5.8 m	5.8m	70 km at nadir	70 km	\N	Panchromatic VIS: 0.5 - 0.75 µm
832	PAN CAMERA	Panchromatic Camera	Approved		High resolution optical imager	Imaging	Constrained Access	HDF	Panchromatic data.	5 m	5m	30 km	30 km	-	VIS: 400 - 700 nm
857	PAN (GISTDA)	Panchromatic imager	Operational	Low Heritage	High resolution optical imager	Imaging	Constrained Access	DIMAP	THEOS PAN is an optical instrument with resolution 2 m and swath width at 22 km. It can be used in several applications such as cartography, land use planning and management, national security, etc.	2 m	2m	22 km	22 km	GSD for PAN = 2 m +/- 10%\nMTF for PAN > 0.10	0.45 - 0.90 µm
1675	PAN (SJ-9A)	Panchromatic and multispectral imager	Operational		High resolution optical imager	Imaging	Open Access	\N		2.5 m	2.5m	30 km	30 km	\N	0.45 - 0.89 µm
917	PAN (Cartosat-3)	Panchromatic sensor	Being developed		High resolution optical imager	Imaging	Very Constrained Access	\N	High resolution images for study of topography, urban areas, development of DTM, run-off models etc. Urban sprawl, forest cover/timber volume, land use change.	0.25 m	0.25m	16 km	15 km	\N	Panchromatic VIS: 0.5 - 0.75 µm
867	PAN (CBERS)	Panchromatic and Multispectral Imager	Operational	Low Heritage	High resolution optical imager	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use, urban studies.	5 m panchromatic and 10 m multispectral	5m	60 km	60 km	\N	0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm, 0.51 - 0.85 µm
436	PAN (Cartosat-2)	Panchromatic Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	\N	High resolution stereo images for large scale (better than 1:0000) mapping applications, urban applications, GIS ingest.	1 m	1m	10 km	10 km	\N	VIS: 0.5 - 0.75 µm
1647	PAN (Cartosat-2E)	Panchromatic Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	\N	High resolution stereo images for large scale (better than 1:0000) mapping applications, urban applications, GIS ingest.	0.65 m	0.65m	10 km	10 km	\N	VIS: 0.5 - 0.75 µm
796	PAN (Cartosat-1)	Panchromatic Camera	Operational		High resolution optical imager	Imaging	Constrained Access	\N	High resolution stereo images for study of topography, urban areas, development of DTM, run-off models etc. Urban sprawl, forest cover/timber volume, land use change.	2.5 m	2.5m	30 km	30 km	\N	Panchromatic VIS: 0.5 - 0.75 µm
1728	PAN (GF-1)	Panchromatic and multispectral imager	Operational		High resolution optical imager	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use, urban studies.	5 m panchromatic and 10 m multispectral	5m	70km	70 km	\N	0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm, 0.51 - 0.85 µm
1586	PAN (Cartosat-2A/2B)	Panchromatic Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	\N	High resolution stereo images for large scale (better than 1:0000) mapping applications, urban applications, GIS ingest.	1 m	1m	10 km	10 km	\N	VIS: 0.5 - 0.75 µm
989	Overhauser Magnetometer	OM	Operational		Magnetometer	TBD	Open Access	\N	Measurements of the strength of the Earth's magnetic field.	\N	\N	\N	\N	\N	\N
1747	PAN (BJ-2)	Panchromatic Imager	Operational		High resolution optical imager	Imaging	\N	\N	SSTL-300 S1 Imager also known as VHRI 100 (Very High Resolution Imager 100).	1 metre ground sampling distance	1m	23.4 km	23 km	\N	450-650 nm
845	Pamela	Pamela	No longer operational	Low Heritage	Space environment monitor	TBD	Constrained Access	\N	Cosmic ray research.	\N	\N	\N	\N	\N	\N
364	PALSAR	Phased Array type L-band Synthetic Aperture Radar	No longer operational	Medium Heritage	Imaging radar (SAR)	Imaging	Open Access	CEOS	High resolution microwave imaging of land and ice for use in environmental monitoring, agriculture and forestry, disaster monitoring, Earth resource management and interferometry.	(depending on looks, incident angle and bandwidth) Hi-res: 7 - 44 m or 14 - 88 m, ScanSAR mode: 35 - 77 m or 70 - 154 m, Polarimetry: 24 - 88 m	7m	High resolution mode: 70 km, Scan SAR mode: 250 - 360 km, Polarimetry: 30 km	360 km	Surface Resolution:10 m (Fine Mode); Surface Resolution:100 m (Scan Mode); Radiometric: ±1 dB	Microwave: L-Band 1270 MHz
244	Ozon-M	Ozon-M	No longer operational		High-resolution nadir-scanning SW spectrometer	Sounding	\N	\N	Multispectral UV spectrometer measurements of atmospheric turbidity and trace gas concentrations.	\N	\N	\N	\N	\N	\N
977	PAN (BJ-1)	Panchromatic Imager	No longer operational		High resolution optical imager	Imaging	\N	\N	To provide panchromatica analysis of hydrological, oceanographic, land use and meteorological parameters.	4 m	4m	24 km	24 km	100 m	500 - 800 nm
1729	PAN (GF-2)	Panchromatic and multispectral imager	Operational		High resolution optical imager	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use, urban studies.	5 m panchromatic and 10 m multispectral	5m	45km	45 km	\N	0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm, 0.51 - 0.85 µm
1589	PALSAR-2 (ALOS-2)	Phased Array type L-band Synthetic Aperture Radar-2	Operational	Medium Heritage	Imaging radar (SAR)	Imaging	Open Access	CEOS SAR and GeoTiFF	Disaster Monitoring, Land monitoring, Agricultural Monitoring, Natural Resource Exploration, Global Forest Monitoring, Potential use and interferometry.	Spotlight mode (1 to 3 m), stripmap mode (3 to 10 m).	1m	Spotlight mode: 25km, Stripmap mode: 50-70 km, Scan SAR mode: 350 - 490 km, Polarimetry: 30-50 km	490 km	Surface Resolution:  1 to 3 m (Spotlight Mode), 3m (Ultra-Fine Mode), 6m (High sensitive Mode), 10m (Fine Mode),100 m (Scan Mode); Radiometric: ±1 dB	Microwave: L-Band 1270 MHz
1718	OMPS-L	Ozone Mapping and Profiler Suite Limb Profiler	Being developed		Limb-scanning SW spectrometer	Sounding	Open Access	HDF-5	Measures total amount of ozone in the atmosphere and the ozone concentration variation with altitude.	1 km vertical	\N	3 vertical slits along track +/- 250 km	\N	Total Ozone 15 Dobson units. Profile Ozone 10% between 15 and 60 km; 20% between Tropopause and 15 km	Limb soundings UV - TIR 0.29 - 10 um
681	OMPS	Ozone Mapping and Profiler Suite	Operational	Medium Heritage	High-resolution nadir-scanning SW spectrometer	Sounding	\N	HDF-5	Measures total amount of ozone in the atmosphere and the ozone concentration variation with altitude.	Mapper: 50 km, Profiler: 250 km, Limb: 1 km vertical	\N	Mapper: 2800 km, Profiler: 250 km, Limb: 3 vertical slits along track +/- 250 km	\N	Total Ozone 15 Dobson units. Profile Ozone 10% between 15 and 60 km; 20% between Tropopause and 15 km	Nadir Mapper: UV 0.3 - 0.38 µm, Nadir profiler: UV 0.25 - 0.31 µm, Limb soundings: UV - TIR 0.29 - 10 µm
1623	OMS	Ozone Monitoring Suite	TBD		\N	\N	Constrained Access	\N	Ozone total column vertical profile measurements.	\N	\N	\N	\N	\N	\N
734	OSMI	Ocean Scanning Multispectral Imager	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Ocean colour measurements for biological oceanography.	1 km	\N	800 km	\N	\N	VIS: 0.412 µm, 0.443 µm, 0.490 µm, 0.555 µm; NIR: 0.765 µm, 0.865 µm
437	OPUS	Ozone and Pollution Measuring Ultraviolet Spectrometer	No longer considered		\N	Imaging	\N	\N	Primary objective of measuring global total column ozone on a daily basis. Also measures volcanic SO2, aerosols, NO2,HCHO,BrO and stratospheric OClO, plus cloud top heights.	20 km	\N	2500 km	\N	Total ozone 5% nominal (2% after cal-val with a precision of 2%).	UV - VIS: 0.306 - 0.420 µm (228 channels - with a resolution of 0.5 - 0.7 nm)
686	OP	Ozone Profiler	No longer considered		\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
336	OPS	Optical Sensor	No longer operational		High resolution optical imager	Imaging	Open Access	\N	High resolution multi-spectral imager for land applications which include environmental monitoring, agriculture and forestry, disaster monitoring.	"18.3m (range) × 24.2m (azimuth)	\N	75 km	\N	\N	VIS: 0.42 - 0.50 µm, 0.52 - 0.60 µm, 0.61 - 0.69 µm, NIR: 0.76 - 0.89 µm
662	OSIRIS	Optical Spectrograph and Infra-Red Imaging System	Operational		Limb-scanning SW spectrometer	Sounding	Open Access	HDF-EOS	Detects aerosol layers and abundance of species such as O3, NO2, OClO, BrO and NO. Consists of spectrograph and IR imager.	Spectrograph 1 km at limb, Imager 1 km in vertical	\N	N/A, but measures in the altitude range 5 - 100 km	\N	Depends on species. Ozone meets requirements for trend analysis	Spectrograph: UV - NIR: 0.28 - 0.80 µm; IR Imager: NIR: 1.26 µm, 1.27 µm, 1.52 µm
1769	OLI-2	Operational Land Imager-2	Being developed		High resolution optical imager	Imaging	Open Access	\N	Measures surface radiance, land cover state and change (e.g., vegetation type). Used as multi-purpose imagery for land applications.	Pan: 15 m, VIS - SWIR: 30 m	15m	185 km	185 km	Absolute geodetic accuracy of 32 m; relative geodetic accuracy of 18 m (excluding terrain effects); geometric accuracy of 12 m or better	VIS - SWIR: 9 bands: 0.43 - 2.3 µm
450	OLS	Operational Linescan System	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Day and night cloud cover imagery.	0.56 km (fine), 5.4 km (stereo products)	560m	3000 km	\N	\N	VIS - NIR: 0.4 - 1.1 µm, TIR: 10.0 - 13.4 µm, and 0.47 - 0.95 µm
1754	OEK VR	Multispectral optoelectronic high resolution module	Approved		High resolution optical imager	Imaging	Constrained Access	\N	Multispectral images of land surfaces and Oceans.	panchromatic band - 0.4 m\nmultispectral bands - 1.6 m	0.4m	19 km	19 km	\N	1 panchromatic band (0.5 - 0.8 µm).\n8 multispectral bands (0.40 - 0.45 µm, 0.45 - 0.51 µm, 0.51 - 0.58 µm, 0.58 - 0.62 µm, 0.63 - 0.69 µm, 0.70 - 0.74 µm, 0.77 - 0.89 µm, 0.86 - 1.05 µm).
791	OEK DZZ WR	High resolution electron-High resolution electron-optical complex for Earth remote sensing	No longer considered		High resolution optical imager	Other	\N	\N	Research of Earth natural resources, cartography.	Panchromatic band 1.0 m, Narrow spectral bands 2.0 m; Swath: 30 km	\N	30 km	\N	\N	PAN (VIS - NIR) 0.45 - 0.9 µm; Narrow bands: VIS: 0.43 - 0.47 µm, 0.51 - 0.59 µm, 0.61 - 0.69 µm; VIS - NIR: 0.7 - 0.8 µm; NIR: 0.8 - 0.9 µm, 0.8 - 1.1 µm
630	OMI	Ozone Measuring Instrument	Operational		High-resolution nadir-scanning SW spectrometer	Sounding	\N	HDF-EOS	Mapping of ozone columns, key air quality components (NO2, SO2, BrO, OClO and aerosols), measurements of cloud pressure and coverage, global distribution and trends in UV-B radiation.	13 x 24 km or 36 x 48 km depending on the product. Also has zoom modes (13 x 13 km) for example for urban pollution detection	\N	2600 km	\N	\N	UV: 270 - 314 nm and 306 - 380 nm, VIS: 350 - 500 nm
896	OLCI	Ocean and Land Colour Imager	Operational		Medium-resolution spectro-radiometer	Imaging	Open Access	\N	Marine and land services.	300 m	300m	1270 km, across-track tilt 12.2 deg to the West	1270 km	2% abs, 0.1% rel.	21 bands in VNIR/SWIR
1560	OEA	Optical Electronic Apparatus	No longer operational		High resolution optical imager	TBD	Very Constrained Access	\N		\N	\N	\N	\N	\N	\N
897	OLI	Operational Land Imager	Operational	High Heritage - Operational	High resolution optical imager	Imaging	Open Access	\N	Measures surface radiance, land cover state and change (eg vegetation type). Used as multi-purpose imagery for land applications.	Pan: 15 m, VIS - SWIR: 30 m	15m	185 km	185 km	Absolute geodetic accuracy of 32 m; relative geodetic accuracy of 18 m (excluding terrain effects); geometric accuracy of 12 m or better	VIS - SWIR: 9 bands: 0.43 - 2.3 µm
359	OCTS	Ocean Color and Temperature Scanner	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	OCTS is an optical radiometer to achieve highly sensitive spectral measurement with 12 bands covering visible and thermal infrared region. In the visible and near-infrared bands, the ocean conditions are observed by taking advantage of spectral reflectance of the dissolved substances in the water and phytoplankton.	\N	\N	\N	\N	\N	VIS (~0.40 µm - ~0.75 µm)
838	NVK	Low-frequency wave complex	No longer operational		Magnetometer	TBD	\N	\N		\N	\N	\N	\N	\N	1 Hz - 25 kHz
850	OEA	Optical-electronic equipment	No longer operational		High resolution optical imager	TBD	\N	\N		50m	\N	100 km	\N	\N	0.5 - 0.9 µm
425	NSCAT	NASA Scatterometer	No longer operational		Radar scatterometer	Imaging	\N	\N	Lost power on-orbit in 1997.	\N	\N	\N	\N	\N	\N
1527	Occultation GNSS Receiver (CLARREO)	Occultation GNSS Receiver (CLARREO)	No longer considered	Medium Heritage	GNSS receiver	Sounding	Open Access	\N	Independent measurements of atmospheric temperature, pressure, and humidity using Global Positioning System (GPS) occultation measurements of atmospheric refraction.	Spectral resolution in the UV, VIS, and near IR of 15 nm; in the IR of 1cm-1	\N	VIS: 1km IFOV over 100km swath; 100km FOV	100 km	.1K	IR:200 - 2000 cm-1; UV,VIS, and near IR: 380 to 2500 nm
935	OCM (Oceansat-3)	Ocean Colour Monitor (Oceansat-3)	Proposed		Medium-resolution spectro-radiometer	Imaging	Open Access	\N	Ocean colour data, Estimation of phytoplankton concentration, identification of potential fishing zones, assessment of primary productivity.	360m	\N	1400 km	1400 km	\N	13 channel
1597	OCI	Ocean Color Instrument	Being developed		Medium-resolution spectro-radiometer	Imaging	Open Access	CCSDS packets	Ocean colour spectrometer for measuring ocean leaving light which contains information on biological components.	1 km	\N	2500 km swath	\N	\N	UV-NIR (350 - 800 nm); SWIR (940, 1240, 1378, 1640, 2130 and 2250 nm)
464	OCM (Oceansat-2)	Ocean Colour Monitor (Oceansat-2)	Operational		Medium-resolution spectro-radiometer	Imaging	Open Access	\N	Ocean colour data, Estimation of phytoplankton concentration, identification of potential fishing zones, assessment of primary productivity.	236 x 360m	236m	1400 km	1400 km	\N	VIS - NIR: 0.40 - 0.88 µm (8 channels)
1638	NIR-SWIR	Multi-spectral Optical Camera - Near & Short Wave Infrared	Approved		High-resolution nadir-scanning IR spectrometer	Imaging	\N	\N	Ocean Colour - Open ocean, coastal & in-land waters. Atmospheric corrections	400m	400m	1400 km	1400 km	\N	Near & Short Wave Infrared, 6 bands: 750 - 765 - 865 -1044 - 1240 - 1640 nm
1595	NigeriaSat X Remote Sensing (Medium Resolution)	NigeriaSat X Remote Sensing (Medium Resolution)	Operational		High resolution optical imager	Imaging	\N	\N	High resolution images for monitoring of land surface and coastal  processes and for agricultural, geological and hydrological applications.	22 m multispectral (red, green and NIR)	22m	600 x 600 km	600 km	150 - 300 m	NIR: ~0.75 - ~1.3 µm, VIS: ~0.40 - ~0.75 µm
561	NOAA Comms	Communications package for NOAA	Operational	High Heritage - Operational	\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
916	NigeriaSat 2 Remote Sensing (Med and High Res)	NigeriaSat 2 Remote Sensing (Med and High Res)	Operational		High resolution optical imager	Imaging	\N	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	2.5 PAN, 5 m multispectral (red blue green,NIR), 32 m multispectral (red, green, NIR)	2.5m	20 x 20 km , 300 x 300 km	300 km	35 - 45 m	NIR: ~0.75 - ~1.3 µm, VIS: ~0.40 - ~0.75 µm
812	NIRST	New Infrared Sensor Technology	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	HDF-5/Geotif	NIRST (two linear microbolometric arrays, respectively sensitive to the TIR bands). It measures the characteristics of high temperature events on land (fires & volcanoes) and sea surface temperatures on selected targets.	Space resol: 450 m (at nadir)	450m	Instant: 182 km; Extended: 1000 km	1000 km	\N	• Band 1:  3.4-4.2 um\n• Band 2:  10.4-11.3 um\n• Band 3:  11.4-12.3 um
1710	NMS	Neutral Mass Spectrometer	Operational		Space environment monitor	Other	Open Access	\N	The Neutral Mass and velocity Spectrometer (NMS) measures mass composition and velocity of neutral atmospheric species in the 1-40 amu mass and 0.1-2 km/s velocity range.	N/A	\N	N/A	\N	\N	N/A
647	NISTAR	NIST Advanced Radiometer	Operational		Solar irradiance monitor	Other	Open Access	\N	Measure the energy emitted and reflected by the Earth.	\N	\N	\N	\N	0.1% accuracy; 0.03% precision	0.2 - 100 µm in 4 channels
915	NigeriaSat Medium Resolution	NigeriaSat Remote Sensing (medium resolution)	No longer operational		High resolution optical imager	Imaging	\N	\N	Medium resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	32 m multispectral (red, green, NIR)	32m	600 x 600 km	600 km	150 - 300 m	NIR: ~0.75 - ~1.3 µm, VIS: ~0.40 - ~0.75 µm
1663	MWS	Microwave Sounder	Being developed		Absorption-band MW radiometer/spectrometer	Sounding	\N	NetCDF-4	All-weather night-day temperature sounding	Footprint size 17 - 80 km (Threshhold)	\N	\N	\N	\N	25 channels from 23.8 to 229 GHz
1531	Next Gen APS (ACE)	Next Gen APS (ACE)	Proposed	Medium Heritage	Multi-channel/direction/polarisation radiometer	Imaging	Open Access	\N	Polarimeter for measuring aerosol optical properties and aerosol types.	\N	\N	\N	\N	\N	\N
672	MWRI	MicroWave Radiation Imager	Operational		Multi-purpose imaging MW radiometer	Imaging	Constrained Access	L-1 data: HDF 5.0	All weather observations of precipitation, cloud features, vegetation, soil moisture sea ice, etc.	7.5 x 12 km at 150 GHz to 51 x 85 km at 10.65 GHz	\N	1400 km	\N	\N	12 channels, 6 frequencies: 10.65 GHz, 18.7 GHz, 23.8 GHz, 36.5 GHz, 89 GHz, 150 GHz
925	MxT	Multi-spectral CCD Camera	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Natural resources management.	37 m	37m	151 km	151 km	\N	VIS: Band 1: 0.45 - 0.52 µm, Band 2: 0.52 - 0.59 µm, Band 3: 0.62 - 0.68 µm, NIR: Band 4: 0.77 - 0.86 µm
895	MWTS	Microwave Temperature Sounder	Operational		Absorption-band MW radiometer/spectrometer	Sounding	Open Access	L-1 data: HDF 5.0	Temperature sounding in nearly all weather conditions.	62 km	\N	750 - 1125 km	\N	50 - 75 km	50.3 GHz, 53.6 GHz, 54.94 GHz, 57.29 GHz
1611	MX (Cartosat-3)	Multispectral VNIR	Proposed		High resolution optical imager	Imaging	Very Constrained Access	\N		1 m	1m	16 km	16 km	\N	VNIR Multispectral
1622	MWTS-2	Improved Microwave Temperature Sounder	No longer operational		Absorption-band MW radiometer/spectrometer	\N	Open Access	\N	Temperature sounding in nearly all weather conditions. Failed in February 2015.	\N	\N	\N	\N	\N	\N
222	MZOAS	Scanning microwave radiometer	No longer considered		Multi-purpose imaging MW radiometer	Sounding	\N	\N	Measures effective temperature and liquid water content of ocean surface, cloud and snow.	160 km, 80 km, 40 km, 36 km , 22 km , 9 km respectively	\N	1500 km	\N	Temparature: 0.05 K	Microwave: 6 GHz, 11 GHz, 19 GHz, 22 GHz, 35 GHz, 94 GHz (10 channels)
1629	MWI-Precip	MWI-Precip	No longer considered		Multi-purpose imaging MW radiometer	\N	\N	\N	Instrument TBC.	\N	\N	\N	\N	\N	\N
1621	MWHS-2	Improved MicroWave Humidity Sounder	Operational		Absorption-band MW radiometer/spectrometer	\N	Open Access	\N	Meteorological applications.	\N	\N	\N	\N	\N	\N
185	MWR	Microwave Radiometer	No longer operational		Non-scanning MW radiometer	Sounding	Open Access	\N	To provide multispectral analysis of hydrological, oceanographic, land use and meteorological parameters.  Global imager & SST. Ocean colour.	20 km	\N	20 km	\N	Temperature: 2.6 K	Microwave: 23.8 GHz and 36.5 GHz
1668	MWI	Microwave Instrument	Being developed		Satellite-to-satellite ranging system	\N	\N	\N		\N	\N	\N	\N	\N	\N
262	MWR-2	Microwave Radiometer-2	No longer considered		Non-scanning MW radiometer	Sounding	\N	\N	To provide multispectral analysis of hydrological, oceanographic, land use and meteorological parameters.  Global imager & SST. Ocean colour.	\N	\N	\N	\N	\N	\N
1630	MWI	Microwave Imager	Being developed		Multi-purpose imaging MW radiometer	Imaging	\N	NetCDF-4	Measure cloud liquid water, ice cloud content, precipitation, total column water vapour, snow parameters, sea ice parameters	\N	\N	\N	\N	\N	Microwave: 18 channels between 18.7 GHz to 183 GHz
803	MWR	MicroWave Radiometer	No longer operational		Multi-purpose imaging MW radiometer	Other	Constrained Access	HDF-5	Precipitation rate, wind speed, sea ice concentration, water vapour, clouds liquid water.	<54 km	\N	380 km	\N	.1 K	(Ka & K Band) 23.8 GHz V Pol and 36.5 GHz H and V Pol Eight beams per frequency
667	MWAS	MicroWave Atmospheric Sounder	Operational		Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	Meteorological applications.	\N	\N	\N	\N	\N	Microwave: 19.35 - 89.0 GHz (8 channels)
13	MVISR (5 channels)	Multispectral Visible and Infra-red Scan Radiometer (5 channels)	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	To provide multispectral analysis of hydrological, oceanographic, land use and meteorological parameters.  Global imager & SST. Ocean colour.	\N	\N	\N	\N	\N	\N
274	MVZA	MVZA	No longer considered		Multi-purpose imaging MW radiometer	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
671	MVIRS	Moderate Resolution Visible and Infrared Imaging Spectroradiometer	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Measures surface temperature and cloud and ice cover. Used for snow and flood monitoring and surface temperature.	\N	\N	\N	\N	\N	VIS - TIR: 0.47 - 12.5 µm (20 channels)
1775	MWIR (GF-4)	Medium Wavelength Infrared Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Infrared measurements for environmental and natural disaster monitoring.	400m	400m	400km	400 km	\N	3.5 - 4.1 µm
669	MWHS	MicroWave Humidity Sounder	Operational		Absorption-band MW radiometer/spectrometer	Sounding	Open Access	L-1 data: HDF 5.0	Meteorological applications.	15 km at media, 41 x 27 km at outer edge	\N	2700 km	\N	15 km	Microwave: 19.35 - 89.0 GHz (8 channels)
394	MVIRI	METEOSAT Visible and Infra-Red Imager	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Measures cloud cover, motion, height, upper tropospheric humidity and sea surface temperature.	Visible: 2.5 km, Water vapour: 5 km (after processing), TIR: 5 km	2500m	Full Earth disk in all three channels, every 30 minutes	\N	Cloud top height: 0.5 km, Cloud top/ sea surface temperature: 0.7 K, Cloud cover 15%	VIS - NIR: 0.5 - 0.9 µm, TIR: 5.7 - 7.1 µm (water vapour), 10.5 - 12.5 µm
180	MVISR (10 channels)	Multispectral Visible and Infra-red Scan Radiometer (10 channels)	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	To provide multispectral analysis of hydrological, oceanographic, land use and meteorological parameters.  Global imager & SST. Ocean colour.	1.1 km	1100m	3200 km	3200 km	1.1 km	10 channels: VIS: 0.43 - 0.48 µm, 0.48 - 0.53 µm, 0.53 - 0.58 µm, 0.58 - 0.68 µm, NIR: 0.84 - 0.89 µm, NIR - SWIR: 0.90 - 0.965µm, 1.58 - 1.68 µm, 3.55 - 3.93 µm, TIR: 10.3 - 11.3 µm, 11.5 - 12.5 µm
1774	MUX (ZY-3-02)	Multispectral CCD Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	GEOTIFF	Earth resources, environmental monitoring, land use.	6 m	6m	50 km	50 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
1726	MUX (GF-1)	Multispectral CCD Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	GEOTIFF	Earth resources, environmental monitoring, land use.	6 m	6m	70km	70 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
1540	Multi-spectral thermal infrared imager (HyspIRI)	Multi-spectral thermal infrared imager (HyspIRI)	Proposed	Medium Heritage	Medium-resolution IR spectrometer	Imaging	Open Access	\N	Ecosystem focused mission with measurements of surface and cloud imaging with high spatial resolution, stereoscopic observation of local topography, cloud heights, volcanic plumes, and generation of local surface digital elevation maps, surface temperature and emissivity.	60 m at nadir; 1 week revisit time	60m	600 km	600 km	0.1 K,	3-5 µm, 7.5-12 µm
1731	MUX (CBERS-4A)	Multispectral CCD Camera	Proposed		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GEOTIFF	Agriculture; Forestry; Geology; Natural disaster management; Cartography; Environment monitoring; Fire detection, localization and counting; Hydrology, coastal water mapping; Land use; Surveillance and law enforcement	16  m	\N	90 km	90 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
818	MUX	Multispectral CCD Camera	Operational	Medium Heritage	High resolution optical imager	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use.	20 m	20m	120 km	120 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
1658	MUX (ZY-3-01)	Multispectral CCD Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	GEOTIFF	Earth resources, environmental monitoring, land use.	6 m	6m	52 km	52 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
1727	MUX (GF-2)	Multispectral CCD Camera	Operational		High resolution optical imager	Imaging	Very Constrained Access	GEOTIFF	Earth resources, environmental monitoring, land use.	6 m	6m	45km	45 km	\N	0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, 0.77 - 0.89 µm
1532	Multi-band UV/VIS Spectrometer (ACE)	Multi-band UV/VIS Spectrometer (ACE)	Proposed	Medium Heritage	High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	\N	Ocean colour spectrometer for measuring ocean leaving light which contains information on biological components.	\N	\N	\N	\N	\N	\N
563	MTSAT Comms	Communications package for MTSAT	Operational	High Heritage - Operational	Communications system	Other	Very Constrained Access	\N		\N	\N	\N	\N	\N	\N
792	Multispectral high resolution scanner	\N	No longer considered		High resolution optical imager	Other	\N	\N	Research of Earth natural resources, cartography.	Panchromatic band 1.8 m, Narrow spectral bands 3.5 – 4.5 m	\N	48.5 km	\N	\N	VIS - NIR: 0.5 - 0.6 µm, 0.6 - 0.7 µm, 0.7 - 0.8 µm, 0.58 - 0.8 µm
1525	Multi-beam LIDAR (Desdyni)	Multi-beam LIDAR (Desdyni)	No longer considered	Low Heritage	Lidar altimeter	Other	Open Access	\N	Accurately measures the distance between canopy top and bottom elevation, the size distribution of vegetation components within the vertical distribution.	25m spatial resolution; 1m vertical resolution	\N	25m footprint, 30m spacing	\N	10 tc/ha	\N
674	MTVZA-OK	Scanning microwave radiometer	No longer operational		Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	Multi-spectral scanner images of Earth Surface.	Microwave: 12 x 200 km Visible:1.1 or 4.0 km IR:1.1 or 4.0 km	\N	2000 km	\N	\N	Microwave: 6.9 (V,H), 10.6 (V,H), 18.7 (V,H), 23.8 (V), 31.5 (V,H), 36.7 (V,H), 42 (V,H), 48 (V,H), 52.3-57.0 (V,H), 91 (V,H), 183.31 GHz; VIS: 0.37 - 0.45 µm, 0.45 - 0.51 µm, 0.58 - 0.68 µm, 0.68 - 0.78 µm;  IR: 10.4 - 11.5 µm, 11.5 - 12.6 µm
673	MTVZA	Scanning microwave imager-sounder	Operational	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	Constrained Access	\N	Atmospheric temperature and humidity profiles, precipitation, sea-level wind speed, snow/ice coverage.	10000 - 100000 m	10000m	1500 km	1500 km	\N	18.7 - 183.3 GHz, 26 channels
1500	MTSAT DCS	Data Collection System for MTSAT	Operational	High Heritage - Operational	Data collection system	Other	Constrained Access	\N		\N	\N	\N	\N	\N	\N
196	MSU-V	Multispectral high resolution conical scanner	No longer operational		High resolution optical imager	Sounding	\N	\N	Multispectral high resolution conical scanner with 8 bands.	\N	\N	\N	\N	\N	\N
570	MSU-UM	Visible Multi-Spectral Radiometer	No longer considered		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N		\N	\N	\N	\N	\N	VIS - NIR: 0.52 - 0.90 µm (3 channels)
779	MSU-MR	Low-resolution multispectral scanning imager-radiometer	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Parameters of clouds, snow, ice and land cover, vegetation, surface temperature, fire detection.	1000 m	1000m	2800 km	2800 km	\N	0.5 - 0.7 µm; 0.7 - 1.1 µm;1.6 - 1.8 µm; 3.5 - 4.1 µm; 10.5 - 11.5 µm, 11.5 - 12.5 µm
191	MSU-M	Multi-Spectral Low Resolution Scanning System	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	Provide images of ocean surface and ice sheets.	1.5 x 1.8 km	\N	1930 km	\N	\N	VIS: 0.5 - 0.6 µm, 0.6 - 0.7 µm NIR: 0.7 - 0.8 µm, 0.8 - 1.1 µm
195	MSU-SK	Multispectral medium resolution conical scanner	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	Multispectral scanner images of land surface and ice cover.	\N	\N	\N	\N	\N	\N
777	MSU-SM	Multi-Spectral Medium Resolution Scanning System	No longer operational		Multi-purpose imaging Vis/IR radiometer	Other	\N	\N	Images of clouds, snow, ice and land cover.	225 m	\N	2250 km	\N	\N	Visible: 0.5 - 0.7 µm; NIR: 0.7 - 1.1 µm
852	MSU-O	Ocean colour scanner	Being developed	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Ocean colour data, estimation of phytoplankton concentration.	1 km	1000m	1800 km	3000 km	TBD	0.405 - 0.875 µm, 13 channels
192	MSU-S	Multi-Spectral Medium Resolution Scanning System	No longer operational		High resolution optical imager	Sounding	\N	\N	Multispectral scanner images of ocean surface and ice sheets.	350 m	\N	1300 km	\N	\N	VIS: 0.6 - 0.7 um, NIR: 0.8 - 1.1 um
1692	MSU-IK-SR	Multi-channel medium and far IR range radiometer	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Parameters of clouds, snow, ice and land cover, vegetation, surface temperature, fire detection.	200 m	130m	2000 km	2000 km	\N	3.5-4.1 µm; 8.1-9.1 µm
229	MSU-E1	Multispectral high resolution electronic scanner	No longer operational		High resolution optical imager	Sounding	\N	\N	Multispectral scanner images of land surface and ice cover.	25 m	\N	45 km for one scanner, 80 km for two scanners (pointable ±30 deg from nadir)	\N	\N	VIS: 0.5 - 0.6 µm, 0.6 - 0.7 µm, NIR: 0.8 - 0.9 µm
784	MSU-GS	Multispectral scanning imager-radiometer	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Measurements of cloud cover, cloud top height, precipitation, cloud motion, albedo, vegetation, convection, air mass analysis, tropopause monitoring, stability monitoring, total ozone and surface temperature, fire detection.	1000 m; 4000 m	1000m	Full Earth disk	\N	\N	0.5 - 0.65 µm; 0.65 - 0.8 µm; 0.8-0.9 µm; 3.5 - 4.01 µm; 5.7 - 7.0 µm; 7.5-8.5 µm; 8.2-9.2 µm; 9.2-10.2 µm; 10.2 - 11.2 µm, 11.2 - 12.5 µm
1691	MSU-GS/VE	Multispectral scanning imager-radiometer	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Operational metrology, hydrology, climate monitoring and environmental monitoring	1000 m; 4001 m	1000m	Full Earth disk	\N	\N	0.5 - 0.65 µm; 0.65 - 0.8 µm; 0.8-0.9 µm; 3.5 - 4.01 µm; 5.7 - 7.0 µm; 7.5-8.5 µm; 8.2-9.2 µm; 9.2-10.2 µm; 10.2 - 11.2 µm, 11.2 - 12.5 µm
980	MSU-200	Multispectral high resolution scanner (VIS)	No longer considered	Medium Heritage	High resolution optical imager	Imaging	Very Constrained Access	\N	Multispectral images of land & sea surfaces and ice cover.	25 m	25m	250 km	250 km	\N	0.54 - 0.86 µm
228	MSU-E	Multispectral high resolution electronic scanner	No longer operational		High resolution optical imager	Sounding	\N	\N	Multispectral scanner images of land surface and ice cover.	35 - 45 m	\N	45 km for one scanner, 80 km for two scanners (pointable ±30 deg from nadir)	\N	\N	VIS: 0.5 - 0.6 µm, 0.6 - 0.7 µm, NIR: 0.8 - 0.9 µm
567	MSU-EU	Multi-Spectral Radiometer with High Resolution	No longer operational		High resolution optical imager	Imaging	\N	\N	Multispectral scanner images of land surface.	Visible: 24 x 34 m	\N	48 km or 105km; pointable ±30° from nadir	\N	\N	VIS: 0.5 - 0.6 µm, 0.6 - 0.7 µm (scanning radiometer), NIR: 0.8 - 0.9 µm
243	MSU-E2	Multispectral high resolution electronic scanner	No longer operational		High resolution optical imager	Sounding	\N	\N	Multispectral scanner images of land surface and ice cover.	\N	\N	\N	\N	\N	\N
328	MSU	Microwave Sounding Unit	No longer operational		Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	Temperature sounding through cloud up to 20 km in altitude.	\N	\N	\N	\N	\N	\N
848	MSTE-5E	Multichannel system of geoactive measurements	No longer operational		Space environment monitor	Other	\N	\N	Geoactive Emission Measurements.	\N	\N	\N	\N	\N	Ions energetic spectrum: 0.1 – 15 keV, 3 channels, Energy of electrons: 0.05 – 20 keV and more than 40 keV, 4 channels
835	MSS	Multispectral imaging system	Operational	Medium Heritage	High resolution optical imager	Imaging	Constrained Access	\N	Multispectral images of land & sea surfaces and ice cover.	12 m	12m	20 km	20 km	\N	0.46 - 0.51 µm; 0.51 - 0.6 µm; 0.63 - 0.69 µm; 0.75 - 0.84 µm
80	MSR	Microwave Scanning Radiometer	No longer operational		Multi-purpose imaging MW radiometer	Imaging	\N	\N	Passive microwave radiometer to measure ocean and atmosphere.	32km (23.8GHz), 23km (31.4GHz)	\N	370km	\N	\N	Microwave: 23.8GHz, 31.4GHz
794	MSS (Sich)	Multispectral Scanner	No longer operational		High resolution optical imager	Imaging	Open Access	\N	Multispectral scanner images of land surface.	8.2 m	8.2m	46.6 km pointable ±35° from nadir	46 km	8 bits	VIS - NIR: 0.51 - 0.90 µm; VIS: 0.51 - 0.59 µm, 0.61 - 0.68 µm; NIR: 0.80 - 0.89 µm
110	LIS	Lightning Imaging Sensor	Being developed		Lightning imager	Sounding	Open Access	HDF	Global distribution and variability of total lightning. Data can be related to rainfall to study hydrological cycle.	4 km	\N	FOV: 80 x 80 deg	\N	90% day and night detection probability	NIR: 0.7774 µm
465	MSMR	Multifrequency Scanning Microwave Radiometer	No longer operational		Multi-purpose imaging MW radiometer	Imaging	Open Access	\N	Sea surface temperature, ocean surface winds, cloud liquid water, precipitation over ocean.	40 m at 21 GHz to 120 m at 6.6 GHz, Wind speed: 75 x 75 km, Sea surface temparature: 146 x 150 km	40m	1360 km	1360 km	Sea surface temparature: 1.5 K, Sea surface wind speed: 1.5 m/s	Microwave: 6.6 GHz, 10.6 GHz, 18 GHz and 21 GHz
940	MSI (Sentinel-2)	Multi-Spectral Instrument (Sentinel-2)	Operational		High resolution optical imager	Imaging	Open Access	\N	Optical high spatial resolution imagery over land and coastal areas for GMES operational services.	10 m for 4 bands in VNIR, 60 m for 3 dedicated atmospheric correction bands, 20 m for remaining bands	10m	290 km	290 km	Absolute radiometric accuracy for Level 1C data: 3 - 5%	13 bands in the VNIR-SWIR
326	MSS (Landsat)	Multispectral Scanner	No longer operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Measures surface radiance. Data mostly used for land applications.	VIS-NIR: 80 m	80m	185 km	185 km	\N	VIS - NIR: 4 bands: 0.5 - 1.1 µm
938	MSI (EarthCARE)	Multi-Spectral Imager (EarthCARE)	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF5	Observation of cloud properties and aerosol (aerosols to be confirmed).	500 x 500 m	500m	150 km swatch with, asymmetrically; 35 km to 115 km versus nadir point	150 km	\N	VIS - NIR: Band1: VIS, 670 nm, Band2: NIR, 865 nm, Band3: SWIR-1, 1.67 µm, Band4: SWIR-2, 2.21 µm, Thermal Infrared: Band5: 8.8 µm, Band6: 10.8µm, Band7: 12.0 µm
296	MSG Comms	Communications package for MSG	Operational		Communications system	Other	Open Access	\N	Communication package onboard MSG series satellites.	\N	\N	\N	\N	\N	\N
831	MSI	Multi Spectral Imager	Operational	High Heritage - Operational	High resolution optical imager	Imaging	Open Access	\N	High resolution images with short observing cycle for commercial and scientific applications.	6.5 m	6.5m	78 km	78 km	2 - 3%	4 VIS + 1 NIR band: 440 - 510 nm, 520 - 590 nm, 630 - 690 nm, 690 - 730 nm, 760 - 880 nm
780	MSGI-MKA	Spectrometer	No longer considered		Space environment monitor	Other	\N	\N	Geoactive corpuscular emissions measurements.	\N	\N	\N	\N	\N	\N
976	MSI (BJ-1)	Multispectral Imager	No longer operational		High resolution optical imager	Imaging	\N	\N	To provide multispectral analysis of hydrological, oceanographic, land use and meteorological parameters.	32 m	32m	600 km	600 km	800 m	Green 520 - 600 nm; Red 630 - 690 nm; NIR 760 - 900 nm
735	MSC	Multi-Spectral Camera	Operational	High Heritage - Operational	High resolution optical imager	Imaging	Very Constrained Access	GEOTIF	High resolution imager for land applications of cartography and disaster monitoring.	Pan: 1 m; VIS-NIR: 4 m	1m	15 km	15 km	\N	Panchromatic VIS: 0.50 - 0.90 µm, VIS: 0.45 - 0.52 µm, 0.52 - 0.60 µm, 0.63 - 0.69 µm, NIR: 0.76 - 0.90 µm
1748	MSI (BJ-2)	Multispectral Imager	Operational		High resolution optical imager	Imaging	\N	\N	SSTL-300 S1 Imager also known as VHRI 100 (Very High Resolution Imager 100).	4 metre ground sampling distance	4m	23.4 km	23 km	\N	600-670 nm (red)\n510-590 nm (green)\n440-510 nm (blue)\n760-910 nm (NIR)
776	MSGI-5EI	Multichannel System for Geoactive Emission Measurements	No longer operational		Space environment monitor	Other	\N	\N	Geoactive Emission Measurements.	\N	\N	\N	\N	\N	Ions energetic spectrum: 0.1 – 15 keV, 3 channels, Energy of electrons: 0.05 – 20 keV and more than 40 keV, 4 channels
1690	MSA (2)	Multispectral imaging equipment	No longer considered		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Land surface and ocean monitoring	5 m; 10 m; 21 m	5m	120 km	120 km	\N	0.5-0.8 µm; 0.44-0.51 µm; 0.52-0.59 µm; 0.63-0.68 µm; 0.69-0.73 µm; 0.76-0.85 µm; 0.85-1 µm; 1.55-1.7 µm
872	MPS	Magnetospheric Particle Sensor	No longer considered		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	\N
217	MR-2000M1	Scanning visible radiometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	TV camera images of cloud, snow and ice.	1.5 km	\N	3100 km	\N	\N	VIS - NIR: 0.5 - 0.8 µm
216	MR-900B	Scanning visual band telephotometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	TV camera images of cloud, snow and ice.	2 x 1 km	\N	2600 km	\N	\N	VIS - NIR: 0.5 - 0.8 µm
462	MOS	Modular Opto-electronic Scanner	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Data for spectral analysis of O2 absorption in the NIR band, vegetation indices, and vegetion condition and soil assessment.	1570 m, 525 m, 645 m	\N	200 km (approximately)	\N	Radiometric:<1%	NIR: 755 - 768 nm (4 bands), VIS - NIR: 408 - 1010 nm (13 bands), SWIR: 1600 nm
209	MR-2000	MR-2000	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	TV camera images of cloud, snow and ice.	\N	\N	\N	\N	\N	\N
208	MR-900	Scanning telephotometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	TV camera images of cloud, snow and ice.	1.6 - 1.8 km	\N	\N	\N	\N	\N
858	MS (GISTDA)	Multi spectral imager	Operational	Low Heritage	High resolution optical imager	Imaging	Constrained Access	DIMAP	THEOS MS consists of 4 spectral bands (R,G,B, NIR) with resolution 15 m and swath width at 90 km. The applications which are suitable for this instrument such as cartography, land use, land cover change management, agricultural and natural resources management, etc.	15 m	15m	90 km	90 km	GSD for MS = 15 m +/- 10%\nMTF for MS > 0.12 in each band	0.45 - 0.52 µm, 0.53 - 0.60 µm, 0.62 - 0.69 µm, 0.77 - 0.90 µm
1689	MSA (1)	Multispectral imaging equipment	Proposed		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Land surface and ocean monitoring	7 m;14 m	7m	85 km	85 km	\N	0.5-0.8 µm; 0.44-0.51 µm; 0.52-0.59 µm; 0.63-0.68 µm; 0.69-0.73 µm; 0.76-0.85 µm; 0.85-1 µm; 1.55-1.7 µm
119	MOPITT	Measurements Of Pollution In The Troposphere	Operational		High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	HDF4	Measurements of CO in the troposphere.	CO profile: 4 km vertical, 22 x 22 km horizontal, CO, CH4 column: 22 x 22 km horizontal	\N	616 km	\N	Carbon monoxide (4 km layers): 10%	SWIR-MWIR: 2.3 µm, 2.4 µm and 4.7 µm
1700	m-NLP	multi-Needle Langmuir Probe	Proposed		Space environment monitor	\N	\N	\N	m-NLP will measure the plasma around the Earth at a higher resolution than other Langmuir probe instruments that have been flown in space.	\N	\N	\N	\N	\N	\N
353	MLS	Microwave Limb Sounder (UARS)	No longer operational		Limb-scanning MW spectrometer	Sounding	\N	\N	Data on emissions of chlorine monoxide, water vapour and ozone. Data also used for determination of atmospheric pressure and temperatures as a function of altitude from observations of molecular oxygen emissions.	\N	\N	\N	\N	\N	\N
395	MODIS	MODerate-Resolution Imaging Spectroradiometer	Operational		Medium-resolution spectro-radiometer	Imaging	Open Access	HDF-EOS	Data on biological and physical processes on the surface of the Earth and in the lower atmosphere, and on global dynamics. Surface temperatures of land and ocean, chlorophyll fluorescence, land cover measurements, cloud cover (day and night).	Cloud cover: 250 m (day) and 1000 m (night), Surface temperature: 1000 m	250m	2330 km	2330 km	Long wave radiance: 100 nW/m2, Short wave radiance: 5%, Surface temperature of land: <1 K, Surface temperature of ocean: <0.2 K, Snow and ice cover: 10%	VIS - TIR: 36 bands in range 0.4 - 14.4 µm
722	MMRS	Multispectral Medium Resolution Scanner	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	Fast format	Applications related to agriculture, environment, forestry, hydrology, oceanography, mineralogy and geology, desertification, contamination and protection of ecosystems.	175 m	175m	360 km	360 km	\N	VIS - NIR - SWIR: 480 - 500 nm, 540 - 560 nm, 630 - 690 nm, 795 - 835 nm, SWIR: 1550 - 1700 nm
1773	LISS-V	Linear Imaging Self Scanner-V	Being developed		High resolution optical imager	Imaging	Constrained Access	\N	Vegetation monitoring, improved crop discrimination, crop yield, disaster monitoring and rapid assessment of natural resources.	2.5	\N	\N	\N	\N	VIS: Band 2: 0.45 - 0.52 µm, Band 2: 0.52 - 0.59 µm, Band 3: 0.62 - 0.68 µm, NIR: Band 4: 0.77 - 0.86 µm
126	MLS (EOS-Aura)	Microwave Limb Sounder (EOS-Aura)	Operational		Limb-scanning MW spectrometer	Sounding	Open Access	HDF-EOS	Measures lower stratospheric temperature and concentration of H2O, O3, ClO, HCl, OH, HNO3, N2O and SO2.	3 x 300 km horizontal x 1.2 km vertical	\N	Limb scan 2.5 - 62.5 km Limb to limb	62 km	Temperature: 4 K, Ozone: 50%	Microwave: 118 GHz, 190 GHz, 240 GHz, 640 GHz and 2.5 THz
807	MOC	Multi-spectral Optical Camera	No longer considered	Low Heritage	High resolution optical imager	Other	\N	\N	Sea and coastal studies.	\N	\N	\N	\N	\N	Optical and Thermal Infrared Cameras, up to 15 bands
725	MMP	Magnetic Mapping Payload	No longer operational		Magnetometer	Other	Constrained Access	\N	Measurement of the Earth’s magnetic field with a vector and a scalar magnetometer.	\N	\N	\N	\N	\N	\N
233	MK-4M	MK-4M	No longer operational		High resolution optical imager	Sounding	\N	\N	Photography of land and ocean surfaces in 4 spectral channels.	6 m at an altitude of 240 km, film type 92, 9 m at an altitude of 240 km, film type SN-18	\N	0.6 of the orbit altitude	\N	\N	VIS - NIR: 0.52 - 0.56 µm, 0.61 - 0.76 µm, 0.64 - 0.69 µm, 0.81 - 0.87 µm
1741	MIRIS	Multi-purpose IR Imaging System	Operational		Space environment monitor	\N	Open Access	\N	Mapping of the Galactic plane and measurement of large angular fluctuations of cosmic near infrared background radiation. Not an EO payload.	\N	\N	\N	\N	\N	0.9 - 2.0µm, 3 - 5µm
689	MIRAS (SMOS)	Microwave Imaging Radiometer using Aperture Synthesis (MIRAS)	Operational		Multi-purpose imaging MW radiometer	Imaging	Open Access	\N	Objective is to demonstrate observations of sea surface salinity and soil moisture in support of climate, meteorology, hydrology, and oceanography applications.	33 - 50 km depending on the position in the swath - resampled to 15 km grid	\N	Hexagon shape, nominal width 1050 km allowing a 3 day revisit time at the equator	\N	2.6 K absolute accuracy, RMS 1.6-4 K depending on the scene and the position within the swath	L-Band 1.41 GHz
396	MISR	Multi-angle Imaging SpectroRadiometer	Operational		Multi-channel/direction/polarisation radiometer	Imaging	Open Access	HDF-EOS	Measurements of global surface albedo, aerosol and vegetation properties. Also provides multi-angle bidirectional data (1% angle-to-angle accuracy) for cloud cover and reflectances at the surface and aerosol opacities. Global and local modes.	275 m, 550 m or 1.1 km, Summation modes available on selected cameras/bands: 1 x 1, 2 x 2, 4 x 4, 1 x 4. 1 pixel = 275 x 275 m	275m	380 km common overlap of all 9 cameras	380 km	0.03% hemispherical albedo, 10% aerosol opacity, 1-2% angle to angle accuracy in bidirectional reflectance	VIS: 0.44 µm, 0.56 µm, 0.67 µm, NIR: 0.86 µm
223	MIVZA-M	Microwave scanning radiometer	No longer operational		Multi-purpose imaging MW radiometer	Sounding	\N	\N	Microwave radiometer for temparature sounding of atmosphere.	\N	\N	\N	\N	\N	\N
795	MIRS	Middle IR Scanner	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Scanner images of land surface in middle infra-red range.	41.4 m	41.4m	55.3 km pointable ±35° from nadir	55 km	8 bits	NIR: 1.55 - 1.7 µm
232	MK-4	MK-4	No longer operational		High resolution optical imager	Sounding	\N	\N	Photography of land and ocean surfaces in 4 out of 6 channels.	10 m at an altitude of 240 km, film type 30M; 14 m at an altitude of 240 km, film type SN-10	\N	0.6 of the orbit altitude	\N	\N	VIS - NIR: 0.435 - 0.68 µm, 0.46 - 0.51 µm, 0.515 - 0.565 µm, 0.64 - 0.69 µm, 0.61 - 0.75 µm, 0.81 - 0.86 µm
215	MIVZA	Microwave scanning radiometer	No longer operational		Multi-purpose imaging MW radiometer	Sounding	\N	\N	Microwave radiometer for humidity sounding of atmosphere.	25 - 100 km	\N	1500 m	\N	\N	Microwave: 22-94 GHz, 5 channels
1709	MGF	MaGnetic Field insutrment	Operational		Magnetometer	Other	Open Access	\N	The MGF consists of dual, tri-axial fluxgate magnetometers mounted on an 80-cm carbon fibre boom for measurements of magnetic field perturbations to a precision of 0.0625 nanotesla, from which to infer small-scale field-aligned currents. The MGF is turned on an average of 20% of the time, following a schedule devised by the science team.	N/A	\N	N/A	\N	0.0625 nanotesla	N/A
338	MIPAS	Michelson Interferometric Passive Atmosphere Sounder	No longer operational		Limb-scanning IR spectrometer	Sounding	Open Access	\N	Data on stratosphere chemistry (global/polar ozone), climate research (trace gases/clouds), transport dynamics, tropospheric chemistry. Primary/secondary species: O3, NO, NO2, HNO3, N2O5, ClONO2, CH4.	Vertical resolution: 3 km, vertical scan range 5 - 150 km, Horizontal: 3 x 30 km, Spectral resolution: 0.035 lines/cm	\N	\N	\N	Radiometric precision: 685 - 970 cm-1: 1%, 2410 cm-1: 3%	MWIR-TIR: between 4.15 and 14.6 µm
996	Millimeter Wave Sounder	Millimeter Wave Sounder	No longer considered		Absorption-band MW radiometer/spectrometer	TBD	\N	\N	Technology development for atmospheric profiles.	\N	\N	\N	\N	\N	\N
1548	Microwave limb sounder (GACM)	Microwave limb sounder (GACM)	Proposed	High Heritage - Non-Operational	Limb-scanning MW spectrometer	Sounding	Open Access	\N	Limb-viewing measurements of O3, N2O, temperature, water vapour, CO, HNO3, ClO, and volcanic SO2 in the.	\N	\N	\N	\N	\N	\N
965	METimage	Multi Spectral Imager	Being developed	Medium Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Operational multi spectral imager for meteorological EPS-SG VIS/IR Imaging Mission (VII): imagery data for global and regional NWP, NWC, and climate monitoring	Sampling distance 500 m at SSP	500m	2560 km (+/-53°)	\N	\N	20 channels from VIS to TIR (0.44 to 13.5 µm)
304	MHS	Microwave Humidity Sounder	Operational		Absorption-band MW radiometer/spectrometer	Sounding	Open Access	\N	Atmospheric humidity profiles, cloud cover, cloud liquid, water content, ice boundaries and precipitation data.	Vertical: 3 - 7 km, Horizontal: 30 - 50 km	\N	1650 km	\N	Cloud water profile: 10 g/m2, specific humidity profile: 10 - 20%	Microwave: 89 GHz, 166 GHz and 3 channels near 183 GHz
670	MIRAS	Multichannel Infrared Atmospheric Sounder	Operational		Multi-purpose imaging MW radiometer	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
894	MI	Meteorological Imager	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF, LRIT, HRIT	Continuous monitoring capability for the near real-time generation of high-resolution meteorological products and long-term change analysis of sea surface temperature and cloud coverage.	VIS: 1 km, IR: 4 km	1000m	Full Earth disk	11000 km	\N	1: VIS, 0.55 - 0.80 µm; 2: SWIR: 3.50 - 4.00 µm; 3: WV (Waver Vapour): 6.50 - 7.00 µm; 4: TIR1 (Thermal Infrared 1): 10.3 - 11.3 µm, 5: TIR2 (Thermal Infrared 2): 11.5 - 12.5 µm
79	MESSR	Multispectral Electronic Self-Scanning Radiometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Medium resolution visible and thermal infrared imaging of ocean and atmosphere.	50m	\N	100km (185km for observing by two cameras)	\N	\N	VIS: 0.51-0.59μm, 0.61-0.69μm, 0.72-0.80μm, NIR: 0.80-1.10μm
1620	MERSI-2	Improved Medium Resolution Spectral Imager	Approved		Multi-purpose imaging Vis/IR radiometer	\N	Open Access	\N	Measurement of vegetation indexes and ocean colour.	\N	\N	\N	\N	\N	\N
1759	MERSI-S	Improved Medium Resolution Spectral Imager - Simplified	Proposed	Low Heritage	Multi-purpose imaging Vis/IR radiometer	\N	Open Access	\N	Measurement of vegetation indexes and ocean colour.	\N	\N	\N	\N	\N	MERSI-S is a simplified sensor, derived from MERSI but with fewer channels.
893	MERSI	Medium Resolution Spectral Imager	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	L-1 data: HDF 5.0	Measurement of vegetation indexes and ocean colour. No longer operating due to lack of power.	250 m for broadband channels, 1 km for narrowband channels	250m	2800 km	2800 km	0.25 - 1.0 km	25 channels from 0.47 - 12.0 µm
190	KONDOR-2	Data collection and transmission system	No longer operational		Data collection system	Sounding	\N	\N	Data collection and retransmission.	\N	\N	\N	\N	\N	\N
234	KFA-3000	Photographic camera	No longer operational		High resolution optical imager	Sounding	\N	\N	Photography of land and ocean surfaces for use at 1:25000 scale and below.	3 m at an altitude of 275 km	\N	0.1 of the orbit altitude	\N	\N	VIS: 0.6 - 0.7 µm
320	MERIS	Medium-Resolution Imaging Spectrometer	No longer operational		Medium-resolution spectro-radiometer	Imaging	Open Access	\N	Main objective is monitoring marine biophysical and biochemical parameters. Secondary objectives are related to atmospheric properties such as cloud and water vapour and to vegetation conditions on land surfaces.	Ocean: 1040 x 1200 m, Land & coast: 260 x 300 m	260m	1150 km, global coverage every 3 days	\N	Ocean colour bands typical S:N = 1700	VIS - NIR: 15 bands selectable across range: 0.4 - 1.05 µm (bandwidth programmable between 0.0025 and 0.03 µm)
295	Meteosat Comms	Communications package for Meteosat	Operational		Communications system	Other	Open Access	\N	Communication package onboard Meteosat series satellites.	\N	\N	\N	\N	\N	\N
428	MBLA	Multi-Beam Laser Altimeter	No longer considered		Lidar altimeter	Imaging	\N	\N	Pulsed lidar for continuous global remote sensing of tree canopy height, vertical distribution of intercepted surfaces in the canopy, and ground topography elevations.	25 m footprint diameter	\N	8 km	\N	Elevation: +/-1 m in low slope terrain, Vegetation height: +/-1 m	NIR: Nd:YAG lasers operating at 1064 nm
892	MCSI	Multiple Channel Scanning Imager	Approved		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Multipurpose visible/IR imagery and wind derivation.	1 km VIS, 2 km NIR, 4 km TIR	1000m	Full Earth disk	\N	0.5 - 4.0 km	12 channels from 0.55 - 13.8 µm
149	MAXIE	Magnetospheric Atmospheric X-ray Imaging Experiment	No longer operational		Solar irradiance monitor	Sounding	\N	\N	Magnetospheric Atmospheric X-ray Imaging Experiment. Maps the intensities and energy spectra of X-rays produced by electrons that precipitate into the atmosphere.	\N	\N	\N	\N	\N	\N
702	MAESTRO	Measurements of Aerosol Extinction in the Stratosphere and Troposphere Retrieved by Occultation	Operational		Limb-scanning SW spectrometer	Sounding	Open Access	\N	Chemical processes involved in the depletion of the ozone layer.	Approx 1 - 2 km vertical	\N	\N	\N	\N	UV - NIR: 0.285 - 1.03 µm (1 - 2 nm spectral resolution)
918	MAPI	Multi-Angle Polarisation Imager	No longer considered		Multi-channel/direction/polarisation radiometer	Other	Constrained Access	\N	Measurement of column integrated aerosol spectral optical depth .	\N	\N	\N	\N	\N	\N
919	MAVELI	Measurements of Aerosols by Viewing Earth's Limb	No longer considered		Limb-scanning SW spectrometer	Other	Constrained Access	\N	Vertical profiles of aerosols, ozone and water vapour in the free troposphere and stratosphere and cloud top height .	\N	\N	\N	\N	<1.0 K temperature, 0.2 g/kg Humidity	\N
920	MAGIS	Measurement of Atmospheric Gases using Infrared Sp	No longer considered		High-resolution nadir-scanning IR spectrometer	Other	Constrained Access	\N	To study the regional/global distribution of carbon monoxide (CO).	\N	\N	\N	\N	\N	\N
1768	MAIA	Multi-Angle Imager for Aerosols	Being developed		Multi-channel/direction/polarisation radiometer	Imaging	Open Access	HDF	A pair of pushbroom spectropolarimetric cameras on a 2-axis gimbal for multiangle viewing, frequent revisits over targets, and inflight calibration. Major metropolitan areas are sampled with sub-km spatial resolution to study impacts of different types of particulate matter on human health.	230 - 460 m (assuming 700 km orbit altitude)	230m	600 km (assuming 700 km orbit altitude)	600 km	4% (radiometric), 0.005 degree of linear polarization	367, 386, 445*, 543, 645*, 751, 763, 862*, 945, 1620*, 1888, and 2185 nm (*polarimetric)
878	Magnetometer (NOAA)	Magnetometer	Approved	High Heritage - Non-Operational	Magnetometer	TBD	\N	\N		\N	\N	\N	\N	\N	\N
368	MASTER	MASTER	No longer considered		\N	Imaging	\N	\N	Data for study of exchange mechanisms between stratosphere/troposphere, and information for studies on global change. Measures upper troposphere/ lower stratosphere profiles of O3, H2O, CO, HNO3, SO2, N2O, pressure and temperature.	3 km	\N	\N	\N	199 - 207 GHz channel: 1 K, Other channels: 1.5 K, 50 MHz resolution, 0.3 secs integration time	Microwave: 199 - 207 GHz, 296 - 306 GHz, 318 - 326 GHz, 342 - 348 GHz
653	LRIR	Limb Radiance Inversion Radiometer instrument	No longer operational		Limb-scanning IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
1501	LRIT	Low-Rate Information Transmission	Operational	High Heritage - Operational	\N	Other	\N	\N	Follow-on from the Weather Facsimile (WEFAX) Processing System.	\N	\N	\N	\N	\N	\N
1594	Mach-Zehnder Micro-interferometer	Mach-Zehnder Micro-interferometer	No longer considered		Medium-resolution IR spectrometer	Sounding	Constrained Access	\N	Spectral radiance. Detection of the atmospheric gases.	Ground Spot = 5 km	3m	5 km	5 km	average spectral resolution: 1 nm	400 - 4500 nm
865	MADRAS	Microwave Analysis and Detection of Rain and Atmospheric Structures	Operational		Multi-purpose imaging MW radiometer	Imaging	Constrained Access	\N	To estimate rainfall, atmospheric water parameters and ocean surface winds in the equatorial belt.	40 km	\N	1700 km	\N	\N	18.7 GHz, 23.8 GHz, 36.5 GHz, 89 GHz, 157 GHz
1557	LRR	Laser retro-Reflector	No longer operational	High Heritage - Operational	Laser retroreflector	TBD	\N	\N	Satellite Laser Ranging of GOCE, used for precise positioning and for geodynamics on GOCE.	\N	\N	\N	\N	\N	\N
1713	MAC	Multi-Angle Multispectral Camera	Proposed		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Ocean Colour - Multi-angle viewing for atmospheric correction purposes for both, open ocean and coastal	400m	400m	1400 km	1400 km	\N	VIS-NIR 4 bands: 490 - 555 - 710 -  865 nm
770	L-SAR	L-Band SAR	No longer considered		Imaging radar (SAR)	Imaging	\N	\N	L-Band Sar for agriculture and forestry.	5 m	\N	10 - 200 km depending on mode	\N	\N	Microwave: L-band (2 GHz)
1667	LRI	Laser Ranging Instrument	Being developed		Satellite-to-satellite ranging system	\N	\N	\N		\N	\N	\N	\N	\N	\N
1721	LRA (Sentinel-6)	Laser Retroreflector Array (Sentinel-6)	Being developed		Laser retroreflector	\N	\N	\N		\N	\N	\N	\N	\N	\N
708	LP/ RPA	Langmuir Probe and Retarding Potential Analyser	No longer considered		Space environment monitor	Other	\N	\N	Study of perturbations in the atmosphere and ionosphere caused by electromagnetic waves, shorterm earthquake prediction.	\N	\N	\N	\N	\N	\N
1510	LRA (LAGEOS)	Laser Retroreflector Array	Operational		Laser retroreflector	Other	Open Access	-	Baseline tracking data for precision geodesy. Also for calibration of radar altimeter bias. Several types used on various missions.	N/A	\N	N/A	\N	2 cm overhead ranging	VIS: 400 - 750 nm
106	LRA	Laser Retroreflector Array	Operational		Laser retroreflector	TBD	Open Access	NetCDF	Baseline tracking data for precision orbit determination and/or geodesy. Also for calibration of radar altimeter bias. Several types used on various missions. (ASI involved in LAGEOS 2 development).	\N	\N	\N	\N	2 cm overhead ranging	\N
1678	LOTUSat 1 SAR	LOTUSat 1 SAR	Proposed		Imaging radar (SAR)	\N	\N	\N	The LOTUSat 1 SAR instrument is designed for land cover measurements and applications.	\N	\N	\N	\N	\N	X-band SAR.
891	LM	Lightning Mapper	Approved		Lightning imager	Imaging	Constrained Access	\N	Lightning mapping for locating thunder storms in flooding season, CCD camera operating 0.77 µm to count flashes and intensity.	10 km	\N	Full Earth disk	\N	8 km	0.774 µm
1639	LiV HYSI	Limb Viewing Hyperspectral Imager VNIR	No longer operational		Limb-scanning SW spectrometer	Imaging	Open Access	\N	Airglow measurement of Ionosphere through 80 - 600 km.	2 km (vertical), 25 km (horizontal)	2m	512 km (vertical), 1024 km (horizontal-spectral)	512 km	\N	512 bands
1679	LOTUSat 2 SAR	LOTUSat 2 SAR	Proposed		Imaging radar (SAR)	\N	\N	\N	The LOTUSat 2 SAR instrument is designed for land cover measurements and applications.	\N	\N	\N	\N	\N	X-band SAR.
461	LISS-IV	Linear Imaging Self Scanner - IV	Operational		High resolution optical imager	Imaging	Constrained Access	\N	Vegetation monitoring, improved crop discrimination, crop yield, disaster monitoring and rapid assessment of natural resources.	5.8 m	5.8m	70 km	70 km	\N	VIS: 0.52 - 0.59 µm, 0.62 - 0.68 µm, NIR: 0.77 - 0.86 µm
969	LIS	Lightning Imager Sensor	No longer considered	Medium Heritage	Lightning imager	Imaging	Open Access	\N	Atmospheric electrical discharge imager.	3 - 6 km	\N	600 km	\N	\N	0.7774 µm
438	LISS-I	Linear imaging Self Scanner - I	No longer operational		High resolution optical imager	Imaging	\N	\N	1b Provides data for: monitoring land use/ land cover, forest cover, coastal zones and wastelands; identification of prospective ground water zones; and crop acreage and production estimation for wheat, rice, sorghum, cotton, groundnut, tobacco, etc.	72.5 m	\N	148 km	\N	\N	VIS: 0.46 - 0.52 µm, 0.52 - 0.59 µm, 0.62 - 0.68 µm, NIR: 0.77 - 0.86 µm
444	LISS-III (IRS)	Linear Imaging Self Scanner - III (IRS)	No longer operational		High resolution optical imager	Imaging	\N	\N	Data used for vegetation type assessment, resource assessment, crop stress detection, crop production forecasting, forestry, land use and land cover change.	Bands 2, 3 & 4: 23.5 m, Band 5: 70.5 m	23.5m	141 km	141 km	\N	VIS: Band 2: 0.52 - 0.59 µm, Band 3: 0.62 - 0.68 µm, NIR: Band 4: 0.77 - 0.86 µm, SWIR: Band 5: 1.55 - 1.75 µm
439	LISS-II	Linear Imaging Self Scanner - II	No longer operational		High resolution optical imager	Imaging	\N	\N	Data used for vegetation type assessment, resource assessment, crop stress detection, crop production forecasting, forestry, and for monitoring land use and land cover change.	Bands 2, 3 & 4: 23.5 m, Band 5: 70.5 m	\N	141 km	\N	\N	VIS: 0.46 - 0.52 µm, 0.52 - 0.59 µm, 0.62 - 0.68 µm, NIR: 0.77 - 0.86 µm
934	LISS-III (Resourcesat)	Linear Imaging Self Scanner - III (Resourcesat)	Operational		High resolution optical imager	Imaging	Open Access	\N	Data used for vegetation type assessment, resource assessment, crop stress detection, crop production forecasting, forestry, land use and land cover change.	23.5 m	23.5m	141 km	141 km	\N	VIS: Band 2: 0.52 - 0.59 µm, Band 3: 0.62 - 0.68 µm, NIR: Band 4: 0.77 - 0.86 µm, SWIR: Band 5: 1.55 - 1.75 µm
1533	Lidar	Lidar	Proposed	Medium Heritage	Atmospheric lidar	Sounding	Open Access	\N	Measurement of aerosol heights, cloud top heights and aerosol properties.	Vertical sampling: 30 - 60 m, -2 to 40 km	\N	333 m along-track	\N	\N	532 nm (polarization-sensitive), 1064 nm, 355 nm
654	LIMS	Limb Infrared Monitor of the Stratosphere	No longer operational		Limb-scanning IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
628	LEISA AC	LEISA Atmospheric Corrector	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	No Access	\N	Corrects high spatial resolution multispectral imager data for atmospheric effects.	250 m	250m	185 km	185 km	\N	256 bands, NIR - SWIR: 0.89 - 1.58 µm
335	L-band SAR	L-band Synthetic Apature Radar	No longer operational		Imaging radar (SAR)	Imaging	Open Access	\N	High resolution microwave imaging of land and ice for use in environmental monitoring, agriculture and forestry, disaster monitoring, Earth resource management and interferometry.	18m (range) × 18m (azimuth at 3 looks)	\N	75 km	\N	Surface Resolution: 18 m	Microwave: L-Band 1275 MHz
1526	L-band SAR (NISAR)	L-band Synthetic Aperture Radar (SAR) (NISAR)	Proposed	Low Heritage	Imaging radar (SAR)	Imaging	Open Access	TBD	3-year mission to study solid earth deformation (earthquakes, volcanoes, landslides), changes in ice (glaciers, sea ice) and changes in vegetation biomass	At 12-day repeat, global coverage, ~10m resolution	10m	240 km (12-day repeat and global coverage)	240 km	TBD	L-Band: 1215 -1300 Hz
890	LI	Lightning Imager	Being developed		Lightning imager	Imaging	Open Access	NetCDF	Real time lightning detection (cloud-to-cloud and cloud-to-ground strokes, with no discrimination between the two), lightning location.	< 10 km at 45°N	\N	Fixed view of 80% of visible earth disc, all EUMETSAT member states	\N	Detection Efficiency: 90% at 45N, SSP longitude, 70% on average over the area of coverage (for lightning signals 6.7 mWm-2sr-1 during the night, 16.7 mWm-2sr-1 during the day), Radiance accuracy: 10% for radiances higher than 70 mWm-2sr-1, 7 mWm-2sr-1 for radiances lower than 70 mWm-2sr-1	NIR neutral oxygen lightning emission features at 777.4 nm
772	LCCRA	Laser Corner Cube Reflector Assembly	Operational		Laser retroreflector	Other	Open Access	-	Accuracy measurements on Lense-Thirring effect and baseline tracking data for General Relativity study and precision geodesy. Also for calibration of radar altimeter bias.	N/A	\N	N/A	\N	2 cm overhead ranging	VIS: 400 - 750 nm
1777	L-Band SAR	L-Band Synthetic Aperture Radar	Proposed		Imaging radar (SAR)	Imaging	\N	\N	Global observation of dynamic processes in the bio-, cryo-, geo- and hydrosphere.	\N	\N	\N	\N	\N	L-Band 23.6 cm
986	L-band Radar (SMAP)	L-band Synthetic Aperture Radar (SMAP)	No longer operational		Imaging radar (SAR)	Other	Open Access	HDF-5	High-resolution measurements of radar backscatter for global estimates of surface soil moisture and freeze/thaw states for climate modeling and weather prediction. The radar instrument stopped transmitting on 7 July 2015.	<3 km spatial resolution over 70% of swath; 3 days temporal resolution.   Soil moisture will be estimated at a resolution of 10 km and freeze-thaw state at a resolution of 1-3 km.	\N	40-deg constant incidence angle across the 1000 km swath	1000 km	<1dB Co-polarization; <1.5 dB cross-polarization at 3 km resolution	L-Band (1.2 GHz)
1554	L-band Radiometer (SMAP)	L-band Radiometer (SMAP)	Operational		Multi-purpose imaging MW radiometer	Other	Open Access	HDF-5	High-accuracy measurements of brightness temperatures for global estimates of surface soil moisture  for climate modeling and weather prediction	40km spatial resolution; 3 days temporal resolution	\N	40-deg constant incidence angle across the 1000 km swath	1000 km	1.3K accuracy brightness temperature	L-band (1.4 GHz)
819	L-band SAR	L-band SAR	No longer considered		Imaging radar (SAR)	Imaging	\N	\N	Forestry and environment applications.	3 - 20 m	\N	20 - 55 km	\N	\N	L-Band
29	Laser Reflectors	Laser Reflectors	Operational		Laser retroreflector	Sounding	Open Access	\N	Measures distance between the satellite and the laser tracking stations.	\N	\N	\N	\N	\N	\N
1764	L-Band SAR	L-Band SAR	No longer operational		\N	\N	\N	\N		\N	\N	\N	\N	\N	\N
767	Laser Reflectors (ESA)	Laser Reflectors	Operational		Laser retroreflector	Other	\N	\N	Measures distance between the satellite and the laser tracking stations.	\N	\N	\N	\N	\N	\N
1542	Laser altimeter (LIST)	Laser altimeter (LIST)	Proposed	Low Heritage	Lidar altimeter	Other	Open Access	\N	New technology laser system that performs spatial mapping of Earth’s surface from an orbital platform.	\N	\N	\N	\N	\N	Planned: 1030um
711	Lagrange	LABEN GNSS Receiver for Advanced Navigation, Geodesy and Experiments	No longer operational		GNSS receiver	Other	No Access	-	GPS Receiver including specialised version equipped with limb sounding antenna and dedicated signal tracking capability for meteorological, climate and space weather applications.	\N	\N	\N	\N	\N	\N
221	Klimat-2	Scanning IR radiometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	Images of cloud, ice and snow. Measures sea surface temparature.	0.45 km x 0.9 km	\N	1300 km	\N	\N	TIR: 10.5 - 12.5 µm
849	KGI-4S	Complex heliogeophysical measurements	No longer considered		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1544	Ku and X-band radars (SCLP)	Ku and X-band radars (SCLP)	Proposed	Low Heritage	Imaging radar (SAR)	Imaging	Open Access	\N	Snow accumulation for fresh water availability.	Spatial resolution of 50 to 100 m; 15 day temporal resolution	\N	\N	\N	\N	\N
214	Klimat	Scanning IR radiometer	No longer operational		Multi-purpose imaging Vis/IR radiometer	Sounding	\N	\N	Images of cloud, ice and snow. Measures sea surface temparature.	0.45 x 0.9 km	\N	1300 km	\N	\N	TIR: 10.5 - 12.5 µm
804	Lagrange RO	GNSS Receiver for Radio Occultation	No longer considered		GNSS radio-occultation receiver	Other	\N	\N		\N	\N	\N	\N	\N	\N
801	KMSS	Multispectral Imager (VIS) system	Operational	High Heritage - Non-Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Multispectral images of land & sea surfaces and ice cover.	60 m - 120 m	60m	900 km	900 km	\N	0.53 - 0.57 µm; 0.63-0.68 µm; 0.76-0.90 µm
230	KFA-1000	Photographic camera	No longer operational		High resolution optical imager	Sounding	\N	\N	Photography of land and ocean surfaces.	8 m at an altitude of 235 km	\N	0.3 of the orbit altitude	\N	\N	VIS - NIR: 0.57 - 0.8 µm
1545	K band radiometers (SCLP)	K band radiometers (SCLP)	Proposed	Low Heritage	Multi-purpose imaging MW radiometer	Sounding	Open Access	\N	Snow accumulation for fresh water availability.	Spatial resolution of 50 to 100 m 15 day temporal resolution	\N	\N	\N	\N	\N
559	JERS-1 Comms	Communications package for JERS-1	No longer operational		\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
220	KGI-4C	Module for Geophysical Measurements	No longer operational		Space environment monitor	Sounding	\N	\N	Measures particle flux and electromagnetic emissions.	8 - 12 km	\N	3100 km	\N	1.6 K	Electron flux density range: 0.15 - 3.2 MeV, proton flux density range: 5 - 90 MeV, Protons density of energy more that 600 MeV (5 - 10 channels)
107	JMR	JASON Microwave Radiometer	No longer operational		Non-scanning MW radiometer	Sounding	Open Access	NetCDF	Altimeter data to correct for errors caused by water vapour and cloud-cover. Also measures total water vapour and brightness temperature.	41.6 km at 18.7 GHz, 36.1 km at 23.8 GHz, 22.9 km at 34 GHz	\N	120 deg cone centred on nadir	\N	Total water vapour: 0.2 g/sq cm, Brightness temperature: 0.15 K	Microwave: 18.7 GHz, 23.8 GHz, 34 GHz
231	KFA-200	Photographic camera	No longer operational		High resolution optical imager	Sounding	\N	\N	Photography of land and ocean surfaces.	23 m at an altitude of 235 km	\N	0.9 of the orbit altitude	\N	\N	VIS - NIR: 0.6 - 0.7 µm
1541	Ka-band Radar INterferometer (KaRIN)	Ka-band Radar INterferometer (KaRIN)	Proposed	Low Heritage	Radar altimeter	Other	Open Access	\N	Swath mapping radar altimeter that provides measurements for surface water.	Vertical resolution is 2 cm	\N	\N	\N	\N	\N
695	JAMI	Japanese Advanced Meteorological Imager	No longer operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Measures cloud cover, cloud motion, cloud height, water vapour, rainfall, sea surface temperature and Earth radiation.	Visible: 1 km, TIR: 4 km	1000m	Full Earth disk every hour	168 km	\N	VIS - SWIR: 0.55 - 0.90 µm, MWIR - TIR: 3.5 - 4 µm, 6.5 - 7 µm, 10.3 - 11.3 µm, 11.5 - 12.5 µm
241	ISTOK-1	Infra-red Spectrometer	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Spectral measurements of thermal emission of atmosphere and of underlying Earth surface at a variety of incident angles as well as measurements of transmission spectra of atmosphere while tracking the Sun.	\N	\N	\N	\N	\N	\N
661	ISAMS	Improved Stratospheric and Mesospheric Sounder instrument	No longer operational		Limb-scanning IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
727	IST	Italian Star Tracker	No longer operational		Star tracker	Other	No Access	-	Test of a fully autonomous system for attitude and orbit determination using a star tracker.	\N	\N	\N	\N	\N	\N
213	ISP	ISP	No longer operational		Solar irradiance monitor	Sounding	\N	\N	Measures solar radiation flux.	\N	\N	\N	\N	0.01% (mean day accuracy)	UV-FIR: 0.2 - 50 µm
1745	IVM	Ion Velocity Meter	Being developed		Space environment monitor	\N	\N	\N	Measures the in-situ plasma density, ion temperature and composition, and drift velocity. Used for modeling the ionosphere to determine electric fields that could impact other systems (e.g. GPS radio signals).	\N	\N	\N	\N	\N	\N
749	ISL	Langmuir probes	No longer operational		Space environment monitor	Other	\N	\N	Density of the plasma and electron temperature.	\N	\N	\N	\N	Relative ion and electron density <5%, Absolute temperature <5%, Potential 10 mV Ion direction +15°	\N
665	IVISSR (FY-2)	Improved Multispectral Visible and Infra-red Scan Radiometer (5 channels)	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	DAT	Meteorological.	5 km	5000m	Full Earth disk	\N	1.25 - 5 km	VIS - TIR: 0.5 - 12.5 µm (5 channels)
410	IR-MSS	Infrared Multispectral Scanner	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Used for fire detection, fire extent and temperature measurement.	VIS, NIR, SWIR: 78 mm, TIR: 156 m	\N	120 km	\N	\N	VIS - NIR: 0.5 - 1.1 µm, NIR-SWIR: 1.55 - 1.75 µm, 2.08 - 2.35 µm, TIR: 10.4 - 12.5 µm
1708	IRM	Imaging and Rapid-scanning ion Mass spectrometer	Operational		Space environment monitor	Other	Open Access	\N	Measures the composition and 3-dimensional velocity distributions of ions.	N/A	\N	N/A	\N	\N	N/A
866	IRS	Infrared scanner	Operational	Medium Heritage	High-resolution nadir-scanning IR spectrometer	Imaging	Open Access	GEOTIFF	Earth resources, environmental monitoring, land use.	PAN, SWIR: 40 m, TIR: 80 m	40m	120 km	120 km	\N	0.5 - 0.9 µm; 1.55 - 1.75 µm, 2.08 - 2.35 µm; 10.4 - 12.5 µm
950	IRS	Infra-Red Sounder	Being developed		Medium-resolution IR spectrometer	Sounding	Open Access	NetCDF, BUFR	Measurements of vertically resolved clear sky atmospheric motion vectors, temperature and water vapour profiles.	Horizontal: 4 km at SSP, Vertical: 1 km	4000m	640 x 640 km dwells, step and stare, moving alternatley E-W and W-E moving up S-N one dwell step at the end of each row of dwells.  Each disc is divided in 4 areas of Local Area Coverage (LAC).	\N	clear sky AMVs: 2 m/s, temperature profile: 1 K, water vapour profile: 5%	LWIR: 700 - 1210 cm^-1, MWIR: 1600 - 2175 cm^-1
889	IRFS-2	IR Sounding Spectrometer	No longer considered		Medium-resolution IR spectrometer	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
1673	IRS (SJ-9B)	Infrared scanner	Operational		High-resolution nadir-scanning IR spectrometer	\N	Constrained Access	\N		73 m	73m	18 km	18 km	\N	8-12 µm
666	IRAS	InfraRed Atmospheric Sounder	Operational		Narrow-band channel IR radiometer	Sounding	Open Access	L-1 data: HDF 5.0	Atmospheric sounding for weather forecasting.	14 km	\N	952 km	\N	17 km	VIS - TIR: 0.65 - 14.95 µm (26 channels)
651	IRIS	Infrared Interferometer Spectrometer instrument	No longer operational		Medium-resolution IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
785	IR Sounder	Infra-red Sounder	No longer considered		Narrow-band channel IR radiometer	Sounding	\N	\N	Atmospheric temperature profiles and data on cloud parameters, humidity soundings, water vapour, total ozone content, and surface temperatures.	20 km (TBC)	\N	2600 km (TBC)	\N	\N	VIS - TIR: 3.7 - 15 µm (TBC)
732	IR Camera (SAOCOM)	\N	No longer considered		High resolution optical imager	Imaging	\N	\N	Fires monitoring.	200 m	200m	\N	\N	\N	NIR-TIR
1547	IR Spectrometer (GACM)	IR Spectrometer (GACM)	Proposed	Medium Heritage	High-resolution nadir-scanning IR spectrometer	Sounding	Open Access	\N	Daytime column measurements of CO in SWIR at 2.4 µm.	\N	\N	\N	\N	\N	2.4 and 4.6 µm
1528	IR spectrometer (CLARREO)	IR spectrometer (CLARREO)	No longer considered	Medium Heritage	High-resolution nadir-scanning IR spectrometer	Sounding	Open Access	\N	Absolute spectrally-resolved measurements of terrestrial thermal emission with an absolute accuracy of 0.1 K in brightness temperature. The measurements cover most of the thermal spectrum.	1 cm-1; 100 km footprint	\N	100 km	100 km	.1K 3σ brightness temperature	200 to 2000 cm-1
825	IR (HJ-1B)	Infrared Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Infrared measurements for environment and natural disaster monitoring.	300 m (10.5 - 12.5 μm), 150 m (the other bands)	150m	720 km	720 km	\N	0.75 - 1.10 µm, 1.55 - 1.75 µm, 3.50 - 3.90 µm, 10.5 - 12.5 µm
1590	IPDA LIDAR	Integrated Path Differential Absorption Light Detection and Ranging Instrument	Proposed		Atmospheric lidar	Sounding	Open Access	\N	'Active' optical remote sensing instrument for atmospheric parameters or trace gases. Global information on atmospheric Methane\nconcentration (Methane column density\nmeasurements).	50 km x 0.1 km	\N	0.1 km	\N	<2%	Two laser wavelengths, mean wavelength 1645 µm
298	INSAT Comms	Communications package for INSAT	No longer considered		\N	Sounding	\N	\N	Communication package onboard INSAT series satellites.	\N	\N	\N	\N	\N	\N
759	HRS	High Resolution Stereoscope	No longer operational		High resolution optical imager	Imaging	Constrained Access	\N	High resolution stereo instrument.	Panchromatic: 10 m, Altitude: 15 m	10m	120 km	120 km	\N	Panchromatic: VIS 0.49 - 0.69 µm
1538	IR Correlation Radiometer (GeoCape)	IR Correlation Radiometer (GeoCape)	Proposed	High Heritage - Non-Operational	Narrow-band channel IR radiometer	Sounding	Open Access	\N	The near-IR and thermal-IR data will describe vertical CO, an excellent tracer of long-range transport of pollution. Identifying large scale vegetation burning events.  Characterizing the oxidizing capacity of the atmosphere.	7 km horizontal spatial resolution, 2-3 layers in vertical resolution; < 0.2 um spectral resolution.	7000m	2-d image of continental domain (north or south America).	\N	CO precision: 1 x 10^17 cm^ (-2)	2.3, 4.6 µm
332	IMG	Inferometric Monitor of Greenhouse gases	No longer operational		Medium-resolution IR spectrometer	Imaging	\N	\N	IMG obtained detailed spectra of thermal infrared radiation from the Earth's surface and the atmosphere. Thermal infrared spectra include absorption and emission signatures of many atmosphere included gases.	\N	\N	\N	\N	\N	NIR (~0.75 µm - ~1.3 µm)
747	IMSC	Instrument Search Coil Magnetometer	No longer operational		Magnetometer	Other	\N	\N	Magnetic field.	\N	\N	\N	\N	\N	10 Hz - 17.4 kHz
668	IMWAS	Improved MicroWave Atmospheric Sounder	Operational		Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	Atmospheric sounding measurements.	\N	\N	\N	\N	\N	Microwave: 19.35 - 89.0 GHz (8 channels)
331	Imager	Imager	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Measures cloud cover, atmospheric radiance, winds, atmospheric stability, rainfall estimates. Used to provide severe storm warnings/ monitoring day and night (type, amount, storm features).	10 km	10000m	Full Earth disk	\N	\N	GOES 8 - 11: VIS: 1 channel (8 detectors), IR: 4 channels: 3.9 µm, 6.7 µm, 10.7 µm and 12 µm, GOES 12 - Q: VIS: 1 channel (8 detectors), IR: 4 channels: 3.9 µm, 6.7 µm, 10.7 µm and 13.3 µm
728	INES	Italian Navigation Experiment	No longer operational		GNSS receiver	Other	Constrained Access	-	Composed of GPS Tensor and GNSS Lagrange Receiver to perform navigation experiment on precise orbit determination.	\N	\N	\N	\N	\N	\N
466	IMAGER	Imager/MTSAT	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	LRIT/HRIT	Measures cloud cover, cloud motion, cloud height, water vapour, rainfall, sea surface temperature and Earth radiation.	Visible: 1 km, TIR: 4 km	1000m	Full Earth disk every hour	8 km	\N	VIS - SWIR: 0.55 - 0.80 µm, MWIR - TIR: 3.5 - 4 µm, 6.5 - 7 µm, 10.3 - 11.3 µm, 11.5 - 12.5 µm
788	Imager (INSAT)	Very High Resolution Radiometer	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Cloud cover, severe storm warnings/monitoring day and night (type, amount, storm features), atmospheric radiance winds, atmospheric stability rainfall.	1 x 1 km (VIS and SWIR), 4 x 4 km (MWIR, TIR), 8 x 8 km (in 6.50 - 7.00 µm)	1000m	Full Earth disc and space around, Normal Frame (50 deg. N to 40 deg. S  and full E-W coverage), Program Frame (Programmable, E-W Full coverage)	\N	\N	VIS: 0.55 - 0.75 µm; SWIR: 1.55 - 1.7 µm; MWIR: 3.80 - 4.00 µm, 6.50 - 7.00 µm; TIR: 10.2 - 11.3 µm, 11.5 - 12.5 µm
593	Imaging spectrometer	Imaging spectrometer	Approved		\N	Imaging	\N	\N	Multispectral data for Earth resources, agriculture and forestry, water resources and vegetation studies.	\N	\N	\N	\N	\N	\N
778	IKFS	IR-Fourier spectrometer	Operational	Medium Heritage	High-resolution nadir-scanning IR spectrometer	Other	Constrained Access	\N	Atmospheric temperature/humidity profiles, data on cloud parameters, water vapour & ozone column amounts, surface temperature.	35000-100000 m	35000m	1000 km; 1500 km; 2000 km; 2500 km	2500 km	\N	5 - 15 µm, more then 5000 spectral channels
333	ILAS	Improved Limb Atmospheric Spectrometer	No longer operational		Limb-scanning IR spectrometer	Sounding	\N	\N	Measures minor trace gas species at high latitudes, in the altitude range 10 - 60 km (O3, CH4, NO2, N2O, H2O, CFC11, HNO3, CIONO2, N2O5, aerosols, temparature, pressure).	700 m	700m	1400km	\N	\N	NIR (~0.75 µm - ~1.3 µm)
1688	IK-radiometer (1)	IR-radiometer	Proposed		Narrow-band channel IR radiometer	TBD	Constrained Access	\N	Parameters of clouds, snow, ice and land cover, vegetation, surface temperature, fire detection.	40 m	40m	120-200 km	200 km	\N	3.5-4.1 µm; 8.1-9.1 µm; 10.5-12.5 µm
240	IKAR-P	Multispectral microwave scanner	No longer operational		Multi-purpose imaging MW radiometer	Sounding	\N	\N	Used for investigations of ocean atmosphere system. Measures sea surface temperature, wind speed, precipitable water content, cloud liquid water content and rain rate.	\N	\N	\N	\N	\N	\N
239	IKAR-N	Multispectral microwave scanner	No longer operational		Multi-purpose imaging MW radiometer	Sounding	\N	\N	Used for investigations of ocean atmosphere system. Measures sea surface temperature, wind speed, precipitable water content, cloud liquid water content and rain rate.	\N	\N	\N	\N	\N	\N
854	IKOR-M	The modernized measuring instrument of short-wave reflected radiation	No longer considered		\N	TBD	\N	\N		\N	\N	\N	\N	\N	\N
334	ILAS-II	Improved Limb Atmospheric Spectrometer-II	No longer operational		Limb-scanning IR spectrometer	Sounding	\N	\N	Measures minor trace gas species at high latitudes, in the altitude range 10 - 60 km (O3, CH4, NO2, N2O, H2O, CFC11, HNO3, CIONO2, N2O5, aerosols, temparature, pressure).	Vertical: 1 km Temparature, aerosols, pressure: 2 km (horiz), CIONO2: 21.7 km (horiz), Others: 13 km (horiz)	\N	\N	\N	Temperature: 0.2 K, Pressure: 1%, Aerosol: 2%, Ozone: 3 - 5%, Other trace gases: 2 - 25%	VIS: 0.753 - 0.784 µm, MWIR - TIR: 3.0 - 5.7 µm, 6.21 - 11.76 µm, 12.78 - 12.85 µm
238	IKAR-D	Multispectral microwave scanner	No longer operational		Multi-purpose imaging MW radiometer	Sounding	\N	\N	Used for investigations of ocean atmosphere system. Measures sea surface temperature, wind speed, precipitable water content, cloud liquid water content and rain rate.	\N	\N	\N	\N	\N	\N
696	IIR	Imaging Infrared Radiometer	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	HDF	Radiometer optimised for combined IIR/lidar retrievals of cirrus particle size.	1 km	1000m	64 km	\N	1 K	TIR: 8.7 µm, 10.5 µm, and 12.0 µm (0.8 µm resolution)
750	IDP	Instrument For Plasma Detection	No longer operational		Space environment monitor	Other	\N	\N	Energy spectrum of electrons.	\N	\N	\N	\N	\N	\N
714	IGPM	IGPM microwave radiometer	No longer considered		Multi-purpose imaging MW radiometer	Other	\N	\N	Global water and energy cycle.	\N	\N	\N	\N	\N	\N
746	ICE	Instrument for Electric Field	No longer operational		Space environment monitor	Other	\N	\N	Electric field.	\N	\N	\N	\N	DC field +3 mV/m	DC to 3 MHz
729	ICARE	Influence of Space Radiation on Advanced Components	No longer operational		Space environment monitor	Other	Constrained Access	\N	Improvement of risk estimation models on latest generation of integrated circuits technology.	\N	\N	\N	\N	\N	\N
888	IIS	Interferometric Infrared Sounder	No longer operational		Medium-resolution IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
833	IGPM rain radar	IGPM rain radar	No longer considered		Cloud and precipitation radar	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1662	ICI	Ice Cloud Imager	Being developed		Multi-purpose imaging MW radiometer	Imaging	\N	NetCDF-4	Measures cloud ice content, snowfall detection, precipitation content, snowfall rate near surface and water vapour profiles	Footprint size 15 km (Threshhold)	\N	\N	\N	\N	11 channels from 183 to 664 GHz
1607	HYSI-SWIR	Hyperspectral SWIR	Proposed		Medium-resolution IR spectrometer	Imaging	Constrained Access	\N	Continuous monitoring of the earth and natural resources applications in hyperspectral SWIR bands	320 m	320m	\N	\N	\N	60 Bands VNIR
748	IAP	Instrument for plasma analysis	No longer operational		Space environment monitor	Other	\N	\N	Density, temperatures, speeds of major ions.	\N	\N	\N	\N	Ion density: +5%, Temperature +5%, Speed +5%	\N
1606	HRMX-VNIR	High Resolution MX-VNIR	Proposed		High resolution optical imager	Imaging	Constrained Access	\N	Continuous monitoring of the earth and natural resources applications in Visible and VNIR bands	50 m	50m	\N	\N	\N	MX (4 Bands VNIR)
1520	HRC	High Resolution Camera	No longer operational	Low Heritage	High resolution optical imager	Imaging	\N	\N	Earth resources, environmental monitoring, land use.	2.5 m	2.5m	27 km	27 km	\N	VIS: 0.50 - 0.80 µm
1626	IASI-NG	Infrared Atmospheric Sounding Interferometer - New Generation	Being developed		Medium-resolution IR spectrometer	Sounding	Open Access	NetCDF	Measures profiles of atmospheric temperature, humidity, ozone, carbon monoxide, columns of methane, nitrous oxide, and other minor gases, and sea, ice, and land surface temperature and emissivity.	Vertical: 1 - 30 km, Horizontal: 25 km	\N	2052 km	\N	TBC	MWIR - TIR: 645 to 2760 cm-1 or 3.62 - 15.5 µm (16921 spectral samples)
1608	HYSI-VNIR	Hyperspectral VNIR	Proposed		Medium-resolution IR spectrometer	Imaging	Constrained Access	\N	Continuous monitoring of the earth and natural resources applications in hyperspectral VNIR bands	192 m	192m	\N	\N	\N	150 Bands SWIR
926	HySI (IMS-1)	Hyperspectral Imager (IMS-1)	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Ocean and atmosphere study of Earth surface.	505.6 m	505.6m	125.5 km	125 km	\N	64 bands of 8 nm separation between 400 - 950 nm spectral range
627	Hyperion	Hyperspectral Imager	Operational		High resolution optical imager	Imaging	Open Access	HDF	Hyperspectral imaging of land surfaces.	30 m	30m	185 km	185 km	SNR @ 10% refl target: vis 10-40 swir 10-20	VIS - NIR: 400 - 1000 nm; NIR - SWIR: 900 - 2500 nm; 10 nm spectral resolution for 220 bands
1612	HYSI (IRS-1A)-VNIR	Hyperspectral VNIR	No longer considered		\N	Imaging	\N	\N		30 m	\N	60 km	\N	\N	VNIR Hyperspectral
305	IASI	Infrared Atmospheric Sounding Interferometer	Operational		Medium-resolution IR spectrometer	Sounding	Open Access	Native and BUFR	Measures tropospheric moisture and temperature, column integrated contents of ozone, carbon monoxide, methane, nitrous oxide and other minor gases which affect tropospheric chemistry. Also measures sea surface and land temperature.	Vertical: 1 - 30 km, Horizontal: 25 km	\N	2052 km	\N	Temperature: 0.5 - 2 K, specific humidity: 0.1 - 0.3 g/kg, ozone, trace gas profile: 10%	MWIR - TIR: 645 to 2760 cm-1 or 3.62 - 15.5 µm (8461 spectral samples)
924	HySI (TES-HYS)	Hyperspectral Imager (TES-HYS)	No longer considered		High resolution optical imager	Imaging	Constrained Access	\N	Ocean and atmosphere study of Earth surface.	15 m	15m	30 km	30 km	\N	200 Channel of 5 nanometer width
994	Hyperspectral Sounder	Hyperspectral Sounder	No longer considered		Medium-resolution IR spectrometer	TBD	\N	\N	Technology development for atmospheric profiles.	\N	\N	\N	\N	\N	\N
798	HYDROS	HYDROS	No longer considered		Multi-purpose imaging MW radiometer	Other	\N	\N		\N	\N	\N	\N	\N	\N
713	Hycam	Hyperspectral Camera	No longer considered		High resolution optical imager	Imaging	\N	\N	Atmospheric physics, radiative properties, climate change.	\N	\N	\N	\N	\N	VIS - NIR: 0.4 - 1.1 µm
1613	HYSI (Cartosat-3)	Hyperspectral sensor	No longer considered		High resolution optical imager	Imaging	Very Constrained Access	\N	High resolution images for study of agriculture, geology and water resources for generation of spectral library, geological mapping, water quality assessment, precision agriculture, discrimination of vegetation types, coastal studies, oil and mineral exploration etc	12 m	\N	15 km	15 km	\N	VNIR 0.4 - 0.9 (50 bands); SWIR 0.9-2.4 µm (150 bands)
724	HSTC	High Sensitivity Technological Camera	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	Fast format/geotif	Monitors forest fires, electrical storms and geophysical studies of aurora borealis, sea survilleance.	300 m	300m	700 km	700 km	\N	PAN: VIS - NIR: 450 - 850 nm
705	HYC	HYperspectral Camera	Approved		Medium-resolution IR spectrometer	Imaging	Constrained Access	HDF	Hyperspectral data for complex land ecosystem studies.	30 m	30m	30 km	30 km	Spectral resolution 10 nm	VNIR: 400 - 1010 nm, SWIR: 920 - 2500 nm
824	HSI (HJ-1A)	Hyper Spectrum Imager	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Hyperspectral measurements for environment and disaster management operations.	100 m	100m	50 km	50 km	\N	0.45 - 0.95 µm (128 bands)
964	HSI	Hyperspectral Imager	Approved	Medium Heritage	High resolution optical imager	Imaging	Open Access	\N	Detailed monitoring and characterization of rock and soil targets, vegetation, inland and coastal waters on a global scale.	GSD 30 m	30m	30 km	30 km	Radiometric: <5%	420 - 2450 nm
805	HSC (SAC-D/Aquarius)	High Sensitivity Camera	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	Geotif	High Sensitivity Camera (HSC) measures top of atmosphere radiance in the VIS spectral range measured by a high sensitivity sensor detects: urban lights, electric storms, polar regions, snow cover, forest fires, sea surveillance.	200 - 300 m	200m	1600 km	1600 km	\N	PAN (VIR-NIR): 450 - 900 nm
698	HSRS	Hot Spot Recognition System	No longer operational		High resolution optical imager	Imaging	\N	\N	Hot spot Detection (vegetation fires, volcanic activities, burning oil wells or coal seams.	370 m	\N	190 km	\N	\N	MWIR: 3.4 - 4.2 µm, TIR: 8.4 - 9.3 µm
442	HSB	Humidity Sounder for Brazil	No longer operational	Medium Heritage	Absorption-band MW radiometer/spectrometer	Sounding	Open Access	HDF-EOS	Humidity soundings for climatological and atmospheric dynamics applications. The scan mirror motor failed on 5th February 2003.	13.5 km	\N	1650 km	\N	Temperature: 1.0-1.2 K coverage of land and ocean surfaces, Humidity: 20%	Microwave: 5 discreet channels in the range of 150-183 MHz
1636	HSC (SABIA_MAR)	High Sensitivity Camera	No longer considered		Medium-resolution spectro-radiometer	Imaging	\N	\N	High Sensitivity Camera (HSC) measures top of atmosphere radiance in the VIS spectral range measured by a high sensitivity sensor detects: urban lights, electric storms, polar regions, snow cover, forest fires, sea surveillance.	400 m	400m	1560 km	1560 km	\N	PAN (VIS-NIR): 450 - 900 nm
1605	HRVS-1A/-1B	High Resolution VNIR Spectrometer	No longer considered		High-resolution nadir-scanning IR spectrometer	Imaging	\N	\N	Information on Aerosols & CO2 gas concentration.	0.375 - 0.9 µm	\N	500 km	\N	\N	\N
1696	HRWS X-Band Digital Beamforming SAR	HRWS X-Band Digital Beamforming SAR	Proposed		Imaging radar (SAR)	Imaging	Open Access	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	VHR Mode: 0.25 x 0.5 m, HR Stripmap: 0,5 x 0,5 m, Stripmap: 1 x 1 m ScanSAR: 4 - 25 x 25 m	0.25m	HR Mode: 10 km, HR Stripmap: 20 km Stripmap: 70 km, ScanSAR: up to 800 km	800 km	\N	9.65 GHz, up to 1200 MHz bandwidth, fully polarimetric
26	HRVIR	High Resolution Visible and Infra-red	No longer operational		High resolution optical imager	Imaging	\N	\N	2 HRVIR instruments provide 60 x 60 km images for a range of land and coastal applications.	10 m (0.64 µm) or 20 m	10m	117 km (i.e. 60 km + 60 km with 3 km overlap). Steerable up to ±27 deg off-track	117 km	\N	VIS: B1: 0.50 - 0.59 µm, B2: 0.61 - 0.68 µm, NIR: 0.79 - 0.89 µm, SWIR: 1.58 - 1.75 µm, Panchromatic:(B2) 0.61 - 0.68 µm
1711	HRTPC	High Resolution Technological Panchromatic Camera	No longer considered		High resolution optical imager	Imaging	\N	\N	High Resolution Panchromatic Camera - Technological objective - Coastal development mapping	5m	5m	30 km	60 km	\N	VIS - NIR: 400 - 900 nm
723	HRTC	High Resolution Panchromatic Camera	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	Fast format/geotif	Medium resolution Earth imagery to complement MMRS on the same mission.	35 m	35m	90 km	90 km	\N	VIS - NIR: 400 - 900 nm
1604	HRSS-1	High Resolution SWIR Spectrometer	No longer considered		High-resolution nadir-scanning SW spectrometer	Imaging	\N	\N	Information on Aerosols & CO2 gas concentration.	1.575 - 1.625 µm with 0.2 nm	\N	380 km	\N	\N	\N
19	HRV	High Resolution Visible	No longer operational		High resolution optical imager	Imaging	\N	\N	2 HRV instruments provide 60 x 60 km images for a range of land and coastal applications.	10 m (panchromatic) or 20 m	10m	117 km (i.e. 60 km + 60 km with 3 km overlap) - steerable up to ±27 deg off-track	117 km	\N	VIS: B1:0.5 - 0.59 µm, B2:0.61 - 0.68 µm, NIR: B3:0.79 - 0.89 µm, Panchromatic: VIS 0.51 - 0.73 µm
782	GALS-M	Galactic space rays detector	No longer considered		Space environment monitor	Other	\N	\N	Space environment monitoring.	\N	\N	\N	\N	\N	protons fluxes density > 600 MeV
1757	HRC	High Resolution Camera	Operational	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	The objective is to demonstrate a high-resolution imager, primarily intended for technology, educational and general public information purposes.	Ground resolution of 8 m (from an altitude of 600 km)	8m	Images of size 4 km x 4 km	4 km	\N	Gray scale images
1609	HRMX-TIR	High resoultion Mx TIR	Proposed		High resolution optical imager	Imaging	Constrained Access	\N	Continuous monitoring of the earth and natural resources applications in hyperspectral thermal bands	1.5 km	1500m	\N	\N	\N	MX (3 Bands TIR)
97	HRDI	High Resolution Doppler Imager	No longer operational		Limb-scanning SW spectrometer	Sounding	\N	\N	Daytime wind measurements below 50 km from Doppler shifts of molecular oxygen absorption lines. Day and night wind measurements above about 60 km from Doppler shifts of neutral and ionised atomic oxygen emission lines. Also measures temperature.	\N	\N	\N	\N	\N	\N
1603	HRMX	High Resolution Multi Spectral	Being developed		High resolution optical imager	Imaging	Constrained Access	\N	For crops and vegetation dynamics, natural resources census, disaster management and large scale mapping of themes.	2 m	2m	10 km	10 km	\N	4 bands MX in VIS and NIR
183	HRG	HRG	No longer operational		High resolution optical imager	Imaging	Open Access	\N	High resolution multispectral mapper. 2 HRG instruments on this mission can be processed to produce simulated imagery of 2.5 m. Images are 60 x 60 km in size.	Panchromatic: 5 m, Multispectral: 10 m	5m	60 km (1 instrument), 117 km (2 instruments). Same as SPOT 4 with off-track steering capability (±27 deg)	117 km	\N	VIS: B1: 0.50 - 0.59 µm, B2: 0.61 - 0.68 µm, NIR: B3: 0.79 - 0.89 µm, SWIR: 1.50 - 1.75 µm, Panchromatic: 0.49 - 0.69 µm
1561	HPS	Hyper-Spectrometer	No longer operational		Medium-resolution spectro-radiometer	TBD	Very Constrained Access	\N		\N	\N	\N	\N	\N	\N
309	HIRS/2	High Resolution Infra-red Sounder/2	No longer operational		Narrow-band channel IR radiometer	Sounding	\N	\N	Measures atmospheric temperature, concentrations of ozone, water vapour, methane, NOx, N2O, CFCs and other minor species, aerosol concentration, location of polar stratospheric clouds and cloud tops.	20.3 km	\N	2240 km	\N	\N	VIS - TIR: 0.69 - 14.95 µm (20 channels)
564	HIRS/4	High Resolution Infra-red Sounder/4	Operational	High Heritage - Operational	Narrow-band channel IR radiometer	Imaging	\N	\N	Atmospheric temperature profiles and data on cloud parameters, humidity soundings, water vapour, total ozone content, and surface temperatures. Same as HIRS/3, with 10 km IFOV.	20.3 km	\N	2240 km	\N	\N	VIS - TIR: 0.69 - 14.95 µm (20 channels)
1653	Himawari DCS	Data Collection System for Himawari	Operational		Data collection system	Other	Constrained Access	\N		\N	\N	\N	\N	\N	\N
887	HiRI	High-Resolution Imager	Operational		High resolution optical imager	Imaging	Open Access	\N	Cartography, land use, risk, agriculture and forestry, civil planning and mapping, digital terrain models, defence.	0.70 m	0.7m	20 km swath at nadir. Agile platform giving ±50 deg off-track	20 km	\N	4 bands + PAN: Near IR (0.77 - 0.91 µm), Red (0.61 - 0.71 µm), Green (0.50 - 0.60 µm), Blue (0.44 - 0.54 µm), Pan (0.47 - 0.84 µm)
1634	HISUI	Hyperspectral Imager Suite	No longer considered		High resolution optical imager	Imaging	\N	\N	Global energy and resource related applications - Exploration of oil, gas, and metal resources - Environmental assessments of oil/gas fields and mines. Other applications such as environmental monitoring, agriculture, and forestry. Instrument was considered as a part of ALOS-3.	Hyperspectral Sensor:30 m, Multispectral Sensor: 5 m	5m	Hyperspectral Sensor:30 km, Multispectral Sensor: 90 km	90 km	Hyperspectral Sensor:SN  = 450 @620 nm, 300 @2100 nm                                                           Multispectral Sensor: SN= 200	Hyperspectral Sensor:VNIR 57 bands (in 0.4 - 0.97 µm), SWIR 128 bands (in 0.9 - 2.5 µm), Multispectral Sensor: 4 bands (in 0.45 - 0.89 µm)
351	HiRDLS	High Resolution Dynamics Limb Sounder	Operational		Limb-scanning IR spectrometer	Sounding	Open Access	HDF	Measures atmospheric temperature, concentrations of ozone, water vapour, methane, NOx, N2O, CFCs and other minor species, aerosol concentration, location of polar stratospheric clouds and cloud tops. Currently not collecting data on Aqua.	Vertical: 1 km, Horizontal: 10 km	\N	\N	\N	Trace gas: 10%, Temperature: 1 K, Ozone: 10%	TIR: 6.12 - 17.76 µm (21 channels)
650	HPC	High Performance Computer	No longer considered		\N	Other	\N	\N		\N	\N	\N	\N	\N	\N
313	HIRS/3	High Resolution Infra-red Sounder/3	Operational	High Heritage - Operational	Narrow-band channel IR radiometer	Sounding	\N	\N	Atmospheric temperature profiles and data on cloud parameters, humidity soundings, water vapour, total ozone content, and surface temperatures.	20.3 km	\N	2240 km	\N	\N	VIS - TIR: 0.69 - 14.95 µm (20 channels)
1737	HICO	Hyperspectral Imager for the Coastal Ocean	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Spaceborne imaging spectrometer designed to sample the coastal ocean with full spectral coverage (400 to 900 nm sampled at 5.7 nm) and a very high signal-to-noise ratio to resolve the complexity of the coastal ocean.	Ground sample distance of 90 m (varies with altitude and angle)	90m	scene size: 42 x 192 km	\N	\N	87 bands (128 uncropped) from 400 - 900 nm (353 - 1080 nm uncropped)
871	HES	Hyperspectral Environmental Suite	No longer considered		Medium-resolution IR spectrometer	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1551	HDWL (3D Winds)	HDWL (3D Winds)	Proposed	Low Heritage	Doppler lidar	Other	Open Access	\N	Tropospheric winds for weather forecasting and pollution transport.	300 km along track horizontal resolution	\N	View 45 degrees of nadir at four azimuth angles: 45, 135, 225, 315 deg.	\N	2-3 m/s LOS wind accuracy projected into horizontal from all effects including sampling error	2.051 µm and 0.355 µm
1753	GSA (4)	Hyperspectral imaging equipment	No longer considered		Multi-channel/direction/polarisation radiometer	Imaging	Constrained Access	\N	Land surface monitoring	25-84 m	25m	42 km	42 km	\N	0.43-0.90 µm; 0.9-1.7 µm; 2-2.4 µm; 130 channels
350	HALOE	Halogen Occultation Experiment	No longer operational		Limb-scanning IR spectrometer	Sounding	\N	\N	Data on vertical distributions of hydrofluoric and hydrochloric acids, methane, water vapour and members of the nitrogen family. It also provides atmospheric temperature versus pressure profiles from observations of carbon dioxide.	\N	\N	\N	\N	\N	\N
1652	Himawari Comms	Communications package for Himawari	Operational		Communications system	Other	Very Constrained Access	\N		\N	\N	\N	\N	\N	\N
961	High Resolution Panchromatic Camera	High Resolution Panchromatic Camera	No longer considered		High resolution optical imager	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1740	High Resolution Optical Sensor	High Resolution Optical Sensor	Being developed		High resolution optical imager	\N	Very Constrained Access	\N	Cartography, land use and planning	1m	1m	\N	\N	\N	\N
1660	GRACE-FO Instrument	GRACE-FO Instrument	No longer considered		Satellite-to-satellite ranging system	Other	\N	\N	Includes Global Positioning System (TRiG-based) and High Accuracy Inter-satellite Ranging System (aka K-band Ranging System) for Inter-satellite ranging system estimates for global models of the mean and time variable Earth gravity field.	400 km horizontal, N/A vertical	\N	N/A	\N	1 cm equivilant water	Microwave: 24 GHz and 32 GHz
237	Greben	Radar altimeter	No longer operational		Radar altimeter	Sounding	\N	\N	Radar altimeter.	\N	\N	\N	\N	\N	\N
1686	GSA (1)	Hyperspectral imaging equipment	Operational		Multi-channel/direction/polarisation radiometer	Imaging	Constrained Access	\N	Land surface monitoring	30 m	30m	25 km	950 km	\N	0.4 - 1.1 µm, 96-255 spectral bands
306	GRAS	GNSS Receiver for Atmospheric Sounding	Operational		GNSS radio-occultation receiver	Sounding	Open Access	\N	GNSS receiver for atmospheric temperature and humidity profile sounding.	Vertical: 150 m (troposphere) and 1.5 km (stratosphere), Horizontal: 100 km approx (troposphere), 300 km approx (stratosphere)	\N	Altitude range of 5 - 30 km	\N	Temperature sounding to 1 K rms	L-Band
1687	GSA (2)	Hyperspectral imaging equipment	Approved		Multi-channel/direction/polarisation radiometer	Imaging	Constrained Access	\N	Land surface monitoring	25 - 30 m\n60 - 70 m\n90 - 100 m	25m	25-30 km	32 km	\N	>130 bands - 400 - 1000 nm\n100 bands - 1300 - 2500 nm\n60 bands - 3000 - 12000 nm
1553	GPSRO (Terra-SAR)	GPS Radio Occultation System	Operational		GNSS radio-occultation receiver	Other	Open Access	\N	Measurements of atmospheric temperature, pressure and water vapour content.	\N	\N	\N	\N	\N	\N
987	GRACE instrument	GRACE instrument	Operational	High Heritage - Operational	Satellite-to-satellite ranging system	Other	Open Access	GeoTIFF, ASCII and netCDF	Includes BlackJack Global Positioning System (Turbo Rogue Space Receiver) and High Accuracy Inter-satellite Ranging System (aka K-band Ranging System) for Inter-satellite ranging system estimates for global models of the mean and time variable Earth gravity field.	400 km horizontal, N/A vertical	\N	N/A	\N	1 cm equivilant water	Microwave: 24 GHz and 32 GHz
1752	GSA (3)	Hyperspectral imaging equipment	Prototype		Multi-channel/direction/polarisation radiometer	Imaging	Constrained Access	\N	Land surface monitoring	\N	30m	\N	22 km	\N	0.4 - 1.1 µm
682	GPSOS	Global Positioning System Occultation Sensor	No longer considered		GNSS radio-occultation receiver	Sounding	\N	\N	Monitors signals from 24 GPS satellites that circle the Earth to help characterise ionospheric density profiles and atmospheric pressure, temperature, and humidity profiles.	1 km	\N	N/A	\N	0.1 TEC	L1:1537 MHz, L2:1217 MHz
943	GPS Receiver (Swarm)	GPS Receiver (Swarm)	Operational		GNSS receiver	TBD	\N	\N	Provides position and timing determination	L1 C/A code range error better than 0.5 m RMS; L1/L2 P-code range error better than 0.25 m RMS; L1 carrier phase error better than 5 mm	\N	\N	\N	\N	\N
583	GPS receiver	GPS receiver	No longer operational		GNSS receiver	Sounding	\N	\N	Sounding data for study of physics of upper atmosphere, and water vapour, temparature and refractivity profiles.	1 sample every 30 secs	\N	\N	\N	\N	\N
105	GPSDR	GPS Demonstration Receiver	No longer operational		GNSS radio-occultation receiver	Sounding	\N	\N	Precise continuous tracking data of satellite to decimeter accuracy.	\N	\N	N/A	\N	\N	\N
983	GPSP	Global Positioning System Payload	Operational		GNSS receiver	TBD	Open Access	\N	Precision orbit determination.	\N	\N	\N	\N	\N	\N
856	GPS (GRACE)	Global Positioning System Receiver	No longer considered		GNSS receiver	TBD	\N	\N	Microwave: 1227.60 MHz, 1575.42 MHz.	not applicable	\N	TBD	\N	\N	not applicable
1552	GPSRO (Oersted)	GPS Radio Occultation System	Operational		GNSS radio-occultation receiver	Other	Open Access	\N	Measurements of atmospheric temperature, pressure and water vapour content.	\N	\N	\N	\N	\N	\N
786	GPS (ESA)	GPS Receiver	No longer operational		GNSS receiver	Other	\N	\N	Satellite positioning.	\N	\N	\N	\N	\N	\N
366	GOMOS	Global Ozone Monitoring by Occultation of Stars	No longer operational		Limb-scanning SW spectrometer	Imaging	Open Access	\N	Stratospheric profiles of temperature and of ozone, NO2, H20, aerosols and other trace species.	1.7 km vertical	\N	Not applicable	\N	\N	Spectrometers: UV - VIS: 248 - 371 nm and 387 - 693 nm, NIR: 750 - 776 nm and 915 - 956 nm, Photometers: 644 - 705 nm and 466 - 528 nm
710	GPS	GPS receiver	No longer considered		GNSS receiver	Other	\N	\N	Study of perturbations in the atmosphere and ionosphere caused by electromagnetic waves, shorterm earthquake prediction.	\N	\N	\N	\N	\N	\N
370	GOME	Global Ozone Monitoring Experiment	No longer operational		High-resolution nadir-scanning SW spectrometer	Imaging	Open Access	\N	Measures concentration of O3, NO, NO2, BrO, H2O, O2/O4, plus aerosols and polar stratospheric clouds, and other gases in special conditions.	Vertical: 5 km (for O3), Horizontal: 40 x 40 km to 40 x 320 km	\N	120 - 960 km	\N	\N	UV-NIR: 0.24 - 0.79 µm (resolution 0.2 - 0.4 nm)
726	GOLPE	GPS Occultation and Passive reflection Experiment	No longer operational		GNSS radio-occultation receiver	Other	Open Access	\N	Measurements of atmospheric effects on GPS signals, and precise positioning information to assist gravitational measurements.	\N	\N	\N	\N	\N	\N
881	GOX	Global Positioning Satellite Occultation Experiment (GOX)	Operational		GNSS radio-occultation receiver	Other	Open Access	\N	Each instrument equipped with 4 GPS antennas to receive the L1 and L2 radio wave signals transmitted from the 24 US GPS satellites. Based on the signal transmission delay caused by the electric density, temperature, pressure, and water content in the ionosphere and atmosphere, information about ionosphere and atmosphere can be derived.	Vertical: 0.3 - 1.5 m; Horizontal: 300 - 600 km	\N	\N	\N	\N	L1/L2
562	GOES Comms	Communications package on GOES	Operational	High Heritage - Operational	\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
773	GMI	GPM Microwave Imager	Operational		Multi-purpose imaging MW radiometer	Imaging	Open Access	HDF-EOS(HDF5)	Measures rainfall rates over oceans and land, combined rainfall structure and surface rainfall rates with associated latent heating. Used to produce three hour, daily, and monthly total rainfall maps over oceans and land.	Horizontal: 36 km cross-track at 10.65 GHz (required - Primary Spacecraft, goal - Constellation Spacecraft); 10 km along-track and cross-track (goal - Primary Spacecraft)	\N	800 km (Core Observatory	\N	0.65 - 1.5 K	Microwave: 10.65 GHz, 18.7 GHz, 23.8 GHz, 36.5 GHz, 89.0 GHz, 165.5 GHz, 183.31 ± 3 GHz, 183.31 ± 8 GHz
307	GOME-2	Global Ozone Monitoring Experiment - 2	Operational		High-resolution nadir-scanning SW spectrometer	Sounding	Open Access	Native	Measurement of total column amounts and stratospheric and tropospheric profiles of ozone. Also amounts of H20, NO2, OClO, BrO, SO2 and HCHO.	Horizontal: 40 x 40 km (960 km swath) to 40 x 5 km (for polarization monitoring)	\N	120 - 960 km	\N	Cloud top height: 1 km (rms), Outgoing short wave radiation and solar irradiance: 5 W/m2, Trace gas profile: 10 - 20%, Specific humidity profile: 10 - 50 g/kg	UV - NIR: 0.24 - 0.79 µm (resolution 0.2 - 0.4 nm)
299	GMS Comms	Communications package on GMS	No longer operational		\N	Sounding	\N	\N	Communication package onboard GMS series satellites.	\N	\N	\N	\N	\N	\N
1619	GNOS	GNSS Occultation Sounder	Approved		GNSS radio-occultation receiver	Sounding	Constrained Access	\N	Atmospheric sounding for weather forecasting.	\N	\N	\N	\N	\N	\N
816	GLI follow-on	Global Imager follow-on	No longer considered		Medium-resolution spectro-radiometer	Imaging	\N	\N	Measures water vapour, aerosols, cloud cover, cloud top height/temp, ocean colour, sea surface temperature, land surface temparature, glacier extent, icebergs, sea ice and snow cover, photosynthetically active radiation, vegetation type and land cover.	1 km for 28 bands, 250 m for 6 bands	\N	1600 km	\N	Specific humidity profile: 0.5 g/m2 through total column, Surface temp 0.4-0.5 K, Cloud top temp: 0.5 K, Cloud cover: 3%, Cloud top height: 0.5 km, Ice and snow cover: 5%	VIS and NIR: 23 bands (380 - 830 nm); NIR - SWIR: 6 bands (1050 - 2215 nm); MWIR - TIR: 7 bands (3.75 - 11.95 µm)
877	GLM	GEO Lightning Mapper	Being developed	Low Heritage	Lightning imager	Other	\N	\N	Detect total lightning flash rate over near full disk.	10 km	\N	\N	\N	70%	NIR at 777.4 nm
886	GOCI	Geostationary Ocean Colour Imager	Operational	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF, LRIT, HRIT	Ocean colour information, coastal zone monitoring, land resources monitoring.	236 x 500 m	236m	1440 km	1440 km	\N	VIS - NIR: 0.40 - 0.88 µm (8 channels)
1720	GNSS POD Receiver	GNSS POD Receiver	Being developed		GNSS receiver	\N	\N	\N		\N	\N	\N	\N	\N	\N
1779	GIIRS	Geostationary Interferometric Infrared Sounder	Prototype		\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
603	Fluxgate magnetometer	Fluxgate magnetometer	No longer operational		Magnetometer	Imaging	\N	\N	Measures electrical currents and perturbations in the Earth's magnetic field in the range 0.1 Hz to 1 kHz.	\N	\N	\N	\N	\N	\N
1648	ES	Electron Spectrometer	Operational		Space environment monitor	\N	\N	\N	Space Physics experiment for meausring speed and direction of electrons coming from the sun.	\N	\N	\N	\N	\N	\N
421	GLAS	Geoscience Laser Altimeter System	No longer operational		Lidar altimeter	Imaging	\N	\N	Provision of data on ice sheet height/thickness, land altitude, aerosol height distributions, cloud height and boundary layer height.	66 m spots separated by 170 m	66m	\N	\N	Aerosol profile: 20%, Ice elevation: 20 cm, Cloud top height: 75 m, Land elevation: 20 cm, geoid: 5 m	VIS - NIR: Laser emits at 1064 nm (for altimetry) and 532 nm (for atmospheric measurements)
631	GIFTS	Geosynchronous Imaging Fourier Transform Spectrometer	No longer considered		Medium-resolution IR spectrometer	Sounding	\N	\N	Measures temperature, water vapour, tracer winds, chemical composition with high spatial and temporal resolution for considerable improvements in weather observations and air quality monitoring. Tests next-generation met observing systems.	Visible: 1 x 1 km, IR: 4 x 4km	\N	Full Earth disk	\N	\N	MWIR - TIR: 1724 channels in the bands 4.45 - 6.06 µm and 8.85 - 14.6 µm
813	GHG Sensor	Greenhouse gases observing sensor	No longer considered		\N	TBD	\N	\N		\N	\N	\N	\N	\N	\N
1685	GGAK-VE	Module for Geophysical Measurements	Approved		Space environment monitor	TBD	Constrained Access	\N	Monitoring and forecasting of solar activity, radiation and magnetic field in the near-Earth space, monitoring of natural and modified magnetosphere, ionosphere and upper atmosphere.	\N	\N	\N	\N	\N	\N
362	GLI	Global Imager	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Measures water vapour, aerosols, cloud cover, cloud top height/temp, ocean colour, sea surface temperature, land surface temparature, glacier extent, icebergs, sea ice and snow cover, photosynthetically active radiation, vegetation type and land cover.	1 km for 28 bands, 250 m for 6 bands	\N	1600 km	\N	Specific humidity profile: 0.5 g/m2 through total column, surface temp 0.4 - 0.5 K, cloud top temp: 0.5 K, cloud cover: 3%, cloud top height: 0.5 km, ice and snow cover: 5%	VIS and NIR: 23 bands (380 - 830 nm), NIR - SWIR: 6 bands (1050 - 2215 nm), MWIR - TIR: 7 bands (3.75 - 11.95 µm)
841	GID-12T	GID-12T	No longer operational		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	1200 MHz, 1600 MHz
853	GGAK-M	Module for Geophysical Measurements (SEM)	Operational	High Heritage - Non-Operational	Space environment monitor	Other	Constrained Access	\N	Space Environmental Monitoring (SEM), heliogeophysical.	\N	\N	\N	\N	\N	\N
303	GERB	Geostationary Earth Radiation Budget	Operational		Broad-band radiometer	Imaging	Open Access	native, HDF	Measures long and short wave radiation emitted and reflected from the Earth's surface, clouds and top of atmosphere. Full Earth disk, all channels in 5 minutes.	44.6 x 39.3 km	\N	Single column moved alternately W-E and E-W to cover the complete earth disc	\N	SW=1.2 Wm-2, LW=7.5 Wm-2	SW: 0.32 - 4.0 µm, LW 4.0 - 30 µm (by subtraction)
1583	GEMS	Geostationary Environmental Monitoring Spectrometer	Being developed		Medium-resolution spectro-radiometer	Imaging	Open Access	TBD	Measurements of atmospheric chemistry, precursors of aerosols and ozone in particular, in high temporal and spatial resolution over Asia.	56km2 at Seoul	\N	TBD	\N	\N	0.30 µm - 0.50µm
1543	GeoSTAR	MW Array Spectrometer (PATH)	Proposed		\N	Sounding	Open Access	\N	High frequency, all-weather temperature and humidity soundings for weather forecasting and SST.	Temporal resolution is 15 to 30 minutes; 25 - 50 km at nadir	\N	Temporal resolution is 15 to 30 minutes; 25 - 50 km at nadir	\N	\N	50 - 57 GHz, 165 - 183 GHz, and possibly 118 - 125 GHz
1684	Geoton-L1 (2)	Geoton-L1	Operational		High resolution optical imager	Imaging	Constrained Access	\N	Multispectral images of land surfaces and Oceans.	1 m; 3 m	1m	38 km	950 km	\N	0.58 - 0.8 µm; 0.45 - 0.52 µm; 0.52 - 0.60 µm; 0.61 - 0.68 µm; 0.72 - 0.80 µm;  0.80 - 0.90  µm
847	GGAK-E	Module for Geophysical Measurements	Operational	High Heritage - Non-Operational	Space environment monitor	Other	Constrained Access	\N	Monitoring and forecasting of solar activity, radiation and magnetic field in the near-Earth space, monitoring of natural and modified magnetosphere, ionosphere and upper atmosphere.	\N	\N	\N	\N	\N	\N
844	Geoton-L1 (1)	Geoton-L1	No longer operational	Medium Heritage	High resolution optical imager	Imaging	Constrained Access	\N	Multispectral images of land surfaces and Oseans.	3 m; 5 m	3m	16 km	950 km	\N	0.58 - 0.8 µm; 0.5 - 0.6 µm; 0.6 - 0.7 µm; 0.7 - 0.8 µm
1717	GEDI	Global Ecosystem Dynamics Investigation Lidar	Being developed		Lidar altimeter	\N	Open Access	TBD	This project will use a laser-based system to study a range of climates, including the observation of the forest canopy structure over the tropics, and the tundra in high northern latitudes.	\N	\N	\N	\N	\N	\N
879	Geomicrowave sounder	Geomicrowave sounder	No longer considered		Absorption-band MW radiometer/spectrometer	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
1618	GAMI	Greenhouse Gases monitoring Instrument	Approved	Low Heritage	High-resolution nadir-scanning SW spectrometer	\N	Constrained Access	\N	Measures greenhouse gases.	\N	\N	\N	\N	\N	\N
1707	GAP	GPS receiver-based Attitude, Position, and profiling experiment (GAP)	Operational		GNSS radio-occultation receiver	Other	Open Access	\N	Used for spacecraft position and attitude determination and for ionospheric radio occultation profiling measurements in which the relative phase delay of the measured L1 and L2 signals (at frequencies of 1.57542 GHz and 1.2276 GHz, respectively) from different satellites of the GPS constellation will be used to determine the electron density profile of the ionosphere using tomographic techniques. The GAP is turned on an average of 10% of the time, following a schedule devised by the science team.	N/A	\N	N/A	\N	\N	1.57542 GHz and 1.2276 GHz
1778	FLORIS	FLORIS	Approved		\N	\N	\N	\N	Mapping vegetation fluorescence to quantify photosynthetic activity.	\N	\N	\N	\N	\N	\N
885	FCI	Flexible Combined Imager	Being developed		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	NetCDF	Measurements of cloud cover, cloud top height, precipitation, cloud motion, vegetation, radiation fluxes, convection, air mass analysis, cirrus cloud discrimination, tropopause monitoring, stability monitoring, total ozone and sea surface temperature.	VIS0.4=1.0 km, VIS0.5=1.0 km, VIS0.6=1.0 km & 0.5 km, VIS0.8=1.0 km, VIS0.9=1.0 km, NIR1.3=1.0 km, NIR1.6=1.0 km, NIR2.2=1.0 km & 0.5 km, IR3.8=2.0 km & 1.0 km, WV6.3=2.0 km, WV7.3=2.0 km, IR8.7=2.0 km, IR9.7=2.0 km, IR10.5=2.0 km & 1.0 km, IR12.3=2.0 km, IR13.3=2.0 km (spatial sampling distance at SSP)	500m	210 km swath moved alternately W-E and E-W, moving up S-N a swath width at the end of each swath.  Full Disc Coverage (FDC) or Local Area Coverage (LAC) possible.	210 km	Cloud cover: 10%, Cloud top height: 1 km, Cloud top temperature: 1 K, Cloud type: 8 classes, Surface temperature: 0.7-2.0K, Specific humidity profile: 10%, Wind profile (horizontal component): 2 - 10 m/s, Long wave Earth surface radiation: 5 W/m2	VIS0.4=0.414 - 0.474 µm, VIS0.5=0.49 - 0.53 µm, VIS0.6=0.615 - 0.665 µm, VIS0.8=0.84 - 0.89 µm, VIS0.9=0.904 - 0.924 µm, NIR1.3=1.365 - 1.395 µm, NIR1.6=1.585 - 1.635 µm, NIR2.2=2.225 - 2.275 µm, IR3.8=3.6 - 4 µm, WV6.3=5.8 - 6.8 µm, WV7.3=7.1 - 7.6 µm, IR8.7=8.5 - 8.9 µm, IR9.7=9.51 - 9.81 µm, IR10.5=10.15 - 10.85 µm, IR12.3=12.05 - 12.55 µm, IR13.3=13 - 13.6 µm (measured at FWHM)
951	EXIS	Extreme Ultraviolet and X-ray Irradiance Sensors	Being developed	Medium Heritage	Solar irradiance monitor	Other	\N	\N	Monitors the whole-Sun X-ray irradiance in two bands and the whole-Sun EUV irradiance in five bands.	N/A	\N	\N	\N	\N	\N
1705	FAI	Fast Auroral Imager	Operational		Space environment monitor	Other	Open Access	\N	Measures the large-scale auroral emissions in the 630-1100 nm wavelength range. The FAI imager system produces 16-bit digital images of the near infrared band at one image per second (CASSIOPE is a 3-axis stabilized platform),and the 630-nm wavelength at two images per minute, giving adequate temporal resolution to investigate the above scientific objectives.	2.6 km at apogee (aurora at 110 km altitude)	\N	N/A	\N	\N	Visible: 630 nm\nNIR: 650-1100 nm
884	ERM	Earth Radiation Measurement	Operational		Broad-band radiometer	Other	Constrained Access	L-1 data: HDF 5.0	Measures Earth radiation gains and losses on regional, zonal and global scales.	25 km	\N	2200 km	\N	DLR/DSR10 watts/m2 net solar 3 w/m2 OLR 5 w/m2	0.2 - 3.8 µm, 0.2 - 50 µm
1582	ERBS	Earth Radiation Budget Sensor	No longer considered		Broad-band radiometer	Imaging	\N	HDF and ASCII (ASCII- limited data sets)	Long term measurement of the Earth's radiation budget and atmospheric radiation from the top of the atmosphere to the surface; provision of an accurate and self-consistent cloud and radiation database.  Presently planned as a follow-on sensor to CERES.  All technical parameters are to be determined.	TBD	\N	\N	\N	TBD	TBD
1617	ERM-2	Improved Earth Radiation Measurement	Approved		Broad-band radiometer	\N	Constrained Access	\N	Measures Earth radiation gains and losses on regional, zonal and global scales.	\N	\N	\N	\N	\N	\N
322	ETM+	Enhanced Thematic Mapper Plus	Operational	High Heritage - Operational	High resolution optical imager	Imaging	Open Access	\N	Measures surface radiance and emittance, land cover state and change (eg vegetation type). Used as multi-purpose imagery for land applications.	PAN: 15 m, VIS - SWIR: 30 m, TIR: 60 m	15m	185 km	185 km	50 - 250 m systematically corrected geodetic accuracy	VIS - TIR: 8 bands: 0.45 - 12.5 µm
1537	Event Imaging Spectrometer from GEO (GeoCape)	Event Imaging Spectrometer from GEO (GeoCape)	Proposed	Low Heritage	High resolution optical imager	Imaging	Open Access	\N	Predictions of impacts from oil spills, fires, water pollution from sewage and other sources, fertilizer runoff, and other environmental threats. Detection and tracking of waterborne hazardous materials. Monitoring and improvement of coastal health.	250 m spatial resolution, 20 - 50 nm (MODIS-like) spectral bands	250m	300 km swath width coastal regions an targets of opportunity	\N	\N	UV/VIS (310 - 481 nm) and the VIS/NIR (500 - 900 nm)
873	EHIS	Energetic Heavy Ion Sensor	No longer considered		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	\N
143	ERBE	Earth Radiation Budget Experiment	No longer operational		Broad-band radiometer	Other	\N	\N	Radiation budget measurements - Total energy of Sun's radiant heat and light, Reflected solar radiation, Earth emitted radiation.	1000 km sun, 40 km Earth	\N	Full sun and full earth views	\N	\N	Sunview: NIR - FIR: 0.2 - 3.5 µm, 0.2 - 50.0 µm; Channel 5: 0.2 - 50.0 µm; Earth view: 0.2 - 50.0 µm
733	EOC	Electro-Optical Camera	No longer operational		High resolution optical imager	Imaging	\N	\N	High resolution stereo imager for land applications of cartography and disaster monitoring.	6.6 m	\N	17 km	\N	\N	Panchromatic VIS: 0.51 - 0.73 µm
1615	EPIC	Earth Polychromatic Imaging Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Diurnal measurements of ozone, UV surface radiation, clouds and aerosols.	25-35 km	25000m	Whole Earth	\N	\N	317 - 799 nm in 10 channels
691	EGG	3-Axis Electrostatic Gravity Gradiometer	No longer operational		Gradiometer/accelerometer	Other	Open Access	\N	Main objective to measure the 3 components of the gravity-gradient tensor (i.e. gradiometer data).	\N	\N	\N	\N	\N	\N
148	EHIC	Energetic Heavy Ion Composition Experiment	No longer operational		Space environment monitor	Sounding	\N	\N	Energetic Heavy Ion Composition Experiment., Designed to measure the chemical and isotopic composition of energetic particles between Hydrogen and Nickel over the energy ranges 0.5 to 200 MeV/nucleon.	\N	\N	\N	\N	\N	\N
294	ENVISAT Comms	Communications package on ENVISAT	No longer operational		\N	Sounding	\N	\N	Communication package onboard ENVISAT series satellites.	\N	\N	\N	\N	\N	\N
709	EMA	Electric, Magnetic, fields Analyser	No longer considered		Magnetometer	Other	\N	\N	Study of perturbations in the atmosphere and ionosphere caused by electromagnetic waves, shorterm earthquake prediction.	\N	\N	\N	\N	\N	\N
170	DRT-S&R	DRT-S&R	Operational		Data collection system	Sounding	Constrained Access	\N	Relay of search and rescue information.	\N	\N	\N	\N	\N	\N
843	ECHO-V	ECHO-V	No longer operational		Space environment monitor	TBD	\N	\N		\N	\N	\N	\N	\N	Ee 3 - 30 MeV, Ee 30 - 100 MeV
862	EFI	Electric Field Instrument	Operational		Electric field sensor	Other	Open Access	\N	Thermal ion imager and Langmuir probe to measure ion temp, electron temp, ion density, electron density, spacecraft potential and ion incident angle.	0.3 mV/m	\N	N/A	\N	<3 mV/m	N/A
1714	ECOSTRESS	ECOsystem Spaceborne Thermal Radiometer Experiment on Space Station	Being developed		High-resolution nadir-scanning IR spectrometer	\N	Open Access	TBD	This project will use a high-resolution thermal infrared radiometer to measure plant evapotranspiration, the loss of water from growing leaves and evaporation from the soil.	\N	\N	\N	\N	\N	TIR
774	DPR	Dual-frequency Precipitation Radar	Operational	Medium Heritage	Cloud and precipitation radar	Other	Open Access	HDF-EOS(HDF5)	Measures precipitation rate classified by rain and snow, in latitudes up to 65 degrees.	Range resolution: 125m (NS, MS mode), 250m (HS mode), \nHorizontal resolution: 5 km at nadir	\N	245 km (Ku-band), 125 km (Ka band)	\N	Rainfall rate 0.2 mm/h	Microwave: 13.6 GHz (Ku band) and 35.5 GHz (Ka band)
842	DRF	DRF	No longer operational		\N	TBD	\N	\N		\N	\N	\N	\N	\N	UV: 0.2 - 0.35 µm, Ee > 30 keV, Ep > 7 keV
1508	DORIS-NG (SPOT)	Doppler Orbitography and Radio-positioning Integrated by Satellite-NG (on SPOT)	No longer operational		Radio-positioning system	Sounding	Open Access	\N	Precise orbit determination; Real time onboard orbit determination (navigation).	\N	\N	\N	\N	Orbit error ~1 cm	\N
285	EFO-2	EFO-2	No longer considered		\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
389	DORIS	Doppler Orbitography and Radio-positioning Integrated by Satellite	No longer operational		Radio-positioning system	Sounding	\N	\N	Orbit determination.	\N	\N	\N	\N	Orbit error ~2.5 cm	\N
1734	DESIS	DLR Earth Sensing Imaging Spectrometer	TBD		Medium-resolution spectro-radiometer	Imaging	\N	\N	DESIS is a hyperspectral camera that records image data using an array of up to 240 closely spaced channels, covering the visible and near infrared portions of the spectrum (450 to 915 nanometres) with a ground resolution of approximately 90 metres. This multifaceted information allows scientists to detect changes in ecosystems and to make statements on the condition of forests and agricultural land.	79m/104m @330 km/435km orbit (min/max)	79m	44km/57km @330 km/435km orbit (min/max)	57 km	\N	Spectral range: 450nm – 950nm (400 - 1000nm)\n\nSpectral sampling: ≈ 2.32nm\n\nSpectral channels: 240 (without binning)
236	DOPI	DOPI	No longer operational		\N	Sounding	\N	\N	Measurement of atmospheric optical properties in the IR range.	\N	\N	\N	\N	\N	\N
1507	DORIS (SPOT)	Doppler Orbitography and Radio-positioning Integrated by Satellite (on SPOT)	No longer operational		Radio-positioning system	Sounding	\N	\N	Orbit determination.	\N	\N	\N	\N	Orbit error ~2.5 cm	\N
1669	DDMI (CYGNSS)	Delay Doppler Mapping Instrument (DDMI)	Being developed		GNSS receiver	Other	Open Access	TBD	Constellation of bistatic radar receivers using GPS satellite transmitters to detect ocean surface roughness and estimate near-surface wind speed from calm sea through hurricane force conditions and under all levels of precipitation.	20-50 km (variable in ground processing)	20000m	Field of view of potential GPS specular point contacts extends 740 km cross-track in both port and starboard directions.	1480 km	wind speed RMS retrieval uncertainty: 2 m/s for winds less than 20 m/s and 10% for winds greater than 20 m/s	Microwave: 1.575 GHz
957	DCS (SAC-D)	Data Collection System	No longer operational		Data collection system	Other	Constrained Access	Database/Table	Environmental and meteorological data collection from ground platforms (UHF 401.55 MHz uplink).	\N	\N	\N	\N	\N	\N
219	BUFS-4	Backscatter spectrometer/4	No longer considered		High-resolution nadir-scanning SW spectrometer	Sounding	\N	\N	Atmospheric ozone profile measurements.	\N	\N	\N	\N	\N	UV: 12 channels (250 - 340 nm)
775	DELTA-2D	Multispectral microwave scanning radiometer	No longer operational		Multi-purpose imaging MW radiometer	Other	\N	\N	Scanning microwave radiometer for measurement of emissive microwave radiation at atmosphere/ sea surface interface.	20 - 100km depending on frequency	\N	1100 km	\N	0.1 - 0.15 K error	Microwave: 0.8 cm, 1.35 cm, 2.2 cm, 4.3 cm
181	DORIS-NG	Doppler Orbitography and Radio-positioning Integrated by Satellite-NG	Operational		Radio-positioning system	Sounding	Open Access	SP1 and SINEX	Precise orbit determination; Real time onboard orbit determination (navigation).	\N	\N	\N	\N	Orbit error ~1 cm	\N
955	DCS (SAC-C)	Data Collection System	No longer operational		Data collection system	Other	Constrained Access	\N	DCS is able to receive data from 200 meteorological and environmental stations for re-transmission of all the data to Cordoba Ground Station.	\N	\N	\N	\N	\N	\N
1505	DCS	Data Collecting System	No longer considered	High Heritage - Operational	Data collection system	Other	\N	\N	Support to Data Collection Platforms.	\N	\N	\N	\N	\N	\N
1635	DCS (SABIA_MAR)	Data Collection System	Proposed		Data collection system	Other	\N	\N	Environmental and meteorological data collection from ground platforms (UHF 401.62 MHz uplink / S-band downlink).	N/A	\N	N/A	\N	N/A	N/A
135	DCS (NOAA)	Data Collection System (NOAA)	No longer operational	High Heritage - Operational	Data collection system	Sounding	\N	\N	Collects data on temperature (air/water), atmospheric pressure, humidity and wind speed/direction, speed and direction of ocean and river currents.	\N	\N	\N	\N	\N	\N
954	DCS (GOES-R)	Data Collection System (NOAA, GOES-R)	Approved	High Heritage - Non-Operational	Data collection system	TBD	\N	\N	Collects data on temperature (air/water), atmospheric pressure, humidity and wind speed/direction, speed and direction of ocean and river currents.	\N	\N	\N	\N	\N	\N
822	DCS	Data Collecting System Transponder	Operational	High Heritage - Operational	Data collection system	Other	Open Access	\N	Data collection and communication.	\N	\N	\N	\N	\N	\N
758	DCS	Data Collecting System Transponder	Operational	Medium Heritage	Data collection system	Other	Open Access	\N	Data collection and communication.	\N	\N	\N	\N	\N	\N
1511	CZS	Coastal Zone Scanner	Approved	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Coastal zone data, estimation of phytoplankton concentration.	80 m	80m	800 km	800 km	\N	0.4 - 0.79 µm, 4 channels
799	DCS	Data Collection System	Operational	High Heritage - Operational	Data collection system	TBD	Constrained Access	\N	Collects data on temperature (air/water), atmospheric pressure, humidity and wind speed/direction, speed and direction of ocean and river currents.	\N	\N	\N	\N	\N	\N
970	DCS	Data Collecting System	No longer considered	High Heritage - Operational	Data collection system	Other	\N	\N	Support to Data Collection Platforms.	\N	\N	\N	\N	\N	\N
188	DCS (JAXA)	Data Collection System (JAXA)	No longer operational		Data collection system	Sounding	\N	\N	Data Collection System, Receives in-situ data from data collection platforms worldwide and transmits to ground station.	\N	\N	\N	\N	\N	\N
163	DCP	Data Collecting Platform Transponder	No longer operational		Data collection system	Sounding	\N	\N	Data collection and communication.	\N	\N	\N	\N	\N	\N
828	CZI	Coastal Zone Imager	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Imagery of coastal regions - estuaries, tidal regions, etc.	250 m	250m	500 km	500 km	\N	B1: 0.433 - 0.453, B2: 0.555 - 0.575, B3: 0.655 - 0.675, B4: 0.675 - 0.695 μm
1519	CSG SAR	COSMO-SkyMed di Seconda Generazione SAR	Approved		Imaging radar (SAR)	Imaging	Constrained Access	HDF5,\nGeoTiff,\nGML JPEG2000,\nSTANAG 4545	All-weather images of ocean, land and ice for monitoring of land surface processes, ice, environmental monitoring, risk management, environmental resources, maritime management, Earth topographic mapping.	[range x azimuth]\nSpotlight: 0.5x0.35 or 0.63x0.63 m (Single/Dual pol), \nStripmap: 3x3 m (Single/Dual/Quad pol), ScanSAR: 4x20 or 6x40 m (Single/Dual pol)	0.35m	'Dual polarisation modes: Spotlight [range x azimuth]: 7.3x3.1 or 10x10 km, Stripmap: 40 km, ScanSAR: 100 or 200 km.\nQuad polarisation mode: 15 km.	200 km	-	Microwave: X-band (9.6 GHz) single-, dual- and quad- polarization
990	CSC FVM	CSC fluxgate vector magnetometer	Operational		Magnetometer	TBD	Open Access	\N	Measurements of the strength and direction of the Earth's magnetic field.	\N	\N	\N	\N	\N	\N
325	CrIS	Cross-track Infrared Sounder	Operational	Medium Heritage	Medium-resolution IR spectrometer	Sounding	\N	HDF-5	Daily measurements of vertical atmospheric distribution of temperature, moisture, and pressure.	IFOV 14 km diameter, 1 km vertical layer resolution	\N	2200 km	\N	Temperature profiles: to 0.9 K, Moisture profiles: 20 - 35%, Pressure profiles: 1%	MWIR - TIR: 3.92 - 4.4 µm, 5.7 - 8.62 µm, 9.1 - 14.7 µm, 1300 spectral channels
1523	COSI	Corea SAR Instrument	Operational	High Heritage - Operational	Imaging radar (SAR)	Imaging	Very Constrained Access	HDF	SAR for land applications of cartography and disaster monitoring.	High: 1 m	1m	100 km	100 km	\N	microwave
1767	CZCS	Coastal Zone Color Scanner	No longer operational		\N	\N	\N	\N		\N	\N	\N	\N	\N	\N
649	CPR (CloudSat)	Cloud Profiling Radar	Operational		Cloud and precipitation radar	Sounding	Open Access	HDF-EOS	Primary goal to provide data needed to evaluate and improve the way clouds are represented in global climate models. Measures vertical profile of clouds.	Vertical: 500 m, Cross-track: 1.4 km, Along-track: 2.5 km	\N	Instantaneous Footprint < 2 km	\N	detects ice clouds optical depth >1, water clouds optical depth >3, ice content to +100%, -50%, liquid content to <50%, in-cloud heating to within 1K day-1 km-1	Microwave: 94 GHz
372	CPR (EarthCARE)	Cloud Profiling Radar (EarthCARE)	Being developed	Low Heritage	Cloud and precipitation radar	Other	No Access	HDF5	Measurement of cloud properties, light precipitation, vertical motion.	Range resolution: 500m (100m sample)\nHorizontal resolution: 800m  (500m sample)	\N	\N	\N	\N	Microwave: 94 GHz
909	COBAN	COBAN 8 Band multispectral camera 	No longer operational		\N	Imaging	\N	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	120 m	\N	\N	\N	\N	Band 1: 375 - 425 nm; Band 2: 410 - 490 nm; Band 3: 460 - 540 nm; Band 4: 510 - 590 nm; Band 5: 560 - 640 nm; Band 6: 610 - 690 nm; Band 7: 660 - 740 nm; Band 8: 850 - 1000 nm
1534	CO2 and O2 LIDAR (ASCENDS)	Combined CO2 and O2 column absorption LIDAR (ASCENDS)	Proposed	Low Heritage	Atmospheric lidar	Other	Open Access	\N	Measure the number density of Carbon Dioxide (CO2) in the column. Measure length of the column using a laser altimeter and measure ambient air pressure and temperature.	\N	\N	200 m	\N	1 ppm CO2; 2 K for temperature	1.57 µm
745	COALA	Calibration for Ozone through Atmospheric Limb Acquisitions\r\nfor Ozone through Atmospheric Limb Acquisitions	No longer considered		\N	Other	\N	\N	Atmospheric ozone profiles.	\N	\N	\N	\N	\N	\N
680	CMIS	Conical-scanning Microwave Imager/Sounder	No longer considered	Medium Heritage	Multi-purpose imaging MW radiometer	Sounding	\N	\N	Collects microwave radiometry and sounding data. Data types include atmospheric temperature and moisture profiles, clouds, sea surface winds, and all-weather land/water surfaces.	15 - 50 km depending on frequency	\N	1700 km	\N	Temperature Profiles to  1.6 K, water vapour 20%	Microwave: 190 GHz
623	Communications payload (Ka and UHF band)	Communications payload (Ka and UHF band)	No longer operational		\N	Other	\N	\N		\N	\N	\N	\N	\N	up 313.55 MHz, down 400.4 MHz
1535	CO Sensor (ASCENDS)	CO Sensor (ASCENDS)	Proposed	Medium Heritage	Absorption-band MW radiometer/spectrometer	TBD	Open Access	\N	Measure the total column CO concentration.	\N	\N	200 m	\N	\N	2.3 µm
1739	COMIS	COMpact Imaging Spectrometer	Operational		\N	\N	\N	\N	Land use assessments	28m	28m	28 km	28 km	\N	0.4～1.05um
827	COCTS	China Ocean Colour & Temperature Scanner	No longer operational		Medium-resolution spectro-radiometer	Imaging	\N	\N	Ocean chlorophyll, ocean yellow substance absorbance, Sea-ice surface temperature.	1.1 km	\N	3083 km	\N	\N	B1: 0.402 - 0.422 µm, B2: 0.433 - 0.453 µm, B3: 0.480 - 0.500 µm, B4: 0.510 - 0.530 µm, B5: 0.555 - 0.575 µm, B6: 0.660 - 0.680 µm, B7: 0.740 - 0.760 µm, B8: 0.845 - 0.885 µm, B9: 10.30 - 11.40 µm, B10: 11.40 - 12.50 µm
1701	CLARA	Compact Lightweight Absolute Radiometer	Proposed		Solar irradiance monitor	\N	\N	\N	CLARA is a scientific instrument that will be used to determine the total solar irradiance of the Sun.	\N	\N	\N	\N	\N	\N
1736	CLARREO Pathfinder Reflected Solar	CLARREO Pathfinder - RS	Proposed		Multi-purpose imaging Vis/IR radiometer	Other	Open Access	\N	Measuring key climate change variables such as global and zonal mean surface temperature, tropospheric lapse rate and humidity, cloud fraction, snow and ice cover, and aerosol optical depth.	340 m.	\N	10 deg (67 km).	\N	Absolute uncertainty goal is identical to CLARREO Mission Requirement of 0.3% (k=2) in reflectance.	400 to 2300 nm at 4-nm sampling interval with 8-nm resolution.
1666	CIRC	Compact InfraRed Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GeoTIFF	Active fire detection. Land surface temperature.	210m	210m	128 km	128 km	0.2 K@300 K	TIR: 8 - 12 µm
660	CLAES	Cryogenic Limb Array Etalon Spectrometer instrument	No longer operational		Limb-scanning IR spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
1530	Cloud Radar	Cloud radar (ACE)	Proposed	Medium Heritage	Cloud and precipitation radar	Imaging	Open Access	HDF	Radar measurement for cloud droplets and precipitation.	Vertical: 250 m, Cross-track: 1.4 km, Along-track: 2.5 km	\N	Instantaneous Footprint < 1 km	\N	TBD	Dual frequency: 35 and 94 GHz
1782	CIRC	Compact InfraRed Camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GeoTIFF	Active fire detection. Land surface temperature. CIRC on ISS is a sub-payload of the Calorimetric Electron Telescope (CALET).	130m	130m	128 km	128 km	0.2 K@300 K	TIR: 8 - 12 µm
814	Cloud Sensor	Cloud and aerosol sensor	No longer considered		\N	TBD	\N	\N		\N	\N	\N	\N	\N	\N
720	CHRIS	Compact High Resolution Imaging Spectrometer	Operational		High resolution optical imager	Imaging	Open Access	\N	Supports a range of land, ocean and atmospheric applications, including agricultural science, forestry, environmental science, atmospheric science and oceanography.	36 m or 18 m depending on wavebands selected.	18m	14 km	14 km	S/N 200 @ target albedo of 0.2. 12 bits digitisation.	VIS - NIR: 400 - 1050 nm (63 spectral bands at a spatial resolution of 36 m; or 18 bands at full spatial resolution (18 m))
1646	CERES-C	Cloud and the Earth's Radiant Energy System-Continuation	No longer considered		Broad-band radiometer	Imaging	\N	\N	Long term measurement of the Earth's radiation budget and atmospheric radiation from the top of the atmosphere to the surface; provision of an accurate and self-consistent cloud and radiation database.	20 km	\N	\N	\N	0.5%, 1%, 0.3% (respectively for the 3 channels)(TBC)	3 channels: 0.3-5 µm, 0.3 - 100 µm, 8 - 12 µm (TBC)
207	Chaika	Scanning IR radiometer	No longer operational		\N	Sounding	\N	\N	Scanning IR radiometer.	\N	\N	\N	\N	\N	\N
1656	CER	Coherent Electromagnetic Radio Tomography	Operational		Space environment monitor	Other	Open Access	\N	Radio transmission from e-POP to ground for radio propagation and ionospheric scintillation measurements.	N/A	\N	N/A	\N	\N	N/A
787	CCD camera	Charged Coupled Device Camera	Operational		High resolution optical imager	Imaging	Open Access	\N	Cloud and vegetation monitoring.	1 x 1 km	1000m	Normal: 6000 (N-S) X 6000 km (E-W) anywhere on earth disc, Program: 6000 (N-S) X (n X 300) km (E-W): n and number of frames programmable	\N	\N	VIS: 0.62 - 0.68 µm; NIR: 0.77 - 0.86 µm; SWIR: 1.55 - 1.69 µm
432	CHAMP GPS Sounder	GPS TurboRogue Space Receiver (TRSR)	No longer operational	High Heritage - Operational	GNSS radio-occultation receiver	Sounding	Open Access	\N	Temperature and water vapour profiles.	\N	\N	\N	\N	\N	\N
431	CHAMP Magnetometry Package (1 Scalar + 2 Vector Magnetometer)	Overhauser Magnetometer and Fluxgate Magnetometer	No longer operational	High Heritage - Operational	Magnetometer	Sounding	Open Access	\N	Earth magnetic field measurements.	\N	\N	\N	\N	\N	\N
397	CERES	Cloud and the Earth's Radiant Energy System	Operational		Broad-band radiometer	Imaging	Open Access	HDF and NetCDF	Long term measurement of the Earth's radiation budget and atmospheric radiation from the top of the atmosphere to the surface; provision of an accurate and self-consistent cloud and radiation database.	20 km	\N	\N	\N	0.5%, 1%, 0.3% (respectively for the 3 channels)	3 channels: 0.3-5 µm, 0.3 - 100 µm, 8 - 12 µm
430	CHAMP Gravity Package (Accelerometer+GPS)	STAR Accelerometer	No longer operational	High Heritage - Operational	Gradiometer/accelerometer	Sounding	Open Access	\N	Earth gravity field measurements.	\N	\N	\N	\N	\N	\N
823	CCD (HJ)	CCD camera	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Multispectral measurements of Earth's surface for natural enviroment and disaster applications.	30 m	30m	360 km (per set), 720 km (two sets)	720 km	\N	0.43 - 0.90 µm (4 bands)
1762	CAR	High Resolution Camera	Approved	Low Heritage	High resolution optical imager	Imaging	\N	\N	Panchromatic and multispectral (Vis/IR) measurements with high spatial resolution, with stereo capability for DEM generation. Applications in emergencies in general, agriculture, land use/land cover, change detection, urban environment, cartography, topography.	Panchromatic band: 1 m\nVis/IR bands: 4 m	1m	12 km	12 km	Absolute radiometric accuracy: 5%	Panchromatic band\n - P:  450-900 nm\nVis/IR bands\n - B1: 450-520 nm\n - B2: 520-590 nm\n - B3: 630-690 nm\n - B4: 770-890 nm
409	CCD	High Resolution CCD Camera	No longer operational	Medium Heritage	High resolution optical imager	Imaging	\N	\N	Measurements of cloud type and extent and land surface reflectance, and used for global land surface applications.	20 m	20m	113 km	113 km	\N	VIS: 0.45 - 0.52 µm, 0.52 - 0.59 µm, 0.63 - 0.69 µm, NIR: 0.77 - 0.89 µm, PAN: 0.51 - 0.71 µm
956	CARMEN-1 (ICARE)	Influence of Space Radiation on Advanced Components	No longer operational		Space environment monitor	TBD	Constrained Access	\N	Studying space environment effects.	\N	\N	\N	\N	\N	\N
806	CARMEN-1 (SODAD)	Orbital System for an Active Detection of Debris	No longer operational		Space environment monitor	Other	Constrained Access	\N	Space debris studies.	\N	\N	\N	\N	\N	\N
1657	CCD (ZY-1-02C and ZY-3)	CCD and multispectral imager	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Very Constrained Access	\N	Earth resources, environmental monitoring, land use.	2.36m (ZY-1-02C HR)\n2.1m(ZY-3)	2.1m	52km(ZY-3)\n54km(ZY-1-02C)	54 km	\N	0.5-0.8 µm
1735	CATS	Cloud-Aerosol Transport System	Operational		Atmospheric lidar	Sounding	Open Access	HDF-5	cloud and aerosol lidar profiling	60 m vertical by 350 horizontal, from 0 - 30 km	\N	350 m along-track	\N	\N	532 and 1064 nm (polarization sensing at both)
939	C-Band SAR	C-Band Synthetic Aperture Radar	Operational		Imaging radar (SAR)	Imaging	Open Access	\N	Marine core services, land monitoring and emergency services. Monitoring sea ice zones and arctic environment. Surveillance of marine environment, monitoring land surface motion risks, mapping of land surfaces (forest, water and soil, agriculture), mapping in support of humanitarian aid in crisis situations.	Strip mode: 9 m, Interferometric wide swath mode: 20 m, extra-wide swath mode: 50 m, wave mode: 50 m	9m	Strip mode: 80 km; Interferometric wide swath mode: 250 km, extra-wide swath mode: 400 km, Wave mode: sampled images of 20 x 20 km at 100 km intervals	400 km	NESZ: -22 dB; PTAR: -25 dB; DTAR: -22 dB; Radiometric accuracy 1 dB (3 sigma); Radiometric stability: 0.5 dB (3 sigma)	C-band: 5.405 GHz; HH, VV, HH+HV, VV+VH; Incidence angle: 20-45
212	BUFS-2	Backscatter spectrometer/2	No longer operational		High-resolution nadir-scanning SW spectrometer	Sounding	\N	\N	Atmospheric ozone profile measurements.	\N	\N	\N	\N	\N	UV: 12 channels (250 - 340 nm)
1751	BRLK X-range	X-band Synthetic Aperture Radar	Approved		Imaging radar (SAR)	Imaging	Constrained Access	\N	Disaster monitoring, sea surface monitoring, information support of environmental managment	1-500 m	1m	10-750 km	750 km	\N	X-band
820	CALIOP	Cloud-Aerosol Lidar with Orthogonal Polarization	Operational		Atmospheric lidar	Sounding	Open Access	HDF	Two-wavelength, polarisation lidar capable of providing aerosol and cloud profiles and properties.	Vertical sampling: 30 m, 0 – 40 km	\N	333 m along-track	\N	5% (532 nm)	532 nm (polarization-sensitive), 1064 nm, VIS - NIR
921	C/X SAR	SAR	No longer considered		Imaging radar (SAR)	Imaging	\N	\N	Disaster management, mainly to overcome problems of cloud during observation, most useful for flood and cyclone.	\N	\N	\N	\N	\N	C/X Band
652	BUV	Backscatter Ultraviolet instrument	No longer operational		High-resolution nadir-scanning SW spectrometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
226	BTVK	Scanning television radiometer	No longer operational		\N	Imaging	\N	\N	Images of cloud cover, Earth's surface and snow and ice fields.	VIS: 1.5 km, TIR: 8 km	\N	Full Earth disk	\N	\N	VIS: 0.4 - 0.7 µm, TIR: 10.5 - 12.5 µm
287	BNR (280k)	BNR (280k)	No longer considered		\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
910	BILSAT VNIR Panchromatic	BILSAT VNIR Panchromatic camera	No longer operational		High resolution optical imager	Imaging	\N	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	12.6 m	\N	55 km	\N	\N	0.45 - 0.90 µm
911	BILSAT VNIR Multispectral	BILSAT VNIR Multispectral camera	No longer operational		High resolution optical imager	Imaging	\N	\N	High resolution images for monitoring of land surface and coastal processes and for agricultural, geological and hydrological applications.	27.6 m	\N	55 km	\N	\N	Band 1: 0.45 - 0.52  µm, Band 2: 0.52 - 0.60  µm, Band 3: 0.63 - 0.69  µm, Band 4: 0.76 - 0.90  µm
1750	BRLK S-range	S-band Synthetic Aperture Radar	Approved		Imaging radar (SAR)	Imaging	Constrained Access	\N	Disaster monitoring, sea surface monitoring, information support of environmental managment	1-12 m	1m	10-100 km	500 km	\N	S-band
1756	BIK-SD 1	High resolution wide capture multispectral infraredoptical sensor	Proposed		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Provides a simultaneous taking of images of an object in several spectral bands of thermal range with detection and registration of land-based, subsurface-based and space-based objects.	20 - 23.5 m	20m	120 km	185 km	\N	3.5 - 4.1 µm; 8.1 - 8.45 µm; 8.45 - 8.80 µm; 8.90 - 9.25 µm; 10.3 - 11.3 µm; 11.5 - 12.5 µm
284	BRIZ	BRIZ	No longer considered		\N	Sounding	\N	\N		\N	\N	\N	\N	\N	\N
900	BRLK	X-band Synthetic Aperture Radar	Operational		Imaging radar (SAR)	Imaging	Constrained Access	\N	Land and sea surface monitoring	350-1000 m	350m	450 km	450 km	\N	X-band
225	BRK	On board retransmission complex	No longer operational		Communications system	Sounding	\N	\N	Data collection and retransmission.	\N	\N	\N	\N	\N	\N
248	Balkan-2 lidar	Balkan-2 lidar	No longer operational		Atmospheric lidar	Sounding	\N	\N	Lidar operating in lidar and range finding modes.	\N	\N	\N	\N	\N	\N
937	BBR (EarthCARE)	BroadBand Radiometer (EarthCARE)	Approved		Broad-band radiometer	Imaging	Open Access	HDF5	Top of the atmosphere radiances and radiative flux.	10 x 10 km ground pixel size for each of the three views	\N	\N	\N	flux retrieval accuracy 10 Wm-2	Shortwave channel: 0.2 - 4 µm, Total channel 0.2 - 50 µm
363	AVNIR-2	Advanced Visible and Near Infra-red Radiometer type 2	No longer operational	Medium Heritage	High resolution optical imager	Imaging	\N	\N	High resolution multi-spectral imager for land applications which include environmental monitoring, agriculture and forestry, disaster monitoring.	10 m	10m	70 km	70 km	Surface Resolution:10 m (Nadir)\nRadiometric: Band1-3 3%RMS, Band4 7%RMS	VIS: 0.42 - 0.50 µm, 0.52 - 0.60 µm, 0.61 - 0.69 µm, NIR: 0.76 - 0.89 µm
282	Balkan-1	Balkan-1	No longer operational		Atmospheric lidar	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
460	AWiFS	Advanced Wide Field Sensor	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Vegetation and crop monitoring, resource assessment (regional scale), forest mapping, land cover/ land use mapping, and change detection.	55 m	55m	740 km	740 km	10 bit data	VIS: 0.52 - 0.59 µm and 0.62 - 0.68 µm, NIR: 0.77 - 0.86 µm, SWIR: 1.55 - 1.7 µm
405	AWFI	Advanced Wide Field Imager	No longer operational	Medium Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	GEOTIFF	Used for fire extent detection measurement, coastal and vegetation monitoring, land cover and land use mapping.	VIS - NIR: 40 m	40m	740 km	740 km	\N	VIS: 0.45 - 0.50 µm, 0.52 - 0.57 µm, 0.63 - 0.69 µm, NIR: 0.76 - 0.90 µm
324	AVHRR/4	Advanced Very High Resolution Radiometer/4	No longer considered		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N		\N	\N	\N	\N	\N	\N
358	AVNIR	Advanced Visible and Near Infrared Radiometor	No longer operational		High resolution optical imager	Imaging	\N	\N	High resolution multi-spectral imager for land applications which include environmental monitoring, agriculture and forestry, disaster monitoring.	16 m (multi), 8 m (pan)	8m	80km	80 km	\N	VIS (~0.40 µm - ~0.75 µm)
408	ATSR-2	Along Track Scanning Radiometer - 2	No longer operational		Multi-channel/direction/polarisation radiometer	Imaging	Open Access	\N	Measurements of sea surface temperature, land surface temperature, cloud top temperature and cloud cover, aerosols, vegetation, atmospheric water vapour and liquid water content.	IR ocean channels: 1 x 1 km, Microwave near-nadir viewing: 20 km instantaneous field of view	\N	500 km	\N	Sea surface temperature to <0.5 K over 0.5 x 0.5 deg (lat/long) area with 80% cloud cover, Land surface temperature: 0.1 K	VIS - SWIR: 0.65 µm, 0.85 µm, 1.27 µm, and 1.6 µm, SWIR-TIR: 1.6 µm, 3.7 µm, 11 µm and 12 µm, Microwave: 23.8 GHz, 36.5 GHz (bandwidth of 400 MHz)
383	ATSR/M	ATSR/M	No longer operational		Non-scanning MW radiometer	Imaging	Open Access	\N	Belongs to ATSR payload on board ERS1 and ERS2.	\N	\N	\N	\N	\N	\N
403	AVHRR/3	Advanced Very High Resolution Radiometer/3	Operational	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Measurements of land and sea surface temperature, cloud cover, snow and ice cover, soil moisture and vegetation indices. Data also used for volcanic eruption monitoring.	1.1 km	1100m	3000 km approx, Ensures full global coverage twice daily	\N	\N	VIS: 0.58 - 0.68 µm, NIR: 0.725 - 1.1 µm, SWIR: 1.58 - 1.64 µm, MWIR: 3.55 - 3.93 µm, TIR: 10.3 - 11.3 µm, 11.5 - 12.5 µm
407	ATSR	Along Track Scanning Radiometer	No longer operational		Multi-channel/direction/polarisation radiometer	Imaging	\N	\N	Measurements of sea surface temperature, land surface temperature, cloud top temperature and cloud cover, aerosols, vegetation, atmospheric water vapour and liquid water content.	\N	\N	\N	\N	\N	\N
310	AVHRR/2	Advanced Very High Resolution Radiometer/2	No longer operational		Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Measurements of land and sea surface temperature, cloud cover, snow and ice cover, soil moisture and vegetation indices. Data also used for volcanic eruption monitoring.	1.1 km	\N	3000 km approx	\N	\N	VIS: 0.58 - 0.68 µm, NIR: 0.725 - 1.1 µm, MWIR: 3.55 - 3.93 µm, TIR: 10.3 - 11.3 µm, 11.5 - 12.5 µm
276	ATOVS (HIRS/3 + AMSU + AVHRR/3)	Advanced TIROS Operational Vertical Sounder	Operational	High Heritage - Operational	\N	Sounding	\N	\N	Advanced TIROS Operational Vertical Sounder instrument suite.	\N	\N	\N	\N	\N	\N
933	ATCOR	Atmospheric correction	Proposed		High resolution optical imager	Imaging	Constrained Access	\N	Atmospheric correction.	240 m	40m	925 km	925 km	\N	VNIR Hyperspectral
374	ATLID	ATmospheric LIDar	Approved		Atmospheric lidar	Sounding	Open Access	HDF5	Derivation of cloud and aerosol properties - Measurement of molecular and particle backscatter in Rayleigh, co-polar and cross-polar Mie channels.	300 m horizontal (TBC)	\N	\N	\N	\N	Laser at 355 nm
416	ASTER	Advanced Spaceborne Thermal Emission and Reflection Radiometer	Operational		High resolution optical imager	Imaging	Open Access	HDF-EOS or GeoTiff	Surface and cloud imaging with high spatial resolution, stereoscopic observation of local topography, cloud heights, volcanic plumes, and generation of local surface digital elevation maps. Surface temperature and emissivity. ASTER SWIR detectors are no longer functioning due to anomalously high SWIR detector temperatures. ASTER SWIR data acquired since April 2008 are not useable, and show saturation of values and severe striping. All attempts to bring the SWIR bands back to life have failed, and no further action is envisioned.	VNIR: 15 m, stereo: 15 m horizontally and 25 m vertical, SWIR: 30 m, TIR: 90 m	15m	60 km	60 km	VNIR and SWIR: 4% (absolute), TIR: 4 K, Geolocation: 7 m	VIS and NIR: 3 bands in 0.52 - 0.86 µm, SWIR: 6 bands in 1.6 - 2.43 µm, TIR: 5 bands in 8.125 - 11.65 µm
1616	ASI	Atmospheric Sounding Interferometer	Prototype		\N	Sounding	Constrained Access	\N	Atmospheric sounding for weather forecasting.	\N	\N	\N	\N	\N	\N
308	ASCAT	Advanced Scatterometer	Operational		Radar scatterometer	Sounding	Open Access	Native and BUFR	Measures wind speed and direction over ocean, soil moisture, sea ice cover, sea ice type, snow cover and snow parameters and vegetation parameters	Hi-res mode: 25 - 37 km, Nominal mode: 50 km	\N	Continuous; 2 x 500 km swath width	\N	Wind speeds in range 4 - 24 m/s: 2 m/s and direction accuracy of 20 deg	Microwave: C Band, 5.256 GHz
413	ATMS	Advanced Technology Microwave Sounder	Operational	Medium Heritage	Absorption-band MW radiometer/spectrometer	Sounding	Open Access	HDF-5	Collects microwave radiance data that when combined with the CrIS data will permit calculation of atmospheric temperature and water vapour profiles.	5.2 - 1.1 deg	\N	2300 km	\N	0.75 K - 3.60 K	Microwave: 22 bands, 23-184 GHz
859	ASM	Absolute Scalar Magnetometer	Operational		Magnetometer	Other	Open Access	\N	Absolute calibration of Vector Field Magnetometer on board Swarm satellites.	0.1 nT	\N	N/A	\N	0.1 nT	N/A
998	ATLAS	Advanced Topographic Laser Altimeter System	Being developed		Lidar altimeter	Imaging	Open Access	\N	Provide date on ice sheet height and sea ice thickness, land altitude, aerosol height distributions, cloud height and boundary layer height.	66 m spots separated by 170 m	66m	\N	\N	Aerosol profile: 20%, Ice elevation: 20 cm, Cloud top height: 75 m, Land elevation: 20 cm, geoid: 5 m	VIS-NIR: Laser emits at 1064 nm (for altimetry) and 532 nm (for atmospheric measurements)
261	ASAR (wave mode)	Advanced Synthetic Aperture Radar (Wave mode)	No longer operational		Imaging radar (SAR)	Imaging	Open Access	\N	Measurements of ocean wave spectra.	\N	\N	\N	\N	\N	\N
1599	Arkon-2M SAR	Arkon-2M SAR	No longer considered		Imaging radar (SAR)	Imaging	Constrained Access	\N	X, L, and R-band SAR instrument.	X-band 1 - 1.5m, L-band 3 - 5 m, R-band 30 m	1m	X-band 2 - 10 km, L-band 20 - 100 km, R-band 100 - 450 km	450 km	Radiometric resolution 1.2 - 3.5 dB	X-band – 3 cm, L-band – 23 cm, R-band – 69 cm
846	Arina	Arina	No longer operational	Medium Heritage	Space environment monitor	TBD	Constrained Access	\N	Insights into electromagnetic field variations as the precursors of earthquakes.	\N	\N	\N	\N	\N	\N
154	ARGOS-3	ARGOS-3	Operational		Data collection system	Sounding	Open Access	\N	Location data by Doppler measurements.	\N	\N	\N	\N	\N	UHF: 401 MHz, 467 MHz
694	ARGOS-4	ARGOS-4	Operational	High Heritage - Operational	Data collection system	Sounding	\N	\N	Data collection and communication system for receiving and retransmitting data from ocean and land-based remote observing platforms/transponders.	\N	\N	\N	\N	\N	UHF: 401 MHz, 467 MHz
344	ASAR	Advanced Synthetic-Aperture Radar	No longer operational		Imaging radar (SAR)	Imaging	Constrained Access	\N	All-weather images of ocean, land and ice for monitoring of land surface processes, sea and polar ice, sea state, and geological and hydrological applications. Has 2 stripmap modes (Image and Wave (for ocean wave spectra)) and 3 ScanSAR modes.	Image, wave and alternating polarisation modes: approx 30 x 30 m, Wide swath mode: 150 x 150 m, Global monitoring mode: 950 m x 950 m	30m	Image and alternating polarisation modes: up to 100 km, Wave mode: 5 km, Wide swath and global monitoring modes: 400 km or more	493 km	Radiometric resolution in range: 1.5 - 3.5 dB, Radiometric accuracy: 0.65 dB	Microwave: C-band, with choice of 5 polarisation modes (VV, HH, VV/HH, HV/HH, or VH/VV)
260	ASAR (image mode)	Advanced Synthetic Aperture Radar (Image mode)	No longer operational		Imaging radar (SAR)	Imaging	Constrained Access	\N	All-weather images of ocean, land and ice for monitoring of land surface processes, sea and polar ice, sea state, and geological and hydrological applications.	\N	\N	\N	\N	\N	\N
851	ARMA-M3	Equipment for radio occultation monitoring of the atmosphere	Approved	Low Heritage	GNSS radio-occultation receiver	Other	Constrained Access	\N	Atmospheric temperature and humidity profiles with high vertical resolution.	Sensing range of heights: 0.5 - 400 km	\N	\N	\N	\N	frequency ranges of GLONASS and GPS: 1227.6 - 1605.375 MHz
664	AMSR-E	Advanced Microwave Scanning Radiometer-EOS	No longer operational	High Heritage - Operational	Multi-purpose imaging MW radiometer	Imaging	Open Access	HDF4	Measurements of water vapour, cloud liquid water, precipitation, winds, sea surface temperature, sea ice concentration, snow cover and soil moisture. Instrument stopped functioning 4th October 2011.	5 - 50 km (dependent on frequency)	\N	1445 km	\N	Sea surface temperature: 0.5 K, Sea ice cover: 10%, Cloud liquid water: 0.05 kg/m2, Precipitation rate: 10%, Water vapour: 3.5 kg/m2 through total column, Sea surface wind speed 1.5 m/s	Microwave: 6.925 GHz, 10.65 GHz, 18.7 GHz, 23. 8 GHz, 36.5 GHz, 89.0 GHz
736	APS	Aerosol Polarimetry Sensor	No longer operational	Medium Heritage	Multi-channel/direction/polarisation radiometer	Imaging	Open Access	\N	Global distribution of natural and anthropogenic aerosols for quantification of the aerosol effect on climate, the anthropogenic component of this effect, and the long-term change of this effect caused by natural and anthropogenic factors.	10 km	\N	10 km	\N	AOT Ocean .02, land .04	9 bands: VIS and SWIR: 0.412 µm, 0.488 µm, 0.555 µm, 0.672 µm, 0.910 µm, 0.865 µm, 1.378 µm, 1.610 µm, 2.250 µm
985	Aquarius L-Band Scatterometer	Aquarius L-Band Scatterometer	No longer operational		Radar scatterometer	Other	Open Access	HDF-5	L-band scatterometer to provide roughness correction to brightness temperature.	100 km	\N	300 km	\N	0.2 psu	L-Band (1.2 GHz)
1555	AMSU-A	Advanced Microwave Sounding Unit-A	Operational	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	Open Access	HDF-EOS	All-weather night-day temperature sounding to an altitude of 45 km.	48 km	\N	2054 km	\N	Temperature profile: 2 K, humidity: 3 kg/m2, ice & snow cover: 10%	Microwave: 15 channels, 23.8 - 89.0 GHz
984	Aquarius L-Band radiometer	Aquarius L-Band Radiometer	No longer operational		Multi-purpose imaging MW radiometer	Other	Open Access	HDF-5	L-band passive microwave radiometer measures brightness temperature of ocean to retrieve salinity.	100 km	\N	300 km	\N	0.2 psu	L-band (1.4 GHz)
1772	APAN	Advanced PAN	Being developed		High resolution optical imager	Imaging	Constrained Access	\N	High-resolution images for the study of topography, urban areas, development of DTM, run-off models etc., urban sprawl, forest cover/timber volume, land use change.	1.25	\N	60 km	\N	50m	Panchromatic VIS: 0.45 - 0.90 µm
312	AMSU-A	Advanced Microwave Sounding Unit-A	Operational	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	All-weather night-day temperature sounding to an altitude of 45 km.	48 km	\N	2054 km	\N	Temperature profile: 2 K, humidity: 3 kg/m2, ice & snow cover: 10%	Microwave: 15 channels, 23.8 - 89.0 GHz
323	AMSU-B	Advanced Microwave Sounding Unit-B	Operational	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	\N	\N	All-weather night-day humidity sounding.	16 km	\N	2200 km	\N	Humidity profile: 1 kg/m2,	Microwave: 89 GHz, 150 GHz, 183.3± 1.0 GHz (2 bands), 183.3± 3.0 GHz (2 bands), 183.3± 7.0 GHz (2 bands)
1719	AMR-C	AMR-C Climate-quality microwave radiometer	Being developed		Non-scanning MW radiometer	Sounding	\N	\N	Capabilities of the AMR with the addition of high stability wet-tropospheric path delay correction.	25 km (high-resolution to support the SAR-mode of SRAL being assessed)	25m	Nadir-only viewing, associated to the JASON-CS radar altimeter	\N	\N	Microwave:  18.7, 23.8 and 34 GHz. The feasibility of an additional high-frequency component for high resolution support to the SAR mode of SRAL is being assessed
434	AMI/SAR/Wave	Active Microwave Instrumentation. Wave mode	No longer operational		Imaging radar (SAR)	Imaging	Open Access	\N	Measurements of ocean wave spectra.	30 m	30m	\N	\N	Sea surface wind speed: 3 m/s, Significant wave height: 0.2 m	Microwave: 5.3 GHz (C-band), VV polarisation
882	AMR	Advanced Microwave Radiometer	Operational		Non-scanning MW radiometer	Sounding	Open Access	NetCDF	Altimeter data to correct for errors caused by water vapour and cloud-cover. Also measures total water vapour and brightness temperature.	41.6 km at 18.7 GHz, 36.1 km at 23.8 GHz, 22.9 km at 34 GHz	\N	120 deg cone centred on nadir	\N	Total water vapour: 0.2 g/sq cm, Brightness temperature: 0.15 K	Microwave: 18.7 GHz, 23.8 GHz, 34 GHz
883	AMSR-2	Advanced Microwave Scanning Radiometer -2	Operational	High Heritage - Operational	Multi-purpose imaging MW radiometer	Imaging	Open Access	HDF5	Measurements of water vapour, cloud liquid water, precipitation, winds, sea surface temperature, sea ice concentration, snow cover, soil moisture.	5 - 50 km (dependent on frequency)	\N	1450 km (effective swath: 1618 km)	\N	Accuracy of Ver.2.1 products. (RMSE) Sea surface temperature: 0.58 K, Sea ice concentration: 8%, Cloud liquid water: 0.04 kg/m2, Water vapour: 1.5 kg/m2 through total column, Sea surface wind speed 1.1 m/s,  (Relative Error in %) Precipitation rate: 48% for ocean & 84% for land. (MAE) Snow depth: 16cm. Soil Moisture Content: 4%.	Microwave: 6.925 GHz, 7.3 GHz, 10.65 GHz, 18.7 GHz, 23.8 GHz, 36.5 GHz, 89.0 GHz
815	AMSR follow-on	Advanced Microwave Scanning Radiometer follow-on	No longer considered		Multi-purpose imaging MW radiometer	Imaging	\N	\N	Measurements of water vapour, cloud liquid water, precipitation, winds, sea surface temperature, sea ice concentration, snow cover, soil moisture.	5 - 50 km (dependent on frequency)	\N	1600 km	\N	Sea surface temparature: 0.5 K, Sea ice cover: 10%, Cloud liquid water: 0.05 kg/m2, Precipitation rate: 10%, Water vapour: 3.5 kg/m2 through total column, Sea surface wind speed 1.5 m/s	Microwave: 6.925 GHz, 10.65 GHz, 18.7 GHz, 23.8 GHz, 36.5 GHz, 50.3 GHz, 52.8 GHz, 89.0 GHz
435	AMI/Scatterometer	Active Microwave Instrumentation. Wind mode	No longer operational		Radar scatterometer	Imaging	Open Access	\N	Measurements of wind fields at the ocean surface, wind direction (range 0 - 360 deg), wind speed (range 1 - 30 m/s).	Cells of 50 x 50 km at 25 km intervals	\N	500 km	\N	Sea surface wind speed: 3 m/s, Sea ice type: 2 classes	Microwave: 5.3 GHz (C-band), VV polarisation
360	AMSR	Advanced Microwave Scanning Radiometer	No longer operational		Multi-purpose imaging MW radiometer	Imaging	\N	\N	Measurements of water vapour, cloud liquid water, precipitation, winds, sea surface temperature, sea ice concentration, snow cover, soil moisture.	5 - 50 km (dependent on frequency)	\N	1600 km	\N	Sea surface temparature: 0.5 K, sea ice cover: 10%, cloud liquid water: 0.05 kg/m2, precipitation rate: 10%, water vapour: 3.5 kg/m2 through total column, sea surface wind speed 1.5 m/s	Microwave: 6.925 GHz, 10.65 GHz, 18.7 GHz, 23.8 GHz, 36.5 GHz, 50.3 GHz, 52.8 GHz, 89.0 GHz
433	AMI/SAR/Image	Active Microwave Instrumentation. Image Mode	No longer operational		Imaging radar (SAR)	Imaging	Constrained Access	\N	All-weather images of ocean, ice and land surfaces. Monitoring of coastal zones, polar ice, sea state, geological features, vegetation (including forests), land surface processes, hydrology.	30 m	30m	100 km	100 km	Landscape topography: 3 m, Bathymetry: 0.3 m, Sea ice type: 3 classes	Microwave: 5.3 GHz, C band, VV polarisation, bandwidth 15.5 ± 0.06 MHz
678	ALT	Altimeter	No longer considered		Radar altimeter	Sounding	\N	\N	Obtains precise altimeter height measurements over world's oceans.	Along track 15 km	\N	15 km	\N	SST height 4 cm	13.6 GHz and 5.3 GHZ
235	ALISSA	Backscatter lidar	No longer operational		Atmospheric lidar	Sounding	\N	\N	Lidar instrument providing cloud altimetry, boundary layer, aerosols, cloud top altitude and aerosol backscatter data.	\N	\N	\N	\N	\N	\N
422	ALI	Advanced Land Imager	Operational		High resolution optical imager	Imaging	Open Access	HDF or GeoTIFF	Measurement of Earth surface reflectance. Will validate new technologies contributing to cost reduction and increased capabilities for future missions. ALI comprises a wide field telescope and multispectral and panchromatic instrument.	PAN: 10 m, VNIR and SWIR: 30 m	10m	185 km	185 km	SNR @ 5% surf refl Pan:220, Multi 1: 215, Multi 2: 280, Multi 3: 290, Multi 4:240, Multi 4':190, Multi 5':130, Multi 5:175, Multi 7:170 (prototype instrument exceeds ETM+ SNR by a factor of 4 - 8)	10 bands: VIS and NIR: 0.480 - 0.690 µm, 0.433 - 0.453 µm, 0.450 - 0.515 µm, 0.525 - 0.605 µm, 0.630 - 0.690 µm, 0.775 - 0.805 µm, 0.845 - 0.890 µm, 1.200 - 1.300 µm, SWIR: 1.550 - 1.750 µm, 2.080 - 2.350 µm
973	ALT	Radar Altimeter	Operational		Radar altimeter	Other	\N	\N	Global ocean topography, sea level and gravity field measurements.	16 km	\N	16 km	\N	< 4 cm	13.58 GHz and 5.25 GHz
1593	ALISEO	SAGNAC imaging spectrometer	No longer considered		Medium-resolution IR spectrometer	Imaging	Constrained Access	\N	Mutli-spectrometer data for complex land ecosystem studies.	10 m	8m	10 km	10 km	average spectral resolution: 5 nm	400 - 1000 nm
931	AltiKa	Ka-band Altimeter	Operational		Radar altimeter	Other	Constrained Access	\N	Sea surface height.	\N	\N	\N	\N	\N	35.5 - 36 GHz, passive channels (radiometer): 24 (K-band) and 37 (Ka-band) GHz; active radar altimeter: 35 GHz (Ka-band)
928	Altimeter (OCEANSAT-3)	Ku-band Altimeter	No longer considered		Radar altimeter	Sounding	Very Constrained Access	\N	Mainly sea state applications including SWH, Geoid etc., establishment of global databases.	1 km	\N	1500 m	\N	\N	1306 GHz
932	ALISS III	Advanced LISS III	Being developed		High resolution optical imager	Imaging	Constrained Access	\N	For crops and vegetation dynamics, natural resources census, disaster management and large scale mapping of themes.	20 m, 10 m	10m	925 km	925 km	200m	4 bands in VNIR and 1 band in SWIR
1699	AIS	AIS Receiver	Proposed		Communications system	\N	\N	\N	Reception of VHF AIS (Automatic Identification System).	\N	\N	\N	\N	\N	\N
1614	AEISS-A	Advanced Electronic Image Scanning System-A	Operational		High resolution optical imager	Imaging	Very Constrained Access	GEOTIF	High resolution imager for land applications of cartography and disaster monitoring.	Pan: 0.8 m, VNIR: 4 m, IR: 5.5m	0.8m	15 km	15 km	\N	Panchromatic VIS: 0.50 - 0.90 µm, VIS: 0.45 - 0.52 µm, 0.52 - 0.60 µm, 0.63 - 0.69 µm, NIR: 0.76 - 0.90 µm
347	AIRS	Atmospheric Infra-red Sounder	Operational		Medium-resolution IR spectrometer	Sounding	Open Access	HDF-EOS	High spectral resolution measurement of temperature and humidity profiles in the atmosphere. Long-wave Earth surface emissivity. Cloud diagnostics. Trace gas profiles. Surface temperatures.	1.1 degree (13 x 13 km at nadir)	\N	+/-48.95 degrees	\N	Humidity: 20%, Temperature: 1 K	VIS - TIR: 0.4 - 1.7 µm, 3.4 - 15.4 µm, Has approximately 2382 bands from VIS to TIR
1522	AEISS	Advanced Electronic Image Scanning System	Operational	High Heritage - Operational	High resolution optical imager	Imaging	Very Constrained Access	GEOTIF	High resolution imager for land applications of cartography and disaster monitoring.	Pan: 0.8 m; VNIR: 4 m	0.8m	15 km	15 km	\N	Panchromatic VIS: 0.50 - 0.90 µm, VIS: 0.45 - 0.52 µm, 0.52 - 0.60 µm, 0.63 - 0.69 µm, NIR: 0.76 - 0.90 µm
947	AIS (RCM)	Automated Identification System (RADARSAT Constellation)	Being developed	High Heritage - Operational	Data collection system	Other	Constrained Access	\N	Ship identification (name, location, heading, cargo, etc).	N/A	\N	800 km minimum	\N	Better than 90% ship detection, for Class A ships, when ships are in view for a minimum of 5 minutes.	VHF (162 MHz)
1651	AHI	Advanced Himawari Imager	Operational		Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	Himawari Standard Data, HRIT Data,  LRIT data, NetCDF Data, Color Image Data. See:\nhttp://www.data.jma.go.jp/mscweb/en/himawari89/space_segment/spsg_sample.html	Measures cloud cover, cloud motion, cloud height, cloud properties, water vapour, rainfalll, sea surface temperatures and Earth radiation, dust, aerosols, volcanic ash, fires, snow and ice cover.	0.5 km in 0.64 µm band; 1.0km in 0.46 µm, 0.51 µm and 0.86 µm band, 2.0 km in all others	500m	Full Earth disk : Fixed, Japan Area (Region 1, Region 2) : Fixed, Target Area (Region 3) : Flexible	500 km	\N	16 bands from 0.46 µm to 13.3 µm\nVIS (~0.40 µm - ~0.75 µm)\nNIR (~0.75 µm - ~1.3 µm)\nSWIR (~1.3 µm - ~3.0 µm)\nMWIR (~3.0 µm - ~6.0 µm)\nTIR (~6.0 µm - ~15.0 µm)
1568	Advanced Scatterometer	Advanced Scatterometer	Proposed	Low Heritage	Radar scatterometer	Imaging	Very Constrained Access	\N	Ocean surface wind measurements.	25 km	25m	1800 km	1800 km	Wind speed: 2 m/s, direction: 20 grad	C (or X) - band, TBD
375	ALADIN	Atmospheric Laser Doppler Instrument	Being developed		Doppler lidar	Sounding	Open Access	\N	Global wind profiles (single line-of-sight) for an improved weather prediction.	One wind profile every 200 km along track, averaged over 50 km	\N	Along line 285 km parallel to satellite ground track	\N	Wind speed error below 2 m/s	UV: 355 nm
1574	Advanced GOCI	Advanced Geostationary Ocean Colour Imager	Proposed	Low Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF, LRIT, HRIT	Ocean colour information, coastal zone monitoring, land resources monitoring.	236 x 360 m	236m	FOR (Field Of Regard) is 2500km x 2500km, divided into 12 slots.	2500 km	\N	VIS - NIR: 0.40 - 0.88 µm (12 channels)
1565	Advanced KMSS	Advanced Multispectral Imager (VIS)	Proposed	High Heritage - Non-Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Constrained Access	\N	Multispectral images of land & sea surfaces and ice cover.	60 m - 100 m	60m	900 km	900 km	\N	0.4 - 0.9 µm, 6 channels
1564	Advanced MSU-MR	Advanced Multispectral scanning imager-radiometer	Proposed	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	\N	Parameters of clouds, snow, ice and land cover, vegetation, surface temperature, fire detection.	1 km	1000m	3000 km	\N	VIS: 0.5%; IR: 0.1 - 0.2 K	VIS: 0.5 - 0.7 µm; NIR: 0.7 - 1.1 µm; SWIR: 1.6 - 1.8 µm; MWIR: 3.5 - 4.1 µm; TIR: 10.5 - 11.5 µm, 11.5 - 12.5 µm
1567	Advanced MTVZA	Advanced Scanning microwave imager-sounder	Proposed	High Heritage - Operational	Absorption-band MW radiometer/spectrometer	Sounding	Constrained Access	\N	Atmospheric temperature and humidity profiles, precipitation, sea-level wind speed, snow/ice coverage.	12 - 75 km	\N	2600 km	\N	0.4 - 2.0 K depending on spectral band	10.6 - 183.3 GHz, 26 channels
1575	Advanced MI	Advanced Meteorological Imager	Proposed	High Heritage - Operational	Multi-purpose imaging Vis/IR radiometer	Imaging	Open Access	HDF, LRIT, HRIT	Continuous monitoring capability for the near real-time generation of high-resolution meteorological products and long-term change analysis of sea surface temperature and cloud coverage.	VIS: 0.5km, 1 km, IR: 2 km	500m	Full Earth disk	22000 km	\N	16 bands covering 1: VIS, 0.55 - 0.80 µm; 2: SWIR: 3.50 - 4.00 µm; 3: WV (Waver Vapour): 6.50 - 7.00 µm; 4: TIR1 (Thermal Infrared 1): 10.3 - 11.3 µm, 5: TIR2 (Thermal Infrared 2): 11.5 - 12.5 µm
1570	Advanced Radiomet	Advanced Radio-occultation receiver	Proposed	Low Heritage	GNSS radio-occultation receiver	Other	Constrained Access	\N	Atmospheric temperature and humidity profiles with high vertical resolution.	\N	\N	\N	\N	\N	\N
1566	Advanced IKFS-2	Advanced Fourier spectrometer	Proposed	Medium Heritage	High-resolution nadir-scanning IR spectrometer	Other	Constrained Access	\N	Atmospheric temperature/humidity profiles, data on cloud parameters, water vapour & ozone column amounts, surface temperature.	35 -100 km	35m	1000/2000 km	2000 km	0.5 K	3,7 - 15,5 µm, more then 8000 spectral channels
1569	Advanced SAR	Advanced Synthetic Aperture Radar X band	Proposed	Medium Heritage	Imaging radar (SAR)	Imaging	Very Constrained Access	\N	High resolution microwave radar images for ice watch.	1 m, 5 m, 50 m, 200 m, 500 m	1m	10 km, 50 km, 130 km, 600 km, 750 km	750 km	1 dB	X-Band
1572	Advanced GGAK-M	Advanced Module for Geophysical Measurements (SEM)	Proposed	High Heritage - Non-Operational	Space environment monitor	Other	Constrained Access	\N	Space Environmental Monitoring (SEM).	\N	\N	\N	\N	\N	\N
418	ACRIM III	Active Cavity Radiometer Irradiance Monitor	No longer operational		Solar irradiance monitor	Sounding	Open Access	HDF-EOS	Measurements of solar luminosity and solar constant. Data used as record of time variation of total solar irradiance, from extreme UV through to infrared.	5 deg FOV	\N	71 mins per orbit of full solar disk data	\N	0.1% of full scale	UV - MWIR: 0.15 - 5 µm
863	ACC	Accelerometer	Operational		Gradiometer/accelerometer	Other	Open Access	\N	Measurement of the spacecraft non-gravitational accelerations, linear accelerations range: +/- 2*10-4 m/s2; angular measurement range: +/- 9.6* 10-3 rad/s2; measurement bandwidth: 10-4 to 10-2 Hz; Linear resolution: 1.8*10-10 m/s2; angular resolution: 8*10-9 rad/s2.	0.1 nm/s2	\N	N/A	\N	overall instrument random error: <10 - 8 m/s2	N/A
870	ABI	Advanced Baseline Imager	Being developed	Medium Heritage	Multi-purpose imaging Vis/IR radiometer	Imaging	\N	\N	Detects clouds, cloud properties, water vapour, land and sea surface temperatures, dust, aerosols, volcanic ash, fires, total ozone, snow and ice cover, vegetation index.	0.5 km in 0.64 µm band; 2.0 km in long wave IR and in the 1.378 µm band; 1.0 km in all others	500m	\N	\N	Varies by product	16 bands in VIS, NIR and IR ranging from 0.47 µm to 13.3 µm
701	ACE-FTS	Atmospheric Chemistry Experiment (ACE) Fourier Transform Spectrometer	Operational		Limb-scanning IR spectrometer	Sounding	Open Access	ASCII, HDF, NetCDF	Measure and understand the chemical processes that control the distribution of ozone in the Earth's atmosphere, especially at high altitudes.	\N	\N	\N	\N	Depends on species, meets requirements for climate variables	SWIR - TIR: 2 - 5.5 µm, 5.5 - 13 µm (0.02 cm-1 resolution)
301	ADEOS Comms	Communications package for ADEOS	No longer operational		\N	Sounding	\N	\N	Communication package onboard ADEOS series satellites.	\N	\N	\N	\N	\N	\N
693	ACRIM II	Active Cavity Radiometer Irradiance Monitor	No longer operational		Solar irradiance monitor	Sounding	\N	\N	Measurements of solar luminosity and solar constant.Data used as record of ime variation of total solar irradiance, from extreme UV through to infra-red.	Not applicable	\N	Not applicable	\N	Measures integrated flux of solar radiation to <0.1%	UV - FIR: 1 nm - 50 µm
1571	Advanced DCS	Advanced Data Collection System	Proposed	High Heritage - Operational	Data collection system	TBD	Constrained Access	\N	Collects data on temperature (air/water), atmospheric pressure, humidity and wind speed/direction, speed and direction of ocean and river currents.	\N	\N	\N	\N	\N	\N
411	AATSR	Advanced Along-Track Scanning Radiometer	No longer operational		Multi-channel/direction/polarisation radiometer	Imaging	Open Access	\N	Measurements of sea surface temperature, land surface temperature, cloud top temperature, cloud cover, aerosols, vegetation, atmospheric water vapour and liquid water content.	IR ocean channels: 1 x 1 km, Visible land channels: 1 x 1 km	1000m	500 km	\N	Sea surface temperature: <0.5 K over 0.5 x 0.5 deg (lat/long) area with 80% cloud cover Land surface temperature: 0.1 K (relative)	VIS - NIR: 0.555 µm, 0.659 µm, 0.865 µm, SWIR: 1.6 µm, MWIR: 3.7 µm, TIR: 10.85 µm, 12 µm
1627	3MI	Multi-Viewing Multi-Channel Multi-Polarisation Imaging	Being developed		Multi-channel/direction/polarisation radiometer	Imaging	\N	net-CDF4	Measure aerosol parameters, air quality index, surface albedo, cloud information	4km	\N	2200x2200 km for the VNIR channels\n\n2200 x 1100 km for the SWIR channels	\N	\N	VIS-SWIR: 12 channels between 0.41 µm to 2.1 µm
211	174-K	Temperature and Humidity Profiler	No longer operational		Narrow-band channel IR radiometer	Sounding	\N	\N	Vertical profiles of temperature, humidity, and ozone.	42 km	\N	1000 km	\N	\N	TIR-FIR 18 µm (water absorption), 13.33 µm, 13.70 µm, 14.24 µm, 14.43 µm, 14.75 µm, 15.02 µm (carbon dioxide), 11 µm (transparent), 9.6 µm (ozone)
\.


--
-- Name: instruments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('instruments_id_seq', 1, false);


--
-- Data for Name: instruments_in_mission; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY instruments_in_mission (mission_id, instrument_id) FROM stdin;
237	184
346	645
391	697
598	697
344	730
616	988
615	988
617	988
834	988
775	1733
773	1730
392	817
393	817
213	391
370	1625
372	1625
823	1625
235	459
237	459
274	459
257	459
775	1732
602	1698
91	138
200	138
222	138
94	138
95	138
96	138
628	81
83	81
390	699
422	642
265	406
267	406
460	406
750	1680
601	966
749	1681
822	1776
312	14
311	14
81	77
244	78
744	1676
644	1539
413	412
270	412
264	412
667	412
382	412
361	412
383	412
362	412
668	412
801	412
802	412
215	402
47	67
232	67
233	67
436	67
438	67
366	684
367	684
368	684
716	1637
715	1637
251	404
253	404
557	1504
641	1504
777	1504
838	1504
839	1504
737	1664
785	1742
91	137
581	942
318	855
468	860
671	1602
639	941
640	941
590	949
556	949
591	949
618	949
562	1513
599	1697
142	247
653	1546
647	1536
270	679
767	679
383	679
726	679
816	1770
286	764
837	1715
769	1724
770	1724
142	246
97	275
98	275
99	275
224	275
366	906
367	906
368	906
210	765
354	415
126	415
240	415
217	415
358	415
210	763
404	721
215	414
484	1743
483	1743
485	1743
486	1743
487	1743
482	1743
88	327
226	327
547	1524
772	1746
716	1712
715	1712
346	644
447	644
734	644
623	1573
681	1573
682	1573
537	1506
538	1506
539	1506
771	1725
786	1725
435	923
721	1655
453	959
458	905
207	349
721	1654
458	904
723	1644
96	141
495	141
266	141
335	141
470	953
546	953
727	953
724	953
571	929
820	929
97	329
99	329
223	329
101	329
224	329
213	156
381	741
408	741
409	741
410	741
411	741
559	908
381	742
408	742
409	742
410	742
411	742
468	861
303	453
304	453
306	453
345	453
376	1556
300	452
301	452
302	452
303	452
304	452
305	452
306	452
345	452
381	740
303	634
304	634
305	634
306	634
345	634
381	454
408	454
409	454
410	454
411	454
304	635
305	635
306	635
345	635
381	635
408	635
409	635
410	635
411	635
300	451
302	451
303	451
304	451
305	451
306	451
345	451
303	633
304	633
305	633
306	633
345	633
300	738
143	254
303	632
304	632
306	632
554	903
555	903
579	903
739	1672
381	739
408	739
409	739
410	739
411	739
741	1671
655	1558
386	321
200	330
222	330
94	330
95	330
96	330
495	330
266	330
335	330
450	868
416	761
442	789
707	789
708	789
688	1529
690	1529
677	1587
213	419
346	419
354	1763
388	743
416	760
366	975
367	975
368	975
370	975
554	902
555	902
579	902
426	769
143	253
368	1632
370	1632
372	1632
823	1632
582	944
378	688
529	688
796	1755
797	1755
798	1755
799	1755
480	991
143	252
624	1694
626	1694
760	1694
788	1694
789	1694
624	1693
626	1693
760	1693
788	1693
789	1693
346	626
360	901
540	901
541	901
368	1624
369	1624
370	1624
371	1624
270	1502
361	1502
126	218
129	218
532	1780
533	1780
534	1780
535	1780
536	1780
824	1780
825	1780
382	683
383	683
97	65
98	65
91	65
223	65
101	65
224	65
104	65
105	65
106	65
261	65
113	65
230	65
231	65
229	302
259	302
260	302
451	302
532	1781
533	1781
534	1781
535	1781
536	1781
824	1781
825	1781
633	1518
714	1518
745	1518
2	367
200	637
222	637
94	637
95	637
96	637
495	637
266	637
335	637
470	952
546	952
727	952
724	952
366	974
367	974
339	427
241	427
730	1704
240	455
612	1512
278	752
671	752
723	1645
764	1703
609	972
718	972
719	972
720	972
831	972
830	972
832	972
833	972
571	1749
820	1749
97	318
98	318
99	318
101	318
224	318
104	318
105	318
106	318
113	318
642	1665
354	657
702	1631
840	1631
841	1631
127	382
153	382
375	382
465	826
636	1521
674	1521
405	731
452	731
457	731
456	731
143	251
270	737
264	737
382	737
361	737
383	737
362	737
143	249
143	250
673	922
395	704
526	704
527	704
528	704
397	706
441	790
712	790
604	971
243	456
761	1695
130	800
352	703
584	946
585	946
586	946
97	189
98	189
99	189
101	189
224	189
225	189
104	189
105	189
106	189
261	189
113	189
230	189
382	189
383	189
725	189
726	189
129	348
354	357
216	357
356	659
687	1598
354	656
375	675
462	821
375	927
622	1509
730	1706
91	136
200	136
222	136
94	136
95	136
96	136
495	136
266	136
335	136
423	766
453	958
557	1628
702	1628
838	1628
840	1628
839	1628
841	1628
134	194
432	194
121	194
318	194
278	899
134	193
432	193
121	193
122	193
318	193
240	89
126	210
125	210
127	210
128	210
153	210
133	227
771	1744
445	837
472	839
473	839
668	1716
801	1716
802	1716
782	1738
472	840
473	840
603	968
717	1640
609	967
718	967
719	967
720	967
831	967
830	967
832	967
833	967
561	912
561	913
2	379
142	245
122	198
220	378
221	378
471	834
610	834
792	834
793	834
625	834
794	834
795	834
122	197
630	1516
445	836
242	443
769	1723
770	1723
416	762
800	1761
592	1633
215	337
419	829
415	751
648	1661
210	18
241	793
240	390
286	182
350	1649
213	100
350	1650
631	1517
632	1517
768	1722
627	1514
631	1601
632	1601
631	1600
632	1600
562	914
679	1592
235	446
274	446
396	832
731	1659
696	1610
697	1610
475	857
742	1675
565	917
392	867
393	867
374	436
704	1647
738	1647
275	796
773	1728
703	1586
672	1586
480	989
787	1747
444	845
242	364
142	244
605	977
774	1729
629	1589
668	1718
801	1718
802	1718
413	681
270	681
667	681
382	681
361	681
668	681
801	681
802	681
370	1623
372	1623
823	1623
406	734
245	336
388	662
772	1769
300	450
301	450
302	450
303	450
304	450
305	450
306	450
345	450
381	450
408	450
409	450
410	450
411	450
796	1754
797	1754
798	1754
799	1754
443	791
207	630
554	896
555	896
579	896
547	897
240	359
472	838
473	838
474	850
240	425
643	1527
688	1527
689	1527
690	1527
571	935
820	935
648	1597
684	1597
257	464
551	464
278	464
716	1638
715	1638
680	1595
97	561
98	561
99	561
223	561
101	561
224	561
225	561
104	561
105	561
106	561
113	561
564	916
453	812
730	1710
350	647
563	915
557	1663
838	1663
839	1663
684	1531
366	672
367	672
368	672
369	672
371	672
800	672
570	925
366	895
367	895
696	1611
697	1611
565	1611
368	1622
369	1622
370	1622
371	1622
372	1622
823	1622
368	1621
369	1621
370	1621
371	1621
372	1621
823	1621
220	185
221	185
2	185
686	1668
702	1630
840	1630
841	1630
453	803
366	667
367	667
14	13
15	13
371	671
372	671
823	671
822	1775
366	669
367	669
32	394
33	394
10	394
228	394
258	394
309	180
310	180
821	1774
773	1726
644	1540
775	1731
392	818
393	818
732	1658
774	1727
742	1674
648	1532
307	563
385	563
384	563
318	674
473	674
129	673
130	673
476	673
477	673
735	673
736	673
813	673
810	673
811	673
385	1500
384	1500
122	196
130	779
476	779
477	779
735	779
736	779
813	779
810	779
811	779
134	191
432	191
121	191
122	191
318	191
135	195
136	195
137	195
142	195
143	195
153	195
122	195
129	777
612	852
134	192
432	192
121	192
625	1692
137	229
152	784
530	784
611	784
713	1691
751	1691
812	1691
135	228
136	228
153	228
129	228
318	228
318	567
142	243
143	243
97	328
98	328
99	328
223	328
101	328
224	328
129	848
471	835
610	835
792	835
793	835
625	835
794	835
795	835
628	80
83	80
123	794
257	465
551	465
552	940
553	940
578	940
88	326
226	326
580	938
229	296
259	296
260	296
451	296
469	831
130	780
605	976
407	735
787	1748
129	776
759	1690
752	1690
126	217
127	217
128	217
129	217
126	216
434	216
127	216
128	216
153	216
142	462
237	462
125	209
125	208
475	858
758	1689
757	1689
204	119
746	1700
213	353
204	395
206	395
344	722
207	126
454	807
344	725
140	233
783	1741
379	689
204	396
137	223
123	795
139	232
128	215
129	215
730	1709
2	338
653	1548
597	965
557	965
838	965
839	965
106	304
261	304
113	304
230	304
231	304
368	670
369	670
370	670
371	670
372	670
823	670
524	894
628	79
83	79
369	1620
370	1620
371	1620
372	1620
823	1620
800	1759
366	893
367	893
368	893
2	320
32	295
33	295
10	295
228	295
258	295
532	892
533	892
534	892
535	892
536	892
824	892
825	892
101	149
394	702
566	918
566	919
566	920
815	1768
470	878
546	878
727	878
724	878
386	368
353	653
95	1501
96	1501
495	1501
113	1501
266	1501
335	1501
679	1594
375	865
376	1557
716	1713
715	1713
427	770
686	1667
769	1721
770	1721
201	1510
238	1510
210	106
286	106
419	106
592	106
646	106
747	1678
532	891
533	891
534	891
535	891
536	891
824	891
825	891
717	1639
748	1679
276	461
439	461
710	461
603	969
215	110
780	110
818	1773
819	1773
51	438
277	438
235	444
274	444
51	439
277	439
234	439
276	934
439	934
710	934
648	1533
354	654
203	628
245	335
642	1526
548	890
587	890
588	890
589	890
19	772
835	1777
614	986
614	1554
46	819
424	29
255	29
803	1764
378	767
376	767
529	767
468	767
649	1542
453	711
652	1544
127	214
128	214
129	214
130	801
476	801
477	801
735	801
736	801
813	801
810	801
811	801
134	190
432	190
121	190
122	190
141	234
138	230
652	1545
245	559
129	220
286	107
138	231
646	1541
385	695
142	241
213	661
344	727
127	213
128	213
153	213
771	1745
414	749
363	665
364	665
365	665
531	665
265	410
267	410
730	1708
392	866
393	866
775	866
590	950
556	950
591	950
618	950
743	1673
366	666
367	666
368	666
351	651
359	651
653	1547
643	1528
689	1528
464	825
678	1590
647	1538
240	332
414	747
368	668
369	668
370	668
371	668
372	668
823	668
200	331
222	331
94	331
95	331
96	331
495	331
266	331
335	331
344	728
307	466
384	466
549	466
442	788
707	788
708	788
130	778
477	778
735	778
736	778
813	778
810	778
811	778
240	333
758	1688
757	1688
142	240
142	239
241	334
142	238
422	696
414	750
400	714
414	746
344	729
400	833
702	1662
840	1662
841	1662
693	1607
414	748
557	1626
838	1626
839	1626
693	1608
570	926
203	627
696	1612
697	1612
261	305
230	305
231	305
569	924
449	798
696	1613
697	1613
344	724
396	705
463	824
600	964
453	805
390	698
206	442
694	1605
695	1605
762	1696
251	26
344	723
694	1604
695	1604
247	19
285	19
249	19
253	759
693	1606
460	1520
403	1757
693	1609
213	97
704	1603
738	1603
253	183
97	309
98	309
99	309
223	309
101	309
224	309
106	564
261	564
113	564
230	564
728	1653
729	1653
478	887
479	887
630	1634
206	351
207	351
225	313
104	313
105	313
781	1737
654	1551
759	1753
752	1753
213	350
728	1652
729	1652
784	1740
142	237
624	1686
626	1686
760	1686
788	1686
789	1686
261	306
230	306
231	306
796	1687
797	1687
798	1687
799	1687
391	1553
337	987
686	987
651	987
758	1752
757	1752
468	943
322	583
343	105
419	983
592	983
646	983
480	1552
376	786
2	366
221	370
344	726
484	881
483	881
485	881
486	881
487	881
482	881
91	562
200	562
222	562
94	562
95	562
96	562
495	562
266	562
335	562
448	773
429	773
261	307
230	307
231	307
81	299
244	299
369	1619
370	1619
371	1619
800	1619
372	1619
823	1619
470	877
546	877
727	877
724	877
524	886
769	1720
770	1720
532	1779
533	1779
534	1779
535	1779
536	1779
824	1779
825	1779
212	421
380	631
713	1685
751	1685
812	1685
241	362
472	841
473	841
476	853
477	853
735	853
736	853
813	853
810	853
811	853
229	303
259	303
260	303
451	303
669	1583
650	1543
624	1684
626	1684
760	1684
788	1684
789	1684
152	847
530	847
611	847
444	844
766	1717
369	1618
371	1618
730	1707
836	1778
548	885
587	885
588	885
589	885
470	951
546	951
727	951
724	951
730	1705
322	603
350	1648
220	293
221	293
366	884
367	884
368	884
370	1617
372	1617
823	1617
349	322
647	1537
97	143
216	143
98	143
406	733
350	1615
376	691
101	148
2	294
436	170
438	170
473	843
468	862
765	1714
448	774
472	842
253	1508
210	389
776	1734
142	236
285	1507
249	1507
251	1507
740	1669
453	957
122	775
286	181
2	181
378	181
419	181
529	181
609	181
592	181
769	181
646	181
770	181
344	955
604	1505
716	1635
715	1635
91	135
200	135
222	135
94	135
95	135
96	135
470	954
546	954
727	954
724	954
265	822
267	822
460	822
392	822
393	822
775	822
43	758
44	758
612	1511
130	799
476	799
152	799
477	799
530	799
735	799
736	799
611	799
813	799
810	799
811	799
603	970
81	188
83	188
244	188
466	828
467	828
607	828
608	828
826	828
827	828
828	828
829	828
634	1519
635	1519
480	990
413	325
270	325
667	325
382	325
361	325
668	325
801	325
802	325
638	1523
354	1767
347	649
386	372
580	372
560	909
645	1534
382	680
383	680
322	623
645	1535
783	1739
466	827
467	827
607	827
608	827
826	827
827	827
828	827
829	827
746	1701
778	1736
629	1666
213	660
648	1530
677	1782
403	720
126	207
125	207
730	1656
233	787
438	787
256	432
256	431
215	397
204	397
206	397
413	397
270	397
667	397
382	397
256	430
463	823
464	823
596	1762
807	1762
808	1762
809	1762
265	409
267	409
460	409
453	956
453	806
731	1657
732	1657
821	1657
779	1735
575	939
576	939
577	939
814	939
126	212
753	1751
755	1751
754	1751
422	820
567	921
359	652
133	226
560	910
560	911
790	1750
791	1750
796	1756
797	1756
798	1756
799	1756
476	900
477	900
735	900
736	900
813	900
810	900
612	900
756	900
811	900
133	225
130	225
143	248
580	937
242	363
276	460
439	460
670	460
710	460
45	405
46	405
240	358
221	408
220	383
221	383
225	403
104	403
105	403
106	403
261	403
113	403
230	403
231	403
220	407
97	310
98	310
99	310
223	310
101	310
224	310
225	276
104	276
573	933
817	933
386	374
580	374
204	416
369	1616
370	1616
371	1616
372	1616
823	1616
261	308
230	308
231	308
413	413
270	413
667	413
382	413
361	413
668	413
801	413
802	413
468	859
613	998
2	261
691	1599
444	846
97	154
98	154
99	154
223	154
101	154
224	154
225	154
104	154
105	154
106	154
261	154
113	154
572	154
230	154
231	154
495	694
113	694
266	694
335	694
270	694
264	694
231	694
382	694
571	694
361	694
383	694
725	694
362	694
726	694
702	694
840	694
2	344
2	260
612	851
206	664
447	736
453	985
206	1555
453	984
818	1772
819	1772
225	312
104	312
105	312
106	312
261	312
113	312
230	312
231	312
225	323
104	323
105	323
769	1719
770	1719
220	434
221	434
419	882
592	882
646	882
542	883
543	883
459	883
220	435
221	435
241	360
220	433
221	433
142	235
203	422
609	973
718	973
719	973
720	973
831	973
830	973
832	973
833	973
679	1593
572	931
573	932
817	932
746	1699
785	1699
698	1614
206	347
637	1522
584	947
585	947
586	947
728	1651
729	1651
623	1568
681	1568
682	1568
377	375
669	1574
623	1565
681	1565
682	1565
623	1564
681	1564
682	1564
623	1567
681	1567
682	1567
525	1575
623	1570
681	1570
682	1570
623	1566
681	1566
682	1566
623	1569
681	1569
682	1569
623	1572
681	1572
682	1572
147	418
468	863
470	870
546	870
727	870
724	870
394	701
240	301
241	301
213	693
623	1571
681	1571
682	1571
2	411
557	1627
838	1627
839	1627
126	211
125	211
127	211
128	211
\.


--
-- Data for Name: measurement_categories; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY measurement_categories (id, name, description, broad_measurement_category_id) FROM stdin;
1000	Other	Other	1000
26	Gravity, Magnetic and Geodynamic measurements	The geoid is the surface of equal gravitational potential at mean sea level, and reflects the irregularities in the Earth’s gravity field at the planet’s surface caused by the inhomogeneous mass and density distribution in the interior. Such measurements are vital for quantitative determination – in combination with satellite altimetry – of ocean currents, improved global height references, estimates of the thickness of the polar ice sheets and its variations, and estimates of the mass/volume redistribution of fresh water in order to better understand the hydrological cycle.	5
23	Snow cover, edge and depth	Regular measurements of terrestrial snow cover are important because snow dramatically influences surface albedo, thereby making a significant impact on the global climate, as well as influencing hydrological properties and the regulation of ecosystem biological activity. Snow forms a vital component of the water cycle. In order to make efficient use of meltwater runoff, resource agencies must be able to make early predictions of the amount of water stored in the form of snow. Snow cover information has a range of additional applications such as detecting areas of winterkill in agriculture that result from lack of snow cover to insulate plants from freezing temperatures. Locally, monitoring of snow parameters is important for meteorology and for enabling warnings of when melting is about to occur – which is crucial for hydrological research and for forecasting the risk of flooding.	4
13	Vegetation	Changes in land cover are important aspects of global environmental change, with implications for ecosystems, biogeochemical fluxes and global climate. Land cover change affects climate through a range of factors from albedo to emissions of greenhouse gases from the burning of biomass. Deforestation increases the amount of carbon dioxide (CO2) and other trace gases in the atmosphere.	2
8	Radiation budget	The Earth’s radiation budget is the balance within the climate system between the energy that reaches the Earth from the Sun and the energy that returns from Earth to space. The goal of such measurements is to determine the amount of energy emitted and reflected by the Earth. This is necessary to understand the processes by which the atmosphere, land and oceans transfer energy to achieve global radiative equilibrium, which in turn is necessary to simulate and predict climate.	1
9	Trace gases (excluding ozone)	Trace gases other than ozone may be divided into three categories: greenhouse gases affecting climate change; chemically aggressive gases affecting the environment (including the biosphere); and, gases and radicals impacting on the ozone cycle, thereby affecting both climate and environment. Measurements include the concentration of trace gasses, column totals and integrated column measurements, and profiles of gas concentration.	1
6	Liquid water and precipitation rate	Water forms one of the most important constituents of the Earth’s atmosphere and is essential for human existence. The global water cycle is at the heart of the Earth’s climate system, and better predictions of its behaviour are needed for monitoring climate variability and change, weather forecasting and sustainable development of the world’s water resources.	1
7	Ozone	Ozone (O3) is a relatively unstable molecule, and although it represents only a tiny fraction of the atmosphere, it is crucial for life on Earth. Depending on its location, ozone can protect or harm life on Earth. Most ozone resides in the stratosphere, where it acts as a shield to protect the surface from the Sun’s harmful ultraviolet radiation. In the troposphere, ozone is a harmful pollutant which causes damage to lung tissue and plants.	1
28	Lightning Detection	Measurement type description needs to be added to the MIM DB.	1
4	Cloud type, amount and cloud top temperature	The study of clouds, their location and characteristics, plays a key role in the understanding of climate change. Low, thick clouds primarily reflect solar radiation and cool the surface of the Earth. High, thin clouds primarily transmit incoming solar radiation, but at the same time they trap some of the outgoing infrared radiation emitted by the Earth and radiate it back downward, thereby warming the surface. Parameters include temperature and moisture profiles, fractional cloud cover, cloud top height, cloud top pressure, surface temperature and surface emissivity.	1
5	Cloud particle properties and profile	A key to climate modelling is to observe and understand the global distribution of clouds, their physical properties, such as thickness and droplet size. Whether a particular cloud will heat or cool the Earth’s surface depends on the cloud’s radiating temperature – and thus its height – and on its albedo for both visible and infrared radiation, which depends on the number and details of the cloud properties.	1
3	Atmospheric Winds	Measurements of atmospheric winds are of primary importance to weather forecasting, and as a variable in the study of global climate change. Upper air wind speed and direction is a basic element of the climate system that influences many other variables.	1
25	Atmospheric Temperature Fields	With humidity, atmospheric temperature profile data are a core requirement for weather forecasting and are coordinated within the framework of CGMS (The Coordination Group for Meteorological Satellites). The data are used for numerical weather prediction (NWP), for monitoring inter-annual global temperature changes, for identifying correlations between atmospheric parameters and climatic behaviour, and for validating global models of the atmosphere.	1
1	Aerosols	Aerosols are tiny particles suspended in the air, with the majority derived from natural phenomena such as volcanic eruptions, thought it is estimated that some 10–20% are generated by human activities such as burning of fossil fuels. The majority of aerosols form a thin haze in the lower atmosphere and are regularly washed out by precipitation, with the remainder found in the stratosphere where they can remain for many months or years.	1
2	Atmospheric Humidity Fields	The observations for water vapour (atmospheric humidity) are a core requirement for weather forecasting and are largely dealt with in the framework of the Coordinating Group for Meteorological Satellites (CGMS). The 3-dimensional field of humidity is a key variable for global and regional weather prediction (NWP) models that are used to produce short- and medium-range forecasts of the state of the troposphere and lower stratosphere.	1
14	Surface temperature (land)	Land surface temperature varies widely with solar radiation. It is of help in interpreting vegetation and its water stress when the range of temperatures between day and night and from clear sky to cloud cover are compared. On a local scale, surface temperature imagery may be used to refine techniques for predicting ground frost and to determine the warming effect of urban areas (urban heat islands) on night-time temperatures. In agriculture, temperature information may be used, together with models, to optimise planting times and provide timely warnings of frost. Measurements of surface temperature patterns may also be used in studies of volcanic and geothermal areas and resource exploration.	2
12	Soil moisture	Soil moisture plays a key role in the hydrological cycle. Evaporation rates, surface runoff, infiltration and percolation are all affected by the level of moisture in the soil. Changes in soil moisture have a serious impact on agricultural productivity, forestry and ecosystem health. Monitoring soil moisture is critical for managing these resources and understanding long-term changes, such as desertification, and should be developed in proper coordination with other land surface variables. Applications include crop yield predictions, identification of potential famine areas, irrigation management, and monitoring of areas subject to erosion and desertification, as well as for the initialisation of NWP models.	2
11	Landscape topography	Many modelling activities in Earth and environmental sciences, telecommunications and civil engineering increasingly require accurate, high resolution and comprehensive topographical databases with, indication of changes over time, where relevant. The information is also used by, amongst others, land use planners for civil planning and development, and by hydrologists to predict the drainage of water and likelihood of floods, especially in coastal areas.	2
10	Albedo and reflectance	Albedo is the fraction of solar energy that is diffusely reflected back from Earth to space. Measurements of albedo are essential for climate research studies and investigations of the Earth’s energy budget. Different parts of the Earth have different albedos. For example, ocean surfaces and rain forests have low albedos, which means that they reflect only a small portion of the Sun’s energy. Deserts, ice and clouds, however, have high albedos; they reflect a large portion of the incoming solar energy. The high albedo of ice helps to insulate the polar oceans from solar radiation.	2
19	Surface temperature (ocean)	Ocean surface temperature (often known as ‘sea surface temperature’ or SST) is one of the most important boundary conditions for the general circulation of the atmosphere. The ocean exchanges vast amounts of heat and energy with the atmosphere and these air/sea interactions have a profound influence on the Earth’s weather and climate patterns. SST is linked closely with the ocean circulation, as demonstrated by the El Niño-Southern Oscillation (ENSO) cycle.	3
15	Multi-purpose imagery (land)	The spatial information that can be derived from satellite imagery is of value in a wide range of applications, particularly when combined with spectral information from multiple wavebands of a sensor. Satellite Earth observation is of particular value where conventional data collection techniques are difficult, such as in areas of inaccessible terrain, providing cost and time savings in data acquisition – particularly over large areas. At regional and global scales, low resolution instruments with wide coverage capability and imaging sensors on geostationary satellites are routinely exploited for their ability to provide global data on land cover and vegetation.	2
18	Ocean surface winds	High resolution vector wind measurements at the sea surface are required in models of the atmosphere, ocean surface waves and ocean circulation. They are proving useful in enhancing marine weather forecasting through assimilation into NWP models and in improving understanding of the large-scale air-sea fluxes which are vital for climate prediction purposes. Accurate wind vector data affect a broad range of marine operations, including offshore oil operations, ship movement and routing. Such data also aid short-term weather forecasting and the issue of timely weather warnings.	3
27	Ocean Salinity	Ocean salinity measurements are important because surface salinity and temperature control the density and stability of the surface water. Thus, ocean mixing (of heat and gases) and water-mass formation processes are intimately related to variations of surface salinity. Ocean modelling and analysis of water mass mixing should be enabled by new knowledge of surface-density fields derived from surface salinity measurements. The importance of the ocean in the global hydrological cycle also cannot be overstated. Some ocean models show that sufficient surface freshening results in slowing down the meridional overturning circulation, thereby affecting the oceanic transport of heat.	3
16	Ocean colour/biology	Remote sensing measurements of ocean colour (i.e. the detection of phytoplankton pigments) provide the only global-scale focus on the biology and productivity of the ocean’s surface layer. Phytoplankton are microscopic plants that live in the ocean, and like terrestrial plants, they contain the pigment chlorophyll, which gives them their greenish colour. Different shades of ocean colour reveal the presence of differing concentrations of sediments, organic materials and phytoplankton. The ocean over regions with high concentrations of phytoplankton is shaded from blue-green to green, depending on the type and density of the phytoplankton population. From space, satellite sensors can distinguish even slight variations in colour which cannot be detected by the human eye.	3
21	Multi-purpose imagery (ocean)	In addition to the specific ocean measurement observations discussed in previous sections, a number of sensors are capable of providing a range of ocean imagery from which useful secondary applications can be derived.	3
20	Ocean wave height and spectrum	Sea state and wind speed govern air-sea fluxes of momentum, heat, water vapour and gas transfer. The state of the sea and surface pressure are two features of the weather that are important to commercial use of the sea (e.g. ship routing, warnings of hazards to shipping, marine construction, off-shore drilling installations and fisheries). Information on surge height at the coast is key to the protection of life and property in coastal habitats.	3
17	Ocean topography/currents	Ocean surface topography data contain information that has significant practical applications in such fields as the study of worldwide weather and climate patterns, the monitoring of shoreline evolution and the protection of ocean fisheries. Ocean circulation is of critical importance to the Earth’s climate system. Ocean currents transport a significant amount of energy from the tropics towards the poles, leading to a moderation of the climate at high latitudes. Circulation can be deduced from ocean surface topography, which may be readily measured using satellite altimetry.	3
24	Sea ice cover, edge and thickness	Sea ice variability is a key indicator of climate variability and change which is characterised by a number of parameters. In addition to monitoring ice extent (the total area covered by ice at any concentration) and concentration (the area covered by ice per unit area of ocean), it is necessary to know ice thickness in order to estimate sea ice volume or mass balance.	4
22	Ice sheet topography	The state of the polar ice sheets and their volumes are both indicators and important parts of climate change processes and feedbacks. Consequently, it is important to monitor and study them in order to investigate the impact of global warming and to forecast future trends.	4
\.


--
-- Name: measurement_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('measurement_categories_id_seq', 1, false);


--
-- Data for Name: measurements; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY measurements (id, name, description, measurement_category_id) FROM stdin;
238	Total electron content (TEC)		1000
264	Ion density, drift velocity, and temperature		1000
267	Electron energy and pitch angle distribution		1000
266	ULF-HF electromagnetic waves		1000
237	Electron density profile		1000
263	Electron density profile		1000
265	Neutral particle composition and flow velocity		1000
262	Electric field (vector)		1000
206	Wind stress	The shear force per unit area exerted by wind blowing over the sea surface. [Unit of measurement – Pa]	18
229	Atmospheric Chemistry - PSC (column/profile)	PSC = Polar Stratospheric Clouds.  Requested in the lower stratosphere (layer: LS) - Accuracy expressed as Hit Rate [ HR ] and False Alarm Rate [ FAR ].	9
230	Atmospheric Chemistry - SF6 (column/profile)	SF6 = Sulfur exafluoride.  Requested from low stratosphere to TOA (layers: LS and HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
195	Atmospheric Chemistry - SO2 (column/profile)	SO2 = Sulfur dioxide.  Requested from surface to lower stratosphere (layers: LT, HT, LS) + Total column - Physical unit: [ ppm ] for profile, units of [1.3×1015 cm-2 ] for total column - Accuracy unit: [ % ] for profile, [1.3×1015 cm-2 ] for total column.	9
152	Ocean salinity	Salinity of sea water in the surface layer (upper ~ 1 m if observed in MW).  In the open ocean the correct term should be “halinity” in order to make reference to the most common anion, chlorine - Physical unit: [ psu ], Practical Salinity Unit, close to 1 ‰, or 1 g of salt / 1 litre of solution - Accuracy unit: [ psu ].	27
151	Color dissolved organic matter (CDOM)	Former name: “Yellow substance absorbance”.  Parameter extracted from ocean colour observation.  Indicative of biomass undergoing decomposition processes.  Requested in both open ocean and coastal zone - Physical unit: [ m-1 ] - Accuracy unit: [ % ] at a specific concentration (e.g., 1 m-1).	16
154	Ocean imagery and water leaving radiance	A two-dimensional array of water leaving radiance values.	21
147	Dominant wave direction	One feature of the ocean wave spectrum.  It is the direction of the most energetic wave in the spectrum - Physical unit: [ degrees ] - Accuracy unit: [ degrees ].	20
155	Bathymetry	The measurement of water depth. [Unit of measurement - m]	17
244	Snow albedo	Hemispherically integrated reflectance of the snow mantle in the range 0.4-0.7 µm (or other specific short-wave ranges) - Physical unit: [ % ] - Accuracy unit: [ % ].	10
121	Temperature of tropopause	Atmospheric temperature at the height of the surface separating the troposphere from the stratosphere - Physical unit: [ K ] - Accuracy unit: [ K ].	25
248	Surface Coherent Change Detection	Techniques that exploit the changes between two or several radar images of the same scene, in conditions where there is measurable coherence between at least a fraction of a pair of images, to detect subtle differences in the surface condition that can be related to sub-wavelength motions, surface properties changes or sub-pixel disturbances.	15
143	Wind vector over sea surface (horizontal)	The wind vector represents the motion of the airmass over the ground. It is described by wind speed and the inverse of wind direction. Conventionally measured at 10 m height. For expected performances and in case the measurement is made at a different height or in case it is corrected to 10m, indicate in the comments the exact height of the instrument as well as whether correction to 10 m has been applied. Accuracy is the modulus of the vector difference between measured and true vectors. [Unit of measurement - m/s]	18
252	Glacier area	2D vector outlines of glaciers and ice caps (delineating glacier area)	24
149	Ocean chlorophyll concentration	Parameter extracted from ocean colour observation.  Indicative of leaving phytoplankton biomass.  Requested in both open ocean and coastal zone - Physical unit: [ mg/m3 ] - Accuracy unit: [ % ] at a specific concentration (e.g., 1 mg/m3).	16
150	Ocean suspended sediment concentration	Parameter extracted from ocean colour observation.  Indicative of river outflow, re-suspension or pollution of other-than-biological origin.  Requested in both open ocean and coastal zone - Physical unit: [ g/m3 ] - Accuracy unit: [ % ] at a specific concentration (e.g., 2 g/m3).	16
146	Dominant wave period	One feature of the ocean wave spectrum.  It is the period of the most energetic wave in the spectrum - Physical unit: [ s ] - Accuracy unit: [ s ].	20
258	Sea state wavelength	-	20
145	Significant wave height	Average amplitude of the highest 30 of 100 waves - Physical unit: [ m ] - Accuracy unit: [ m ].	20
194	Ocean dynamic topography	Deviation of sea level from the geoid caused by ocean currents (that is after corrections for tides and atmospheric pressure effects) - Physical unit: [ cm ] - Accuracy unit: [ cm ].	17
153	Ocean surface currents (vector)	Large scale horizontal flow of ocean water that is persistent and driven by atmospheric circulation. [Unit of measurement - m/s]	17
166	Glacier cover	Fraction of an area covered by permanent ice - Physical unit: [ % ] - Accuracy unit: [ % ].	24
243	Ice sheet topography	Map of ice sheet heights.  Intended over land (for the ocean, see Sea-ice thickness) - Physical unit: [ cm ] - Accuracy unit: [ cm ].	22
236	Wave directional energy frequency spectrum	2-D parameter colloquially referred to as “wave spectrum”.  Describes the wave energy travelling in each direction and frequency band (e.g., 24 distinct azimuth sectors each 15° wide, and 25 frequency bands) - Physical unit: [ m2×Hz-1×rad-1 ] - Accuracy unit: [ m2×Hz-1×rad-1 ].	20
148	Sea level	Actual, local sea level inclusive of mean sea level and perturbations (tides, etc.) [Unit of measurement - cm]	17
167	Glacier motion	Variation of glacier boundary in a specific direction. [Unit of measurement -m/y]	24
161	Iceberg fractional cover	Fraction of the ground area covered by icebergs. [Unit of measurement - %]	24
162	Iceberg height	Vertical projection of an area covered by icebergs. [Unit of measurement - m]	24
159	Sea-ice sheet topography	Vertical projection of an area covered by ice sheets in meters.	22
253	Sea-ice concentration	-	24
156	Sea-ice cover	Fraction of ice in an ocean area - Physical unit: [ % ] - Accuracy unit: [ % ].	24
255	Sea-ice drift	-	24
158	Sea-ice surface temperature	Temperature of the surface of sea-ice - Physical unit: [ K ] - Accuracy unit: [ K ].	24
193	Sea-ice thickness	Thickness of the ice sheet connected with surface height and ice density - Physical unit: [ cm ] - Accuracy unit: [ cm ].	24
191	Crustal Motion	Changes in time of the position and height of the Earth’s plates.  Indicative of the lithosphere dynamics, thus useful for earthquake prediction  - Physical unit: [ mm/y ] - Accuracy unit: [ mm/y ].	26
190	Crustal plates positioning	Basic for monitoring the evolution of the lithosphere dynamics - Physical unit: [ cm ] - Accuracy unit: [ cm ].	26
184	Geoid	Equipotential surface which would coincide exactly with the mean ocean surface of the Earth, if the oceans were in equilibrium, at rest, and extended through the continents (such as with very narrow channels) - Physical unit: [ cm ] - Accuracy unit: [ cm ].	26
185	Gravity field	Indicative of the statics and dynamics of the lithosphere and the mantle - Physical unit: [ mGal ] (1 Gal = 0.01 m/s2. i.e. 1 mGal ≈ 10-6 g0 .  “Gal” stands for Galileo)  - Accuracy unit: [ mGal ].	26
186	Gravity gradients	Gradient of the Earth’s gravity field measured at the satellite orbital height - Physical unit: [ E ] , Eötvös (1 E = 1 mGal / 10 km) - Accuracy unit: [ E ].	26
188	Magnetic field (scalar)	[Unit of measurement – n tesla]	26
187	Magnetic field (vector)	[Unit of measurement - n tesla]	26
163	Snow cover	Fraction of snow in a given area - Physical unit: [ % ] - Accuracy unit: [ % ].	23
245	Snow detection (mask)	Binary product (snow or snow-free) derived from VIS/IR imagery - Accuracy expressed as Hit Rate [ HR ] and False Alarm Rate [ FAR ].	23
251	Snow grain size	Grain size of snow ice particle - Physical unit: [ mm] - Accuracy unit: [ % ].	23
164	Snow melting status (wet/dry)	Binary product (dry or melting/thawing) derived from MW imagery - Accuracy expressed as Hit Rate [ HR ] and False Alarm Rate [ FAR ].	23
250	Chlorophyll Fluorescence from Vegetation on Land	Solar induced chlorophyll fluorescence occurs during photosynthesis. It exhibits a strong linear correlation with terrestrial gross primary production (GPP). Direct global space borne observations of the fluorescence emission provide the same or better GPP estimations as those derived from traditional remotely-sensed vegetation indices using ancillary data and model assumptions.	13
179	Land cover	Processed from land surface imagery by assigning identified cluster(s) within a given area to specific classes of objects - Accuracy expressed as number of classes.  Actually [ classes-1 ] is used, so that smaller figure corresponds to better performance, as usual.	13
173	Leaf Area Index (LAI)	One half of the total projected green leaf fractional area in the plant canopy within a given area.  Representative of total biomass and health of vegetation - Physical unit: [ % ] - Accuracy unit: [ % ].	13
246	Snow surface temperature	Temperature of the surface of the snow mantle - Physical unit: [ K ] - Accuracy unit: [ K ].	23
165	Snow water equivalent	Total-column water if snow is reduced to liquid.  Linked to snow depth through assumptions or observation on density - Physical unit: [ mm ] - Accuracy unit: [ mm ].	23
172	Normalized Differential Vegetation Index (NDVI)	Difference between maximum (in NIR) and minimum (around the Red) vegetation reflectance, normalised to the summation.  Representative of total biomass, supportive for computing LAI if not directly measured - Physical unit: [ % ] - Accuracy unit: [ % ].	13
180	Soil type	Result of the classification of different types of soil within a vegetated area - Accuracy expressed as number of classes.  Actually [ classes-1 ] is used, so that smaller figure corresponds to better performance, as usual.	13
240	Vegetation Canopy (cover)	Fraction of the ground area covered by tree crowns in %.	13
241	Vegetation Canopy (height)	Vertical projection of an area covered by tree crowns in meters.	13
242	Vegetation Cover	Fraction of vegetated land in an area - Physical unit: [ % ] - Accuracy unit: [ % ].	13
176	Vegetation type	Result of the classification of different types of vegetation within a vegetated area - Accuracy expressed as number of classes.  Actually [ classes-1 ] is used, so that smaller figure corresponds to better performance, as usual.	13
201	Diffuse attenuation coefficient (DAC)	Former name: “Water clarity”.  Parameter extracted from ocean colour observation.  Indicative of water turbidity and vertical processes in the ocean.  Requested in both open ocean and coastal zone - Physical unit: [ m-1 ] - Accuracy unit: [m-1 ].	8
132	Downwelling (Incoming) long-wave radiation at the Earth surface	Flux of long-wave radiation from sun, atmosphere and clouds to the Earth’s surface - Physical unit: [ W/m2 ] - Accuracy unit: [ W/m2 ].	8
131	Downwelling (Incoming) short-wave radiation at the Earth surface	Flux of short-wave radiation from sun, atmosphere and clouds to the Earth’s surface - Physical unit: [ W/m2 ] - Accuracy unit: [ W/m2 ].	8
123	Downwelling (Incoming) solar radiation at TOA	Flux of the solar radiation at the top of the atmosphere - Physical unit: [ W/m2 ] - Accuracy unit: [ W/m2 ].	8
130	Long-wave cloud emissivity	Fraction of emitted radiation in respect of a black-body at the same temperature as the cloud top. Varies with wave-length. [Unit of measurement -dimensionless]	8
135	Long-wave Earth surface emissivity	Emissivity of the Earth’s surface in the thermal IR, function of the wavelength - Physical unit: [ % ] - Accuracy unit: [ % ].	8
129	Short-wave cloud reflectance	Reflectance of the solar radiation from clouds - Physical unit: [ % ] - Accuracy unit: [ % ].	8
94	Atmospheric Chemistry - BrO (column/profile)	BrO = Bromine monoxide.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
133	Short-wave Earth surface bi-directional reflectance	Reflectance of the Earth’s surface function of the viewing angle and the illumination conditions in the range 0.4-0.7 µm (or other specific short-wave ranges) - Physical unit: [ % ] - Accuracy unit: [ % ].	8
261	Solar spectral irradiance	-	8
221	Atmospheric Chemistry - C2H2 (column/profile)	C2H2 = Acetylene.  Requested in the troposphere (layers: LT, HT) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
222	Atmospheric Chemistry - C2H6 (column/profile)	C2H6 = Ethane.  Requested in the troposphere (layers: LT, HT) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
134	Upwelling (Outgoing) long-wave radiation at Earth surface	Flux of thermal radiation from the Earth’s surface - Physical unit: [ W/m2 ] - Accuracy unit: [ W/m2 ].	8
125	Upwelling (Outgoing) long-wave radiation at TOA	Flux of the terrestrial radiation in the range 4-200 µm (thermal emission) moving to Space through the top of the atmosphere - Physical unit: [ W/m2 ] - Accuracy unit: [ W/m2 ].	8
54	Atmospheric Chemistry - CFC-11 (column/profile)	CFC-11 = Trichlorofluoromethane = Freon-11.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
59	Atmospheric Chemistry - CFC-12 (column/profile)	CFC-12 = Dichlorodifluoromethane = Freon-12.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
260	Upwelling (Outgoing) short-wave radiation at the Earth surface	-	8
124	Upwelling (Outgoing) short-wave radiation at TOA	Flux of the terrestrial radiation in the range 0.2-4 µm (reflected solar radiation) moving to Space through the top of the atmosphere - Physical unit: [ W/m2 ] - Accuracy unit: [ W/m2 ].	8
215	Atmospheric Chemistry - CH2O (column/profile)	CH2O = HCHO = Formaldehyde.  Requested in the troposphere (layers: LT, HT) + Total column - Physical unit: [ ppm ] for profile, units of [1.3×1015 molecules/cm2 ] for total column - Accuracy unit: [ % ] for profile, [1.3×1015 cm-2 ] for total column.	9
223	Atmospheric Chemistry - CH3Br (column/profile)	CH3BR = Methyl Bromide.  Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
200	Upwelling (Outgoing) spectral radiance at TOA	Level-1 product.  Spectral range 0.2-200 mm.  Resolving power l/∆l = 1000.  Accuracy quoted as SNR (Signal-to-Noise-Ratio), actually SNR-1 so that smaller figure means better performance, as usual.  WMO and IOCCG quote accuracy in [ % ]	8
39	Atmospheric Chemistry - CH4 (column/profile)	CH4 = Methane.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) + Total column - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
217	Atmospheric Chemistry - CHOCHO (column/profile)	CHOCHO = Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
254	Lake area	-	6
247	Lake Surface Height	-	6
34	Ozone profile	O3 = Ozone.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) + Total column - Physical unit: [ ppm ] for profile, [ DU ], Dobson Unit, for total column (1 DU = 2.69٠1020 molecules/m2) - Accuracy unit: [ % ] for profile, [DU] for total column.	7
99	Atmospheric Chemistry - ClO (column/profile)	ClO = Chlorine monoxide = Hypochlorite.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
104	Atmospheric Chemistry - ClONO2 (column/profile)	ClONO2 = Chlorine nitrate.  Requested from mid-troposphere to TOA (layers: HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
49	Atmospheric Chemistry - CO (column/profile)	CO = Carbon monoxide.  Requested from surface to low stratosphere (layers: LT, HT, LS) + Total column - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
208	Lightning detection	Detection of lightning events as proxy of convective precipitation.  Also used for information on Earth’s electric field and production of NOx. - Accuracy expressed as Hit Rate (HR) and False Alarm Rate (FAR).	28
111	Cloud cover	Fraction of sky filled by clouds, in several layers.  Requested in the troposphere (assumed height: 12 km), and as projection of the total column - Physical unit: [ % ] - Accuracy unit: [ % ].	4
118	Precipitation index (daily cumulative)	Cumulative precipitation over a 24-hour period.	6
116	Precipitation rate (liquid) at the surface	Rate of precipitation reaching the ground - Physical unit: [ mm/h ] (if solid, mm of liquid water after melting) - Accuracy unit: [ mm/h ].	6
44	Atmospheric Chemistry - CO2 (column/profile)	CO2 = Carbon dioxide.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) + Total column - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
212	Atmospheric Chemistry - COS (column/profile)	COS = Carbonyl sulfide.  Requested from surface to low stratosphere (layers: LT, HT, LS) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
127	Cloud drop size (at cloud top)	Vertical profile of the size distribution of liquid water drops, assimilated to spheres of the same volume.  Requested in the troposphere (assumed height: 12 km), and at the cloud top surface - Physical unit: [ mm ] - Accuracy unit: [ mm ].	5
109	Cloud imagery	Intended for observation of features like cloud occurrence, pattern, frontal bands, cyclones, volcanic ash plumes.	4
233	Cloud mask	Binary product (cloud or cloud-free) derived from Cloud imagery - Accuracy expressed as Hit Rate [ HR ] and False Alarm Rate [ FAR ].	4
117	Precipitation rate (solid) at the surface	Rate of precipitation reaching the ground - Physical unit: [ mm/h ] (if solid, mm of liquid water after melting) - Accuracy unit: [ mm/h ].	6
224	Atmospheric Chemistry - HCFC-22 (column/profile)	HCFC-22 = Chlorodifluoromethane or difluoromonochloromethane . Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
89	Atmospheric Chemistry - HCl (column/profile)	HCl = Hydrogen chloride.  Requested from mid-troposphere to TOA (layers: HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
225	Atmospheric Chemistry - HDO (column/profile)	HDO = Water vapour (with one hydrogen nucleus replaced by its deuterium isotope).  Requested from low stratosphere to TOA (layers: LS and HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
219	Oil spill cover	Fraction of an ocean area polluted by hydrocarbons release from ships, accidental or deliberate.  Impacting on ocean-atmosphere exchanges.  Requested in both open ocean and coastal zone - Physical unit: [ % ] - Accuracy unit: [ % ].	3
24	Cloud ice (column/profile)	Vertical profile of atmospheric water in the solid phase (precipitating or not).  Requested in the troposphere (assumed height: 12 km), and as total column - Physical unit: profile [ g/kg ], total column [g/m2] - Accuracy unit: profile [ % ], total column [g/m2].	5
112	Cloud ice content (at cloud top)	Vertical profile of the size distribution of ice particles, assimilated to spheres of the same volume.  Requested in the troposphere (assumed height: 12 km), and at the cloud top surface - Physical unit: [ mm ] - Accuracy unit: [ mm ].	5
232	Cloud ice effective radius (column/profile)	Area weighted mean radius of the cloud droplets.	5
113	Cloud top height	Height of the upper surface of the cloud - Physical unit: [ km ] - Accuracy unit: [ km ].	4
114	Cloud top temperature	Temperature of the upper surface of the cloud - Physical unit: [ K ] - Accuracy unit: [ K ].	4
220	Aerosol absorption optical depth (column/profile)	Optical depth (OD) is the integral of extinction in the vertical dimension (integral of extinction (km-1) dz).  The transmittance of the atmosphere = T = Exp(-OD) = Exp(-Integral(extinction dz)).	1
139	Atmospheric specific humidity (at surface)	In a system of moist air, the ratio of the mass of water vapor to the total mass of the system. Conventionally measured at 2 m height [Unit of measurement- g/kg]	2
13	Atmospheric specific humidity (column/profile)	Vertical profile of the specific humidity in the atmosphere - Requested from surface to TOA (layers: LT, HT, LS, HS&M) + Total column - Physical units: [ g/kg ] for profile, [ kg/m2 ] for total column - Accuracy unit: [ % ] for profile, [ kg/m2 ] for total column.	2
84	Atmospheric Chemistry - HNO3 (column/profile)	HNO3 = Nitric acid.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) + Total column - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
79	Atmospheric Chemistry - N2O (column/profile)	N2O = Nitrous oxide.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
226	Atmospheric Chemistry - N2O5 (column/profile)	N2O5 = Nitrogen pentoxide.  Requested in the troposphere (layers: LT, HT) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
210	Turbulence	Random and continuously changing air motions which are superposed on the mean motion of the air. [Unit of measurement – classes]	3
5	Wind profile (horizontal)	Vertical profile of the horizontal vector component (2D) of the 3D wind vector - Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ m/s ] - Accuracy unit: [ m/s ] intended as vector error, i.e. the module of the vector difference between the observed vector and the true vector.	3
9	Wind profile (vertical)	A series of wind direction and wind speed measurements taken at various levels in the atmosphere that show the wind structure of the atmosphere over a specific location.	3
18	Cloud liquid water (column/profile)	Vertical profile of atmospheric water in the liquid phase (precipitating or not).  Requested in the troposphere (assumed height: 12 km), and as total column - Physical unit: profile [ g/kg ], total column [kg/m2] - Accuracy unit: profile [ % ], total column [kg/m2].	5
128	Cloud optical depth	Impact of the cloud water column on radiation propagation - Physical unit: [ dimensionless ] - Accuracy unit: [ % ].	5
110	Cloud type	Result of cloud type classification - Accuracy expressed as number of classes.  Actually [ classes-1 ] is used, so that smaller figure corresponds to better performance, as usual.	4
234	Freezing level height	Height of the atmospheric layer in cloud where liquid-solid states transform into each other - Physical unit: [ km ] - Accuracy unit: [ km ].	4
235	Melting layer depth in clouds	Depth of the atmospheric layer in cloud where liquid-solid states transform into each other - Physical unit: [ km ] - Accuracy unit: [ km ].	4
178	Fire temperature	Temperature of the fire occurring within an area - Physical unit: [ K ] - Accuracy unit: [ K ].	14
136	Atmospheric pressure (over land surface)	Pressure caused by the weight of the atmosphere. At sea level it has a mean value of one atmosphere but reduces with increasing altitude. Conventionally measured at 2 m height. [Unit of measurement - hPa]	25
137	Atmospheric pressure (over sea surface)	Pressure caused by the weight of the atmosphere. At sea level it has a mean value of one atmosphere but reduces with increasing altitude. Conventionally measured at 2 m height. [Unit of measurement - hPa]	25
126	Aerosol effective radius (column/profile)	Vertical profile of the size distribution of aerosol, assimilated to spheres of the same volume.  Requested in the troposphere (assumed height: 12 km) and as columnar average - Physical unit: [ mm ] - Accuracy unit: [ mm ].	1
29	Aerosol Extinction / Backscatter (column/profile)	A measure of radiation extinction at the encounter of aerosol particles in the atmosphere.	1
231	Water vapour imagery	Level-1 product (not a geophysical parameter).  Multi-channel imagery covering wavelengths in the range 0.4-14 µm including water vapour bands for atmospheric tracing in clear-air at more levels (e.g., for winds) - Accuracy expressed as Modulation Transfer Function (MTF) at the Nyquist spatial wavelength (twice the resolution).  Actually [ MTF-1 ] is used, so that smaller figures correspond to better performance, as usual.	2
69	Atmospheric Chemistry - NO (column/profile)	NO = Nitric oxide.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
74	Atmospheric Chemistry - NO2 (column/profile)	NO2 = Nitrogen peroxide.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) + Total column - Physical unit: [ ppm ] for profile, units of [1.3×1015 molecules/cm2 ] for total column - Accuracy unit: [ % ] for profile, [1.3×1015 cm-2 ] for total column.	9
227	Atmospheric Chemistry - OClO (column/profile)	OClO = chlorate.   Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
140	Wind speed over land surface (horizontal)	The rate at which air is moving horizontally past a given point. It may be a 2-minute average speed (reported as wind speed) or an instantaneous speed (reported as a peak wind speed, wind gust, or squall). Conventionally measured at 10 m height. [Unit of measurement - m/s]	3
142	Wind vector over land surface (horizontal)	The wind vector represents the motion of the airmass over the ground. It is described by wind speed and the inverse of wind direction. Conventionally measured at 10 m height.Accuracy is the modulus of the vector difference between measured and true vectors. [Unit ofmeasurement - m/s]	3
21	Precipitation Profile (liquid or solid)	Vertical profile of the precipitation rate - Physical unit: [ g×s-1×m-2 ] (vertical flux of precipitation water mass) - Accuracy unit: [ % ].	5
170	Land surface temperature	Temperature of the apparent surface of land (bare soil or vegetation) - Physical unit: [ K ] - Accuracy unit: [ K ].	14
169	Permafrost	Fraction of an area that is persistently frozen (round the year) - Physical unit: [ % ] - Accuracy unit: [ % ].	14
171	Soil moisture at the surface	Fractional content of water in a volume of wet soil.  Surface layer (upper few centimetres) - Physical unit: [ m3/m3 ] - Accuracy unit: [m3/m3 ].	12
239	Soil moisture in the roots region	Sub-soil vertical profile of the fractional content of water in a volume of wet soil.  Requested from surface down to ~ 3 m - Physical unit: [ m3/m3 ] - Accuracy unit: [m3/m3 ].	12
183	Land surface topography	Map of land surface heights - Physical unit: [ m ] - Accuracy unit: [ m ].	11
259	Black and white sky albedo	-	10
218	Earth surface albedo	Hemispherically integrated reflectance of the Earth’s surface in the range 0.4-0.7 µm (or other specific short-wave ranges) - Physical unit: [ % ] - Accuracy unit: [ % ].	10
144	Sea surface temperature	Temperature of the sea water at the depth of 2 m (“bulk” temperature).  In effect, the observation is more significant of the upper level (< 1 mm, “skin” temperature) if measured in IR, closer to the bulk temperature if measured in MW -Physical unit: [ K ] - Accuracy unit: [ K ].	19
119	Atmospheric stability index	Generic term to indicate a family of methods to infer thetemperature difference between an air parcel affected by vertical motion and the surrounding environment. Supportive of temperature profile and specific humidity profile). [Unit ofmeasurement - K]	25
138	Atmospheric temperature (at surface)	Conventionally measured at 2 m height. [Unit of measurement- K]	25
1	Atmospheric temperature (column/profile)	Vertical profile of the atmospheric temperature - Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ K ] - Accuracy unit: [ K ].	25
249	Active Fire Detection	-	15
257	Aerosol layer height	-	1
33	Aerosol optical depth (column/profile)	The aerosol optical depth or optical thickness (τ) is defined as the integrated extinction coefficient over a vertical column of unit cross section.	1
256	Aerosol single scattering albedo	-	1
64	Atmospheric Chemistry - OH (column/profile)	OH = Hydroxil radical.  Requested from surface to TOA (layers: LT, HT, LS, HS&M) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
228	Atmospheric Chemistry - PAN (column/profile)	PAN = Peroxy Acetyl Nitrate.  Requested in the troposphere (layers: LT, HT) - Physical unit: [ ppm ] - Accuracy unit: [ % ].	9
175	Fractionally absorbed PAR (FPAR)	Fraction of PAR absorbed by vegetation (land or marine) for photosynthesis processes (generally around the “red”) - Physical unit: [ % ] - Accuracy unit: [ % ].	10
174	Photosynthetically Active Radiation (PAR)	Flux of downwelling photons of wavelength 0.4-0.7 µm at surface - Physical unit: [ µ einstein ٠ m-2 s-1 ] (1 einstein = 6 ٠ 1023 photons); most frequently used: [ W/m2 ] - Accuracy unit: [ W/m2 ].	10
115	Cloud base height	Height of the bottom surface of the cloud - Physical unit: [ km ] - Accuracy unit: [ km ].	25
122	Height of the top of the Planetary Boundary Layer	Height of the surface separating the PBL from the free atmosphere - Physical unit: [ km ] - Accuracy unit: [ km ].	25
120	Height of tropopause	Height of the surface separating the troposphere from the stratosphere - Physical unit: [ km ] - Accuracy unit: [ km ].	25
177	Fire area	Fraction of fire occurring in an area - Physical unit: [ % ] - Accuracy unit: [ % ].	15
168	Glacier topography	Relates to glacier thickness typically found in mid to high latitudes with a volume/area coverage much smaller than an ice-sheet. [Unit of measurement - cm]	15
181	Land surface imagery	Level-1 product (not a geophysical parameter).  High-resolution imagery covering wavelengths in the range 0.4-1 µm (cloud-affected) or 1-10 GHz (SAR, all-weather) - Accuracy expressed as Modulation Transfer Function (MTF) at the Nyquist spatial wavelength (twice the resolution).  Actually [ MTF-1 ] is used, so that smaller figures correspond to better performance, as usual.	15
207	Visibility	The aerosol optical depth or optical thickness (τ) is defined as the integrated extinction coefficient over a vertical column of unit cross section.	1
209	Volcanic ash	The location of a volcanic ash cloud. [Unit of measurement – Lat/Long]	1
141	Wind speed over sea surface (horizontal)	Horizontal vector component (2D) of the 3D wind vector over the sea surface - Physical unit: [ m/s ] - Accuracy unit: [ m/s ] intended as vector error, i.e. the module of the vector difference between the observed vector and the true vector.	18
157	Sea-ice type	Parameter convolving several factors (age, roughness, density, etc.) - Accuracy expressed as number of classes.  Actually [ classes-1 ] is used, so that smaller figure corresponds to better performance, as usual.	24
\.


--
-- Name: measurements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('measurements_id_seq', 1, false);


--
-- Data for Name: measurements_of_instrument; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY measurements_of_instrument (instrument_id, measurement_id) FROM stdin;
645	123
697	218
697	183
697	181
697	154
697	153
697	156
697	157
697	166
697	167
697	163
697	176
988	218
988	159
988	183
988	181
988	154
988	156
988	157
988	166
988	167
988	163
988	176
1733	218
1733	183
1733	181
1730	183
1730	181
1730	179
817	218
817	181
817	176
391	1
1625	5
1625	9
1625	141
1625	143
459	218
459	183
459	181
459	163
459	176
1732	218
1732	181
1732	176
1698	218
1698	181
1698	176
768	13
81	109
81	111
81	154
699	218
699	181
699	176
642	109
406	218
406	181
406	176
1680	179
966	174
966	175
966	181
966	172
966	173
966	176
1681	179
1776	181
14	5
14	109
14	110
14	111
14	114
77	140
718	29
718	218
718	181
718	149
78	13
78	5
78	110
78	116
78	144
1676	243
1676	183
1676	181
1676	179
1676	242
1539	181
1539	149
1539	176
1539	179
412	33
412	220
412	218
412	115
412	142
412	128
412	109
412	110
412	111
412	113
412	177
412	181
412	154
412	149
412	124
412	134
412	157
412	158
412	163
412	171
412	170
412	178
412	144
412	172
412	173
412	176
412	179
412	180
402	110
402	154
402	125
67	5
67	110
67	116
67	125
67	170
67	144
684	218
684	109
684	110
684	181
684	170
684	144
1637	174
1637	149
1637	150
1637	201
404	174
404	175
404	218
404	181
404	154
404	172
404	173
404	176
404	179
1504	33
1504	220
1504	13
1504	113
1504	34
1504	39
1504	49
1504	74
1504	94
1504	195
1504	215
1504	217
1664	174
1664	175
1664	218
1664	181
1664	154
1664	172
1664	173
1664	176
1664	179
137	13
137	1
137	119
137	111
137	113
137	116
137	144
942	220
942	13
942	113
942	34
942	39
942	49
942	74
942	94
942	195
942	215
942	217
860	187
1602	13
1602	144
941	33
941	220
941	113
941	34
941	74
941	94
941	195
941	215
941	217
949	29
949	33
949	220
949	13
949	34
949	39
949	49
949	74
949	215
1513	33
1513	34
1513	74
1513	94
1513	195
1513	215
1513	217
1697	181
1546	33
1546	34
1546	74
1546	195
1546	215
1536	33
1536	34
1536	74
1536	195
1536	215
679	123
679	125
764	185
764	194
1715	123
1724	13
1724	1
275	13
275	1
275	113
275	114
275	130
275	44
906	34
765	194
415	34
415	39
763	13
763	194
721	218
721	181
721	133
721	176
414	13
414	18
414	21
414	24
414	116
414	141
414	171
414	144
327	175
327	218
327	109
327	111
327	183
327	168
327	177
327	181
327	154
327	149
327	133
327	135
327	156
327	158
327	161
327	162
327	166
327	163
327	169
327	170
327	178
327	172
327	173
327	176
327	179
1524	218
1524	109
1524	111
1524	177
1524	135
1524	156
1524	158
1524	161
1524	166
1524	163
1524	169
1524	170
1524	178
1524	179
719	144
1746	218
1746	109
1746	111
1746	177
1746	135
1746	156
1746	158
1746	161
1746	166
1746	163
1746	169
1746	170
1746	178
1746	179
1712	144
644	123
1573	39
1573	44
1573	49
1573	79
1725	13
1725	1
1725	34
923	183
1655	136
1655	137
1655	34
1655	39
1655	44
1655	49
1655	225
1655	250
905	136
905	137
905	34
905	39
905	44
905	225
905	250
349	13
349	1
349	34
349	170
349	39
349	44
349	49
349	79
349	84
349	225
1654	33
1654	111
1654	172
904	33
904	111
904	172
1644	145
1644	146
1644	147
1644	236
141	238
771	5
771	34
569	181
568	181
929	149
929	144
329	1
329	121
156	125
741	264
908	207
908	174
908	175
908	218
908	1
908	177
908	181
908	154
908	156
908	161
908	166
908	172
908	173
908	176
908	179
908	180
742	264
861	187
453	13
453	18
453	116
452	1
452	18
740	187
634	187
454	13
454	1
454	116
454	165
454	171
635	187
635	188
451	13
451	18
451	116
451	141
451	163
451	165
451	171
633	264
903	13
903	184
903	159
903	183
903	141
903	148
903	194
903	145
903	156
903	193
1672	34
1672	74
1672	215
739	238
1671	44
1558	44
321	174
321	175
321	218
321	13
321	128
321	183
321	181
321	124
321	125
321	129
321	131
321	132
321	133
321	134
321	135
321	170
321	144
321	176
321	179
321	180
369	13
369	1
369	34
369	69
369	79
369	89
369	94
369	99
369	104
330	29
330	126
330	220
330	13
330	1
330	119
330	111
330	113
330	116
330	34
330	170
330	144
868	44
761	125
789	13
789	1
789	144
1529	33
1529	220
1529	123
1529	124
663	29
663	220
663	13
663	1
663	34
663	39
663	54
663	59
663	74
663	79
663	84
663	104
1587	34
1587	84
1587	89
1587	94
1587	99
419	123
1763	156
1763	157
1763	158
1763	166
1763	253
743	13
743	1
743	34
743	49
743	79
743	84
743	99
760	125
975	123
975	124
975	125
902	177
902	158
902	170
902	178
902	144
769	218
769	181
769	133
769	173
769	176
769	179
769	242
1632	123
1632	124
1632	125
944	218
944	181
944	172
944	173
944	176
944	179
944	242
688	159
688	183
688	193
1755	109
1755	177
1755	181
1755	156
1755	163
1694	218
1694	177
1694	181
1694	163
1693	109
1693	177
1693	181
1693	156
1693	163
626	123
901	33
901	174
901	175
901	218
901	128
901	110
901	111
901	113
901	114
901	181
901	149
901	150
901	151
901	156
901	158
901	163
901	246
901	251
901	170
901	144
901	172
901	173
901	176
1502	238
1502	187
1502	188
218	34
683	187
65	238
65	187
65	188
302	13
302	119
302	5
302	109
302	110
302	111
302	113
302	114
302	116
302	34
302	132
302	133
302	170
302	144
302	176
367	29
367	33
367	220
367	113
367	34
367	133
367	39
367	44
367	49
367	74
367	79
367	94
367	195
367	227
637	238
637	187
637	188
952	187
427	143
1704	267
1512	143
869	143
752	143
1645	143
1703	141
972	141
345	218
345	181
345	141
345	143
345	166
345	171
345	176
345	179
1749	143
864	125
864	129
864	130
318	34
318	125
177	34
177	125
1665	171
1631	141
1631	143
382	109
382	110
382	111
382	124
826	218
826	183
826	181
826	194
1521	219
1521	163
1521	171
1521	241
1521	242
731	219
731	159
731	183
731	181
731	248
731	154
731	141
731	143
731	153
731	156
731	157
731	166
731	167
731	193
731	163
731	245
731	171
731	176
731	179
731	240
731	241
922	218
922	159
922	181
704	183
704	181
704	156
704	157
704	166
704	167
704	163
704	176
704	179
704	180
706	218
706	183
706	181
706	154
706	153
706	156
706	157
706	166
706	167
706	163
706	176
706	179
706	180
790	218
790	159
790	181
790	194
790	156
790	163
790	171
790	176
971	218
971	183
971	181
971	154
971	153
971	156
971	157
971	166
971	163
971	176
456	218
456	219
456	159
456	183
456	168
456	177
456	181
456	248
456	154
456	141
456	155
456	194
456	145
456	156
456	157
456	166
456	167
456	193
456	163
456	165
456	171
456	176
456	179
456	180
1695	179
800	219
800	156
800	157
800	161
800	179
703	218
703	219
703	159
703	183
703	168
703	177
703	181
703	248
703	154
703	141
703	153
703	155
703	194
703	145
703	156
703	157
703	166
703	167
703	193
703	163
703	165
703	171
703	176
703	179
703	180
946	218
946	219
946	159
946	183
946	168
946	177
946	181
946	248
946	154
946	141
946	153
946	155
946	194
946	145
946	156
946	157
946	166
946	167
946	193
946	163
946	165
946	169
946	176
946	179
946	180
348	29
348	220
348	13
348	1
348	113
348	34
348	74
348	94
357	29
357	220
357	13
357	1
357	9
357	113
357	34
357	74
357	94
659	29
659	220
659	13
659	1
659	113
659	34
659	74
659	94
1598	29
1598	13
1598	1
1598	34
1598	74
1598	227
675	13
821	13
821	1
821	34
821	69
927	138
715	125
1706	266
766	185
958	13
958	136
958	137
1628	13
1628	1
194	13
194	18
194	116
194	143
194	156
194	193
194	163
899	1
899	138
193	159
193	154
193	143
193	194
193	145
193	156
193	193
1744	238
837	218
837	183
837	181
1716	123
1716	124
1716	125
1716	131
1716	132
1716	134
1716	135
1738	143
968	116
995	116
1640	238
967	13
967	141
967	156
967	144
912	218
912	181
913	218
913	181
379	13
379	184
379	159
379	183
379	141
379	148
379	194
379	145
379	156
379	193
378	13
378	184
378	159
378	183
378	141
378	148
378	194
378	145
378	156
378	193
834	218
834	177
834	181
834	156
834	163
834	179
1516	159
1516	243
1516	183
1516	168
1516	181
1516	162
1516	163
1516	176
1516	179
1516	241
836	218
836	183
836	181
443	218
443	183
443	181
1723	184
1723	183
1723	141
1723	148
1723	145
762	125
1761	21
1761	116
1633	184
1633	183
1633	141
1633	148
1633	145
337	219
337	21
337	116
829	184
829	183
829	141
829	148
829	145
751	33
751	175
930	152
18	141
18	148
18	145
793	33
793	220
793	218
793	13
793	181
793	173
390	33
390	220
390	218
390	13
390	181
390	173
182	184
182	183
182	141
182	148
182	145
646	187
646	188
707	187
707	188
100	125
1650	187
1650	188
1517	209
1517	220
1517	113
1517	114
1517	118
1517	156
1517	163
1517	144
1517	242
1722	240
1722	241
1514	219
1514	181
1514	179
1601	13
1601	1
1601	136
1601	137
1601	110
1601	34
1601	39
1601	44
1601	49
1601	74
1601	84
1601	94
1601	228
962	218
962	181
1600	237
1600	238
1600	263
1600	187
613	174
613	175
613	218
613	181
613	149
613	131
613	133
613	172
613	173
613	176
613	179
613	180
914	181
914	179
700	218
700	110
700	181
700	133
700	176
1592	179
446	218
446	159
446	183
446	181
832	179
1659	181
1610	181
857	218
857	183
857	181
1675	181
917	218
917	181
867	218
867	110
867	181
867	176
436	218
436	183
436	181
1647	218
1647	183
796	218
796	181
1728	183
1728	181
1728	179
1586	218
1586	183
1586	181
989	188
1747	218
1747	181
364	218
364	159
364	183
364	177
364	181
364	154
364	143
364	156
364	157
364	161
364	162
364	167
364	163
364	164
364	171
364	176
977	218
977	181
1729	183
1729	181
1729	179
1589	218
1589	219
1589	191
1589	159
1589	183
1589	177
1589	181
1589	154
1589	143
1589	156
1589	157
1589	161
1589	167
1589	163
1589	164
1589	171
1589	176
1718	29
1718	34
681	33
681	34
734	13
734	154
734	149
437	33
437	220
437	34
437	94
336	218
336	183
336	177
336	181
336	156
336	163
336	172
336	176
336	179
662	29
662	220
662	1
662	34
662	74
662	94
1769	175
1769	218
1769	109
1769	111
1769	183
1769	168
1769	177
1769	181
1769	154
1769	149
1769	155
1769	133
1769	135
1769	156
1769	158
1769	161
1769	162
1769	166
1769	163
1769	169
1769	178
1769	172
1769	173
1769	176
1769	179
450	115
450	110
450	111
450	113
450	163
1754	218
1754	183
1754	181
791	218
791	181
630	29
630	33
630	220
630	110
630	34
630	39
896	29
896	33
896	126
896	209
896	174
896	175
896	218
896	115
896	136
896	137
896	21
896	128
896	111
896	177
896	181
896	154
896	149
896	150
896	151
896	201
896	172
896	173
896	176
896	179
897	175
897	218
897	109
897	111
897	183
897	168
897	177
897	181
897	154
897	149
897	155
897	133
897	135
897	156
897	158
897	161
897	162
897	166
897	163
897	169
897	178
897	172
897	173
897	176
897	179
359	149
359	153
359	144
1527	218
1527	13
1527	1
935	29
935	149
1597	154
464	29
464	33
464	126
464	149
464	150
1638	29
1638	151
1595	218
1595	181
916	218
916	181
812	249
812	170
812	178
812	144
1710	265
647	134
915	218
915	181
1663	13
1663	1
1663	21
1663	116
1663	117
1663	141
1663	156
1531	33
1531	220
672	13
672	1
672	120
672	121
672	18
672	112
672	110
672	116
672	141
672	156
672	163
672	171
672	170
672	144
925	218
925	181
895	1
895	170
1611	181
1611	176
222	156
222	193
222	163
222	144
1621	13
1621	1
1621	34
185	13
262	13
1630	13
1630	116
1630	144
803	231
803	116
803	141
803	156
667	13
667	1
667	34
13	33
13	126
13	109
13	111
13	114
13	177
13	125
13	156
13	144
13	172
671	218
671	13
671	5
671	110
671	111
671	116
671	181
671	163
671	171
671	170
671	144
671	172
1775	181
669	13
394	13
394	5
394	109
394	111
394	113
394	114
394	116
394	144
180	33
180	126
180	209
180	218
180	109
180	111
180	114
180	177
180	181
180	154
180	125
180	156
180	163
180	170
180	178
180	144
180	172
1774	218
1774	181
1774	176
1726	218
1726	181
1726	176
1540	135
1540	170
1731	218
1731	181
1731	176
818	218
818	181
818	176
1658	218
1658	181
1658	176
1727	218
1727	181
1727	176
1674	181
1532	149
1532	151
792	218
792	181
1525	240
1525	241
1525	242
673	13
673	1
673	120
673	18
673	110
673	116
673	141
673	156
673	170
673	144
196	218
196	181
570	181
779	29
779	33
779	126
779	218
779	109
779	113
779	116
779	177
779	181
779	154
779	125
779	133
779	156
779	193
779	163
779	170
779	144
779	172
191	218
191	181
191	154
191	133
191	156
191	193
195	218
195	181
777	218
777	181
777	154
777	176
852	154
852	149
852	150
852	151
1692	110
1692	177
1692	156
1692	163
1692	170
1692	242
784	13
784	119
784	5
784	109
784	110
784	111
784	113
784	114
784	116
784	177
784	34
784	132
784	133
784	163
784	170
784	144
784	172
1691	13
1691	119
1691	5
1691	109
1691	110
1691	111
1691	113
1691	114
1691	116
1691	177
1691	34
1691	132
1691	133
1691	163
1691	170
1691	144
1691	172
980	218
980	177
980	181
980	163
228	218
228	181
567	218
567	181
567	176
328	1
328	116
835	218
835	177
835	181
835	163
80	231
80	154
80	163
794	218
794	181
794	154
794	156
794	163
794	170
794	176
794	179
465	5
465	116
465	154
465	143
465	194
465	156
465	193
465	144
940	174
940	175
940	218
940	177
940	181
940	200
940	172
940	173
940	176
940	179
940	180
326	177
326	161
326	162
938	29
938	126
938	127
938	128
938	109
938	110
938	113
831	218
831	111
831	181
831	156
831	166
831	163
831	176
831	179
976	218
976	181
735	218
735	183
735	181
735	176
1748	218
1748	181
1690	218
1690	177
1690	181
1690	163
217	18
217	110
217	156
217	193
217	163
216	156
216	193
216	163
462	29
462	33
462	126
462	110
462	149
858	218
858	181
858	176
1689	218
1689	177
1689	181
1689	163
119	49
1700	237
1700	238
353	13
353	1
353	34
353	39
395	33
395	126
395	174
395	175
395	218
395	13
395	1
395	119
395	112
395	127
395	128
395	109
395	111
395	113
395	114
395	177
395	181
395	154
395	149
395	150
395	151
395	34
395	135
395	201
395	156
395	163
395	170
395	178
395	144
395	172
395	173
395	176
395	179
722	209
722	218
722	177
722	181
722	154
722	150
722	176
126	13
126	1
126	112
126	34
126	49
126	64
126	79
126	84
126	89
126	94
126	99
126	195
807	218
807	181
807	154
807	150
807	179
725	187
725	188
689	152
689	171
396	33
396	126
396	220
396	175
396	218
396	5
396	109
396	111
396	113
396	149
396	124
396	129
396	131
396	133
396	172
396	173
396	176
223	13
223	110
223	116
223	156
223	193
223	163
223	144
795	218
795	181
795	170
795	176
795	179
215	13
215	110
215	116
215	156
215	193
215	163
215	144
1709	187
338	13
338	1
338	34
338	39
338	44
338	49
338	54
338	59
338	69
338	74
338	79
338	84
338	104
996	13
996	1
1548	33
1548	13
1548	1
1548	34
1548	49
1548	79
1548	84
1548	99
1548	195
965	1
965	109
965	116
965	181
965	152
965	156
965	158
965	170
965	144
304	13
304	18
304	21
304	110
304	116
670	13
670	1
894	33
894	218
894	13
894	231
894	5
894	109
894	110
894	113
894	114
894	233
894	116
894	181
894	154
894	125
894	131
894	156
894	163
894	170
894	144
79	109
79	181
79	154
1620	149
1620	150
1620	151
1620	176
1620	179
1759	149
1759	150
1759	151
1759	176
1759	179
893	149
893	150
893	151
893	176
893	179
320	33
320	174
320	175
320	218
320	18
320	128
320	109
320	110
320	113
320	181
320	154
320	149
320	150
320	151
320	133
320	156
320	163
320	176
892	218
892	142
892	109
892	111
892	181
892	154
892	143
892	170
892	144
702	29
702	13
702	18
702	34
702	74
918	119
919	119
920	29
920	33
920	220
1768	33
1768	220
1768	109
1768	113
1768	133
878	187
878	188
368	13
368	34
368	49
368	74
368	84
368	94
368	99
368	104
1594	111
1594	44
1594	49
1594	74
865	21
865	110
865	116
865	141
1713	29
770	218
770	181
770	154
770	133
770	176
708	187
708	188
1510	185
1510	186
1510	190
1510	191
106	185
106	148
106	194
1678	179
891	210
891	208
891	69
891	74
1639	237
1679	179
461	218
461	183
461	181
461	163
461	176
969	208
110	208
1773	218
1773	183
1773	181
1773	163
1773	176
444	218
444	183
444	181
444	163
444	176
439	218
439	183
439	181
439	163
439	176
934	175
934	218
934	183
934	181
934	163
934	176
1533	29
1533	113
335	218
335	183
335	177
335	181
335	161
335	162
335	167
335	163
335	164
335	176
1526	183
1526	248
1526	167
1526	242
890	208
772	185
772	186
772	190
772	191
986	171
1554	171
819	218
819	183
819	181
819	154
819	153
819	156
819	157
819	166
819	167
819	163
819	176
29	185
767	185
1542	159
1542	183
1542	193
711	185
221	110
221	156
221	193
221	163
221	144
1544	163
1544	164
1544	165
214	110
214	156
214	193
214	163
214	144
801	218
801	109
801	177
801	181
801	156
801	163
1545	246
107	13
107	148
107	194
107	145
1541	183
1541	247
1541	254
1541	148
1541	194
695	231
695	5
695	109
695	110
695	113
695	118
695	144
213	125
1745	264
665	218
665	1
665	18
665	109
665	110
665	116
665	181
665	154
665	133
665	170
665	144
665	176
410	218
410	181
410	170
1708	264
866	218
866	181
866	170
950	13
950	1
950	5
1673	181
666	13
666	1
666	121
666	138
666	113
666	114
666	34
666	125
666	170
666	144
666	44
732	218
732	110
732	181
732	133
732	170
732	144
1547	49
1528	125
1528	200
825	218
825	181
825	135
1590	39
1538	39
1538	49
332	1
332	115
332	170
747	187
747	188
668	13
668	1
331	5
331	109
331	114
331	116
331	177
331	154
331	125
331	170
331	178
331	144
466	231
466	5
466	109
466	110
466	113
466	118
466	144
788	5
593	174
593	175
593	218
593	181
593	149
593	131
593	133
593	172
593	173
593	176
593	179
593	180
778	13
778	1
778	18
778	110
778	111
778	34
778	170
778	144
778	39
333	29
333	220
333	34
333	39
333	54
333	79
333	84
1688	110
1688	177
1688	156
1688	163
1688	170
1688	242
334	29
334	220
334	13
334	1
334	34
334	39
334	54
334	59
334	74
334	79
334	84
334	104
696	109
696	111
729	123
1662	13
1662	116
1662	144
1607	181
1607	166
1626	13
1626	1
1626	138
1626	34
1626	49
1608	176
926	176
627	33
627	218
627	219
627	177
627	181
627	133
627	156
627	166
627	193
627	163
627	170
627	144
627	172
627	173
627	176
627	179
627	180
627	242
1612	176
1612	179
305	13
305	1
305	138
305	114
305	34
305	125
305	132
305	134
305	135
305	170
305	144
305	39
305	44
305	49
305	79
924	176
994	13
994	1
713	218
713	181
1613	163
1613	176
724	249
724	163
705	209
705	218
705	181
705	176
824	174
824	175
824	218
824	109
824	110
824	114
824	181
824	154
824	149
824	150
824	151
824	133
824	156
824	193
824	163
824	176
964	209
964	218
964	181
964	176
805	208
805	156
698	177
698	178
442	13
442	18
1636	249
1636	156
1605	33
1696	181
26	183
26	177
26	181
26	154
26	176
26	179
1711	181
723	181
723	163
723	176
1604	44
19	218
19	183
19	177
19	181
19	161
19	162
19	178
19	176
19	179
759	159
759	243
759	183
759	176
1606	176
1606	179
1520	181
1757	181
1609	170
1609	178
97	1
97	5
97	39
1603	183
1603	168
1603	181
1603	176
183	181
183	154
183	156
183	176
309	13
309	1
309	121
309	113
309	114
309	34
309	125
309	170
309	44
564	13
564	1
564	113
564	114
564	34
564	125
564	170
564	144
564	44
887	159
887	183
887	181
887	179
1634	218
1634	219
1634	111
1634	181
1634	154
1634	149
1634	151
1634	172
1634	173
1634	176
1634	179
1634	180
1634	242
351	29
351	33
351	220
351	13
351	1
351	113
351	34
351	39
351	54
351	59
351	74
351	79
351	84
351	104
351	226
313	13
313	1
313	121
313	21
313	113
313	114
313	34
313	125
313	170
313	144
313	44
1737	154
1551	140
1551	142
1551	143
1753	149
1753	157
1753	163
1753	144
1753	179
1753	180
1753	242
350	13
350	1
350	34
350	39
350	69
350	74
350	89
961	218
961	181
1740	181
1686	149
1686	157
1686	163
1686	144
1686	179
1686	180
1686	242
306	13
306	1
1687	149
1687	157
1687	163
1687	144
1687	179
1687	180
1687	242
1553	13
1553	1
987	185
987	187
987	188
987	194
987	171
1752	149
1752	157
1752	163
1752	144
1752	179
1752	180
1752	242
682	13
682	1
682	121
943	185
105	185
105	194
983	185
983	148
983	194
1552	13
1552	1
786	185
786	186
366	29
366	13
366	1
366	34
366	74
710	13
710	1
370	13
370	111
370	34
370	123
370	133
370	74
370	94
370	195
370	227
726	13
726	1
726	185
881	13
881	1
773	13
773	18
773	21
773	24
773	116
773	141
773	135
773	171
773	144
307	33
307	220
307	13
307	113
307	34
307	123
307	124
307	125
1619	13
1619	1
877	208
886	149
1720	33
1720	1
1720	185
1779	13
1779	1
421	29
421	128
421	110
421	159
421	183
421	193
631	29
631	13
631	1
631	5
631	18
631	110
631	116
631	154
631	34
631	125
631	133
631	170
631	144
631	39
1685	187
1685	188
362	29
362	126
362	220
362	128
362	110
362	111
362	113
362	114
362	154
362	149
362	150
362	133
362	156
362	163
362	172
362	176
853	187
853	188
303	124
303	125
1583	220
1583	34
1583	74
1583	195
1543	13
1543	1
1543	120
1543	121
1543	142
1543	18
1543	21
1543	116
1543	170
1543	144
1684	218
1684	183
1684	177
1684	181
1684	156
1684	163
847	187
847	188
844	218
844	183
844	177
844	181
1717	240
1618	44
1707	237
885	209
885	13
885	119
885	5
885	127
885	128
885	109
885	110
885	111
885	113
885	114
885	116
885	177
885	34
885	132
885	133
885	156
885	158
885	163
885	170
885	144
885	172
885	176
1705	263
603	187
603	188
1648	238
884	124
884	125
1582	124
1582	125
1582	131
1582	132
1582	134
1582	135
1617	123
1617	124
1617	125
322	175
322	218
322	109
322	111
322	183
322	168
322	177
322	181
322	154
322	149
322	133
322	135
322	156
322	158
322	161
322	162
322	166
322	163
322	169
322	170
322	178
322	172
322	173
322	176
322	179
1537	219
1537	149
143	124
143	125
733	218
733	183
733	181
1615	33
1615	111
1615	34
691	184
691	185
691	186
709	187
709	188
862	262
1714	170
774	21
774	116
389	190
389	194
1734	181
1669	141
775	13
775	116
775	171
775	144
181	184
181	148
1505	139
1511	154
1511	149
1511	151
1511	201
970	136
828	218
828	181
828	150
828	156
1519	219
1519	183
1519	181
1519	156
1519	157
1519	166
1519	167
1519	163
1519	165
1519	171
1519	179
1519	180
990	187
325	13
325	1
325	136
325	137
325	44
1523	183
1523	181
1523	179
1767	151
649	115
649	18
649	21
649	24
649	112
649	128
649	109
649	110
649	111
649	116
649	117
649	132
372	115
372	18
372	21
372	24
372	112
372	128
372	109
372	110
372	111
372	113
372	116
372	117
909	218
909	181
1534	1
1534	44
745	34
680	13
680	115
680	18
680	24
680	116
680	117
680	143
680	206
680	158
680	163
680	171
680	170
680	144
1535	49
1739	179
827	144
1701	123
1736	124
1736	200
1666	249
1666	170
1530	115
1530	137
1530	18
1530	21
1530	24
1530	112
1530	128
1530	109
1530	110
1530	111
1530	116
1530	117
1530	132
1782	249
1782	170
720	29
720	220
720	174
720	175
720	218
720	1
720	181
720	149
720	150
720	151
720	133
720	172
720	173
720	176
720	179
720	180
1646	123
1646	124
1646	125
1646	131
1646	132
1646	134
1646	135
1656	237
787	218
787	110
787	181
432	13
432	1
431	187
431	188
397	123
397	124
397	125
397	131
397	132
397	134
397	135
430	184
430	185
823	218
823	181
1762	183
1762	181
1762	155
1762	172
1762	176
1762	179
1762	240
1762	242
409	218
409	181
409	176
1657	183
1735	29
1735	33
1735	115
1735	128
1735	110
1735	113
939	183
939	181
939	154
939	141
939	143
939	153
939	155
939	145
939	146
939	147
939	156
939	157
939	161
939	163
939	171
939	176
219	34
1751	156
1751	157
1751	179
820	29
820	33
820	115
820	24
820	128
820	232
820	113
921	218
921	159
921	181
226	5
226	110
226	111
226	116
226	156
226	193
226	163
910	218
910	181
911	218
911	181
1750	156
1750	157
1750	179
1756	181
900	156
900	157
900	179
937	124
937	125
363	218
363	183
363	177
363	181
363	156
363	163
363	172
363	176
363	179
460	175
460	218
460	183
460	181
460	166
460	163
460	176
405	218
405	181
405	176
324	29
324	126
324	220
324	218
324	110
324	116
324	181
324	154
324	125
324	133
324	156
324	193
324	163
324	170
324	144
324	176
358	218
358	183
358	181
358	179
408	33
408	220
408	218
408	110
408	181
408	154
408	133
408	170
408	144
408	176
383	13
403	33
403	126
403	209
403	220
403	175
403	218
403	109
403	111
403	116
403	177
403	181
403	154
403	125
403	131
403	133
403	156
403	193
403	163
403	170
403	144
403	172
407	29
407	33
407	220
407	218
407	13
407	1
407	110
407	116
407	181
407	154
407	34
407	133
407	170
407	144
407	176
310	109
310	177
310	125
310	163
310	144
310	172
276	13
276	1
276	113
276	116
276	34
276	44
933	119
374	29
374	33
374	115
374	18
374	21
374	24
374	128
374	113
416	218
416	110
416	159
416	183
416	181
416	133
416	135
416	156
416	193
416	170
1616	13
1616	1
1616	34
308	141
308	156
308	157
308	171
413	13
413	1
413	136
413	137
413	21
413	116
413	117
413	141
413	156
413	170
859	188
998	29
998	128
998	110
998	243
998	183
998	193
261	141
261	143
261	153
261	145
261	146
261	147
1599	218
1599	159
1599	183
1599	177
1599	181
1599	154
1599	143
1599	156
1599	157
1599	161
1599	162
1599	167
1599	163
1599	164
1599	171
1599	176
846	187
344	159
344	183
344	181
344	154
344	141
344	153
344	145
344	146
344	147
344	156
344	157
344	167
344	163
344	171
344	176
260	183
260	181
260	154
260	141
260	143
260	153
260	155
260	145
260	156
260	157
260	161
260	162
260	167
260	163
260	171
260	176
260	179
851	13
851	1
664	13
664	18
664	116
664	141
664	156
664	165
664	171
664	144
736	29
736	18
985	141
1555	13
1555	1
1555	120
1555	121
1555	18
1555	110
1555	116
1555	141
1555	135
1555	156
1555	163
1555	165
1555	171
1555	170
984	152
1772	218
1772	181
312	13
312	1
312	120
312	121
312	18
312	110
312	116
312	141
312	135
312	156
312	163
312	165
312	171
312	170
323	13
323	5
323	18
323	110
323	116
323	156
323	163
323	165
1719	13
1719	148
1719	194
434	141
434	145
434	146
434	147
882	13
882	148
882	194
883	13
883	18
883	116
883	141
883	156
883	165
883	171
883	144
435	143
435	156
435	157
435	171
435	176
360	13
360	18
360	116
360	118
360	141
360	156
360	163
360	165
360	171
360	144
433	159
433	183
433	181
433	154
433	155
433	145
433	156
433	157
433	167
433	163
433	171
433	176
678	143
678	194
678	145
422	175
422	218
422	181
422	133
422	156
422	166
422	193
422	163
422	170
422	144
422	176
422	179
422	180
422	242
973	148
973	194
973	145
1593	209
1593	218
1593	181
1593	176
931	13
931	141
931	148
931	145
928	159
928	141
928	148
928	194
928	145
932	183
932	181
932	163
932	176
1614	183
1614	181
1614	176
347	13
347	1
347	111
347	113
347	114
347	118
347	34
347	129
347	132
347	133
347	134
347	135
347	156
347	163
347	170
347	144
347	39
347	44
347	49
1522	183
1522	181
1522	176
1651	209
1651	231
1651	119
1651	5
1651	109
1651	110
1651	113
1651	118
1651	144
1568	143
375	29
375	9
375	128
375	113
1574	33
1574	149
1565	218
1565	109
1565	177
1565	181
1565	156
1565	163
1564	29
1564	33
1564	126
1564	218
1564	109
1564	113
1564	116
1564	177
1564	181
1564	154
1564	125
1564	133
1564	156
1564	193
1564	163
1564	170
1564	144
1564	172
1567	13
1567	1
1567	120
1567	18
1567	110
1567	116
1567	141
1567	156
1567	170
1567	144
1575	33
1575	207
1575	218
1575	13
1575	231
1575	5
1575	18
1575	109
1575	110
1575	113
1575	114
1575	233
1575	116
1575	181
1575	154
1575	34
1575	125
1575	131
1575	156
1575	163
1575	245
1575	170
1575	144
1570	13
1570	1
1566	13
1566	1
1566	18
1566	110
1566	111
1566	34
1566	170
1566	144
1566	39
1569	219
1569	156
1569	157
1569	161
1569	179
1572	187
1572	188
418	123
863	185
870	33
870	209
870	5
870	18
870	21
870	112
870	127
870	128
870	109
870	110
870	111
870	113
870	114
870	116
870	118
870	177
870	154
870	123
870	131
870	132
870	170
870	178
870	144
701	29
701	220
701	1
701	120
701	121
701	5
701	18
701	34
701	39
701	44
701	49
701	54
701	59
701	69
701	74
701	79
701	84
701	89
701	104
701	221
701	222
701	224
701	226
701	230
411	33
411	220
411	218
411	110
411	181
411	154
411	133
411	156
411	170
411	144
411	176
1627	33
1627	175
211	13
211	1
211	34
\.


--
-- Data for Name: missions; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY missions (id, name, full_name, status, launch_date, eol_date, applications, orbit_type, orbit_period, orbit_sense, orbit_inclination, orbit_altitude, orbit_longitude, "orbit_LST", repeat_cycle) FROM stdin;
474	Baumanets	\N	Mission complete	2005-12-05 00:00:00	2006-12-31 00:00:00	Experimental satellite for data transmission, remote sensing, and spacecraft management.	Sun-synchronous			98 deg	700 km			
471	BelKA	\N	Mission complete	2006-01-01 00:00:00	2006-01-01 00:00:00	Regular imaging of terrestrial sites in visible and near IR ranges with high spatial resolution. Failed on launch.	Sun-synchronous			97.4 deg	505 km			
654	3D Winds	Three Dimensional Tropospheric Winds from Space Based Lidar	Considered	2030-01-01 00:00:00	2033-01-01 00:00:00	Phase-3 DS Mission, launch order unknown, 3-year nominal mission. Tropospheric winds for weather forecasting and pollution transport.	Sun-synchronous		Ascending	97.03 deg	400 km		6:00	12 days
670	AWiFSSAT	Advance Wide Field Sensor Satellite	N/A	2012-01-01 00:00:00	2016-01-01 00:00:00	Natural resources management; agricultural applications; forestry etc.	Sun-synchronous	102 minutes	Descending	98.72 deg	817 km			4 days
768	BIOMASS	BIOMASS	Planned	2021-01-01 00:00:00	2026-01-01 00:00:00	Will provide global maps of forest biomass and height (at 200 m resolution) and forest disturbance (at 50 m resolution) every 6 months	Sun-synchronous	102.6 minutes	Ascending	97.97 deg	660 km		06:00	
560	BILSAT	BILSAT Research Satellite	Mission complete	2003-09-01 00:00:00	2006-08-01 00:00:00	Cartography, land cover/land use, city planning, disaster mitigation/monitoring, environmental monitoring.	Sun-synchronous	98.45 minutes		98.15 deg	686 km		10:30	4 days
390	BIRD	Bi-spectral Infrared Detection	Mission complete	2001-10-22 00:00:00	2005-12-31 00:00:00	Small satellite mission with technical and scientific objectives (Study of thermal processes on the Earth surface) objectives.	Sun-synchronous		Descending	97.8 deg	572 km		10:30	
622	ATHENA FIDUS	Access on THeaters and European Nations for Allied forces opportunities - French Italian Dual Use Satellite	Cancelled	2012-07-15 00:00:00	2027-07-15 00:00:00	Broadband communication satellite for institutinal services and applications.	Geostationary	1440 minutes	N/A	0 deg	35790 km	25 deg		
207	Aura	Aura (formerly EOS Chemistry)	Currently being flown	2004-07-15 00:00:00	2017-09-01 00:00:00	5-year nominal mission life, currently in extended operations. Chemistry and dynamics of Earth’s atmosphere from the ground through the stratosphere.	Sun-synchronous	98.8 minutes	Ascending	98.2 deg	705 km		13:38	16 days
751	Arctic-M N2	Hydro-meteorological Satellite Arctic-M N2	Planned	2019-01-01 00:00:00	2023-01-01 00:00:00	Meteorology, oceanography, including ice cover monitoring, enviromental climate and disaster monitoring in the Arctic region.	Highly elliptical	720 minutes	Ascending	63 deg				1 days
691	Arkon-2M	Arkon-2M	Cancelled	2015-12-31 00:00:00	2020-12-31 00:00:00	Earth observations and weather information.	Sun-synchronous				500 km			
812	Arctic-M N3	Hydro-meteorological Satellite Arctic-M N3	Planned	2020-01-01 00:00:00	2024-01-01 00:00:00	Meteorology, oceanography, including ice cover monitoring, enviromental climate and disaster monitoring in the Arctic region.	Highly elliptical	720 minutes	Ascending	63 deg				1 days
645	ASCENDS	Active Sensing of CO2 Emissions over Nights, Days, and Seasons	Considered	2022-01-01 00:00:00	2025-01-01 00:00:00	Phase-2 DS Mission, launch order unknown, 3-year nominal mission. Day/night, all-latitude, all-season CO2 column integrals for climate emissions.	Sun-synchronous	97.3 minutes	Ascending		450 km		10:30	
713	Arctic-M N1	Hydro-meteorological Satellite Arctic-M N1	Planned	2017-01-01 00:00:00	2021-01-01 00:00:00	Meteorology, oceanography, including ice cover monitoring, enviromental climate and disaster monitoring in the Arctic region.	Highly elliptical	720 minutes	Ascending	63 deg				1 days
206	Aqua	Aqua (formerly EOS PM-1)	Currently being flown	2002-05-04 00:00:00	2017-09-01 00:00:00	6-year nominal mission life, currently in extended operations. Atmosphericdynamics/water and energy cycles, cloudformation, precipitationand radiativeproperties, air/seafluxes of energy andmoisture, sea ice extentand heat exchange with the atmosphere.	Sun-synchronous	98.8 minutes	Ascending	98.2 deg	705 km		13:30	16 days
821	ZY-3-02	Zi Yuan 3 Number 2	Currently being flown	2016-05-30 00:00:00	2021-05-01 00:00:00	Earth resources,  land surface,stereo mapping	Sun-synchronous	94.7 minutes	Descending	97.4 deg	505 km		10:30	59 days
717	YOUTHSAT	Youthsat	Mission complete	2011-04-20 00:00:00	2013-04-19 00:00:00	Airglow of Earth's atmosphere (ionosphere), mapping total electron content in ionosphere.	Sun-synchronous	101.35 minutes	Descending	98.731 deg	817 km			24 days
732	ZY-3-01	Zi Yuan 3 Number 1	Currently being flown	2012-01-09 00:00:00	2017-06-01 00:00:00	Earth resources,  land surface,stereo mapping	Sun-synchronous	97.7 minutes	Descending	98.5 deg	505 km		10:30	59 days
731	ZY-1-02C	Zi Yuan 1 Number 2 Optical Mission of China	Currently being flown	2011-12-22 00:00:00	2016-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	100.3 minutes	Descending	98.5 deg	778 km		10:30	26 days
472	Vulkan-Kompas-2	Vulkan-Kompas-2	Mission complete	2005-01-01 00:00:00	2006-12-31 00:00:00	Monitoring of Earth's seismic activity for earthquake and volcanic eruption forecasting.	Inclined, non-sun-synchronous			79 deg	500 km			
750	VNREDSat 1b	VNREDSat 1b	Cancelled	2017-07-01 00:00:00	2020-07-01 00:00:00									
749	VNREDSat-1	VNREDSat-1	Currently being flown	2013-05-07 00:00:00	2018-07-01 00:00:00	Land cover mapping	Sun-synchronous				680 km		Dec 30 1899 10:30AM	
601	VENUS	Vegetation and Environment monitoring on a New Micro-Satellite	Approved	2017-10-01 00:00:00	2020-12-01 00:00:00	Vegetation, agriculture monitoring, water management.	Sun-synchronous		Descending	98.27 deg	720 km			2 days
402	VISIR	\N	Cancelled	2006-01-01 00:00:00	1900-01-01 00:00:00	Ocean colour, Sea surface Temperature, columnar contenent of Atmospheric aerosol particles bio-geo-chemical fluxes through vegetation, air sea fluxes of energy, hydrological analysis.	Sun-synchronous		TBD					
767	TSIS-1-on-ISS	International Space Station/Total Solar and Spectral Irradiance Sensor Mission	Approved	2018-02-01 00:00:00	2023-05-01 00:00:00		Inclined, non-sun-synchronous	93 minutes	Ascending	51.6 deg	407 km			
426	UK-DMC	UK Disaster Monitoring Constellation	Mission complete	2003-09-27 00:00:00	2011-10-04 00:00:00	Wide area, medium resolution optical imaging for mapping, crop monitoring, environmental resource and disaster management.	Sun-synchronous	98.4 minutes	Ascending	98.2 deg	686 km		9:00	5 days
213	UARS	Upper Atmosphere Research Satellite	Mission complete	1991-09-15 00:00:00	2005-12-14 00:00:00	Atmospheric chemistry (middle to upper atmosphere), atmospheric dynamics/water and energy cycles. HALOE, HRDI, MLS, PEM instruments still functioning. End date TBD.	Inclined, non-sun-synchronous	95.9 minutes	N/A	57 deg	585 km			
599	TSX-NG	TerraSAR Next Generation	Cancelled	2018-12-31 00:00:00	2025-12-31 00:00:00	Commercial follow-on mission to TerraSAR-X operated by Infoterra. Cartography, land surface, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	94.85 minutes	Ascending	97.4 deg	514 km		18:00	
582	UK-DMC2	UK Disaster Monitoring Constellation 2	Currently being flown	2009-07-29 00:00:00	2017-07-01 00:00:00	Wide area, medium resolution optical imaging for mapping, crop monitoring, environmental resource and disaster management.	Sun-synchronous	98.5 minutes	Ascending	98.14 deg	660 km		09:55	5 days
45	SSR-1	Remote Sensing Satellite 1	Mission complete	2007-12-01 00:00:00	2011-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Inclined, non-sun-synchronous	103.2 minutes	N/A	0 deg	905 km			
816	TROPICS	Time-Resolved Observations of Precipitation structure and storm Intensity with a Constellation of Smallsats (TROPICS)	Approved	2020-03-01 00:00:00	2021-03-01 00:00:00	Use a constellation of advanced cubesat passive microwave radiometers providing average revisit time of 30 minutes to improve the understanding and prediction of the impact of environmental temperature and humidity, precipitation evolution, including diurnal cycle, and warm-core strength on the evolution of tropical cyclone structure, size, and intensity.	Inclined, non-sun-synchronous		TBD	30 deg	550 km		TBD	
215	TRMM	Tropical Rainfall Measuring Mission	Mission complete	1997-11-27 00:00:00	2015-04-08 00:00:00	3-year nominal mission life, currently in extended operations. NASA has ceased station keeping maneuvers and TRMM has begun its drift downward from its operating altitude of 402 km. Atmospheric dynamics/water and energy cycles.	Inclined, non-sun-synchronous	93.5 minutes	N/A	35 deg	405 km		N/A	
837	TSIS-2	TSIS-2	Considered	\N	\N									
404	TopSat	Optical Imaging Satellite	Mission complete	2005-10-27 00:00:00	2010-12-31 00:00:00	Prototype low-cost high-resolution imager.	Sun-synchronous		Ascending	98 deg	600 km		10:30	
514	TIROS M (ITOS-1)	TIROS M (ITOS-1)	Mission complete	1978-10-13 00:00:00	1981-02-27 00:00:00		Sun-synchronous	98.92 minutes	N/A	102.3 deg	849 km			
355	TIROS N	\N	Mission complete	1978-10-13 00:00:00	1981-02-27 00:00:00		Sun-synchronous	98.92 minutes	N/A	102.3 deg	849 km			
217	TOMS-EP	Total Ozone Mapping Spectometer Earth Probe	Mission complete	1996-07-02 00:00:00	2006-01-18 00:00:00	Atmospheric Chemistry, Ozone and sulphur dioxide measurements. End date 31/05/2005.	Sun-synchronous	99.6 minutes	Ascending	98.385 deg	512 km		11:10	
210	Topex-Poseidon	Topographic Experiment/Poseidon	Mission complete	1992-08-10 00:00:00	2006-01-18 00:00:00	Physical oceanography, geodesy/gravity.	Inclined, non-sun-synchronous	112.4 minutes	N/A	66 deg	1336 km			10 days
462	TIMED	Thermosphere Ionosphere Mesosphere Energetics and Dynamics mission	N/A	2001-12-07 00:00:00	2010-12-07 00:00:00	Investigates the influences of the sun and humans on the least explored and understood region of the Earth's atmosphere - the mesosphere and lower thermosphere/ionosphere (MLTI).	Inclined, non-sun-synchronous			74.1 deg	625 km			
475	THEOS	Thailand Earth Observation System	Currently being flown	2008-10-01 00:00:00	2016-12-01 00:00:00	Earth resources, land surface and disaster monitoring, civil planning.	Sun-synchronous	101 minutes	Descending	98.7 deg	822 km		10:00	26 days
427	TerraSAR-L	TerraSAR L band	Cancelled	2006-01-01 00:00:00	2011-01-01 00:00:00	SAR imagery in support of agriculture, forestry etc.	TBD		TBD		660 km			
569	TES-HYS	Technology Experimental Satellite on Hyperspectral	N/A	2013-01-01 00:00:00	2014-01-01 00:00:00	For demonstrating many satellite technologies for future Hyperspectral satellites.	Sun-synchronous		TBD					
435	TES	Technology Experimental Satellite on Cartography	Mission complete	2001-10-22 00:00:00	2012-05-31 00:00:00	For demonstrating many satellite technologies for future Cartosat satellites.	Sun-synchronous	96 minutes	Descending	97.8 deg	572 km		10:30	
391	TerraSAR-X	TerraSAR-X	Currently being flown	2007-06-15 00:00:00	2020-12-01 00:00:00	Cartography, land surface, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	94.85 minutes	Ascending	97.4 deg	514 km		18:00	11 days
739	TEMPO	Tropospheric Emissions: Monitoring of Pollution	Approved	2021-12-01 00:00:00	2023-12-01 00:00:00	Hourly measurements of air pollution over North America, from Mexico City to the Canadian oil sands, at high spatial resolution. Measurements in ultraviolet and visible wavelengths will provide a suite of products including the key elements of tropospheric air pollution chemistry. Uses a commercial geostationary host spacecraft. Will be part of the first global geostationary constellation for pollution monitoring, along with European and Korean missions now in development.	Geostationary	1436 minutes	N/A		35786 km			
204	Terra	Terra (formerly EOS AM-1)	Currently being flown	1999-12-18 00:00:00	2017-09-01 00:00:00	6-year nominal mission life, currently in extended operations. Atmospheric dynamics/water and energy cycles, atmospheric chemistry, physical and radiative properties of clouds, air-land exchanges of energy, carbon and water, vertical profiles of CO and methane vulcanology.	Sun-synchronous	99 minutes	Descending	98.2 deg	705 km		10:30	16 days
734	TCTE	Total Solar Irradiance (TSI) Calibration Transfer	Currently being flown	2013-11-19 00:00:00	2017-12-01 00:00:00	Hosted on USAF STPSat-3 spacecraft								
835	TanDEM-L	TanDEM-L	Planned	2022-01-01 00:00:00	2034-01-01 00:00:00	Global observation of dynamic processes in the bio-, cryo-, geo- and hydrosphere.	Sun-synchronous	99.7 minutes	Ascending	98.4 deg	745 km		18:00	16 days
646	SWOT	Surface Water Ocean Topography	Approved	2021-04-01 00:00:00	2024-07-01 00:00:00	3.5-year nominal mission. Characterize ocean mesoscale and sub-mesoscale circulation at spatial resolutions = 15 km and inventory all terrestrial water bodies with surface area > 250 m2 and rivers with width > 100 m	Inclined, non-sun-synchronous			78 deg	891 km			21 days
598	TanDEM-X	TerraSAR-X Add-on for Digital Elevation Measurements	Currently being flown	2010-06-21 00:00:00	2020-12-01 00:00:00	Cartography, land surface, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	94.85 minutes	Ascending	97.4 deg	514 km		18:00	11 days
468	Swarm	Earth's Magnetic Field and Environment Explorers	Currently being flown	2013-11-22 00:00:00	2017-11-01 00:00:00	A three-satellite constellation that is providing the best ever survey of the geomagnetic field and its temporal evolution to gain new insights into improving our knowledge of the Earth’s interior and climate. Canada contributes the electric field instrument that is required to correctly separate the measured magnetic field into its different sources.	Inclined, non-sun-synchronous		N/A	87.5 deg	450 km			
559	SumbandilaSat	Sumbandila Satellite	Mission complete	2009-09-18 00:00:00	2012-01-24 00:00:00	Primary payload (imager) will be used to support decision making in natural resource management, disaster management, agriculture, urban planning and other applications.	Sun-synchronous	94.6846 minutes		97.2792 deg	500 km		12:00	
783	STSAT-3	Science & Technology SATellite-3	Currently being flown	2013-11-22 00:00:00	2017-11-01 00:00:00	Galactic Plane Survey, Cosmic Background Radiation Measurement, Land use	Sun-synchronous		Ascending		600 km			
488	SUNSAT	\N	Mission complete	1999-02-23 00:00:00	2001-01-19 00:00:00		Geostationary		TBD					
413	Suomi NPP	Suomi National Polar-orbiting Partnership	Currently being flown	2011-10-28 00:00:00	2020-09-01 00:00:00	5-year nominal mission life. Operational polar weather and climate measurements.	Sun-synchronous	101 minutes	Ascending	98.7 deg	824 km		13:30	16 days
249	SPOT-3	Satellite Pour l'Observation de la Terre - 3	Mission complete	1993-09-25 00:00:00	1996-11-14 00:00:00	Cartography, land surface, agriculture and forestry, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	101 minutes	Descending	98.7 deg	832 km		10:30	26 days
255	STELLA	\N	Currently being flown	1993-09-30 00:00:00	2050-12-01 00:00:00	Geodesy/gravity study of the Earth’s gravitational field and its temporal variations.	Inclined, non-sun-synchronous	101 minutes	N/A	98 deg	830 km			
46	SSR-2	Remote Sensing Satellite 2	N/A	2012-12-01 00:00:00	2015-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Inclined, non-sun-synchronous	103 minutes	TBD	0 deg	905 km			16 days
424	STARLETTE	\N	Currently being flown	1975-02-06 00:00:00	2050-12-01 00:00:00	Geodesy/gravity study of the Earth’s gravitational field and its temporal variations.	Inclined, non-sun-synchronous	104 minutes	N/A	49.83 deg	812 km			
253	SPOT-5	Satellite Pour l'Observation de la Terre - 5	Mission complete	2002-05-04 00:00:00	2015-03-30 00:00:00	Cartography, land surface, agriculture and forestry, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	101 minutes	Descending	98.7 deg	832 km		10:30	26 days
251	SPOT-4	Satellite Pour l'Observation de la Terre - 4	Mission complete	1998-03-24 00:00:00	2013-06-29 00:00:00	Cartography, land surface, agriculture and forestry, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	101 minutes	Descending	98.7 deg	832 km		10:30	26 days
285	SPOT-2	Satellite Pour l'Observation de la Terre - 2	Mission complete	1990-01-22 00:00:00	2009-06-30 00:00:00	Cartography, land surface, agriculture and forestry, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	101 minutes	Descending	98.7 deg	832 km		10:30	26 days
247	SPOT-1	Satellite Pour l'Observation de la Terre - 1	Mission complete	1986-02-22 00:00:00	2001-12-31 00:00:00	Cartography, land surface, agriculture and forestry, civil planning and mapping, digital terrain models, environmental monitoring.	Sun-synchronous	101 minutes	Descending	98.7 deg	832 km		10:30	26 days
614	SMAP	Soil Moisture Active Passive	Currently being flown	2015-01-31 00:00:00	2018-06-01 00:00:00	3-year nominal mission life. Global soil moisture and freeze-thaw state mapping.	Sun-synchronous	98.46 minutes	Ascending	98.12 deg	685 km		18:00	
379	SMOS	Soil Moisture and Ocean Salinity (Earth Explorer Opportunity Mission)	Currently being flown	2009-11-02 00:00:00	2017-02-01 00:00:00	Overall objectives are to provide global observations of two crucial variables for modelling the weather and climate, soil moisture and ocean salinity. It will also monitor the vegetation water content, snow cover and ice structure.	Sun-synchronous	100.075 minutes	Ascending	98.44 deg	758 km		6:00	23 days
318	Sich-1M	\N	Mission complete	2004-12-24 00:00:00	2006-04-15 00:00:00	Physical Oceanography, Hydrometeorology, Land Observation.	Inclined, non-sun-synchronous	98 minutes	TBD	82.5 deg	650 km			
743	SJ-9B	Shijian 9B	Currently being flown	2012-10-14 00:00:00	2016-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	97.5 minutes	Descending	97.982 deg	645 km		10:30	69 days
346	SORCE	Solar Radiation and Climate Experiment	Currently being flown	2003-01-25 00:00:00	2019-10-01 00:00:00	5-year nominal mission life, currently in extended operations. Continues the precise, long-term measurements of total solar irradiance at UV and VNIR wavelengths. Daily measurements of solar UV. Precise measurements of visible solar irradiance for climate studies.	Inclined, non-sun-synchronous	90 minutes		40 deg	600 km			
742	SJ-9A	Shijian 9A	Currently being flown	2012-10-14 00:00:00	2016-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	97.5 minutes	Descending	97.982 deg	645 km		10:30	69 days
123	Sich-2	\N	Mission complete	2011-08-17 00:00:00	2012-12-12 00:00:00	Land observation.	Sun-synchronous	98 minutes	Descending	98 deg	668 km		10:50	5 days
121	Sich-1	\N	Mission complete	1995-08-31 00:00:00	2001-12-14 00:00:00	Physical oceanography, hydrometeorology.	Inclined, non-sun-synchronous	98 minutes	TBD	82.5 deg	650 km			
639	Sentinel-4 A	Sentinel-4 A	Planned	2022-01-01 00:00:00	2030-01-01 00:00:00	Supporting European atmospheric composition and air quality monitoring services. The Sentinel-4 A mission is carried on MTG S1.	Geostationary		N/A			0 deg		
770	Sentinel-6 B	Sentinel-6 B	Planned	2025-01-01 00:00:00	2032-01-01 00:00:00	To provide continuity of the reference, high-precision ocean topography service after Jason-3	Inclined, non-sun-synchronous	112.4 minutes	N/A	66.05 deg	1342 km			
769	Sentinel-6 A	Sentinel-6 A	Planned	2020-01-01 00:00:00	2025-01-01 00:00:00	To provide continuity of the reference, high-precision ocean topography service after Jason-3	Inclined, non-sun-synchronous	112.4 minutes	N/A	66.05 deg	1342 km			
581	Sentinel-5 precursor	Sentinel-5 precursor	Approved	2016-11-01 00:00:00	2023-11-01 00:00:00	Supporting global atmospheric composition and air quality monitoring services.	Sun-synchronous	17 minutes	Ascending	98.742 deg	824 km		13:30	
641	Sentinel-5 A	Sentinel-5 A	Planned	2021-01-01 00:00:00	2028-01-01 00:00:00	In early stages of mission definition.  Other payloads will be added. The Sentinel-5 mission is carried on EPS-SG-a.	Sun-synchronous		N/A					
640	Sentinel-4 B	Sentinel-4 B	Planned	2030-01-01 00:00:00	2039-01-01 00:00:00	Supporting European atmospheric composition and air quality monitoring services. The Sentinel-4 B mission is carried on MTG S2.	Geostationary		N/A			0 deg		
777	Sentinel-5 B	Sentinel-5 B	Planned	2022-01-01 00:00:00	2030-01-01 00:00:00									
578	Sentinel-2 C	Sentinel-2 C	Approved	2021-06-01 00:00:00	2029-05-01 00:00:00	Supporting land monitoring related services, including: generation of generic land cover maps, risk mapping and fast images for disaster relief, generation of leaf coverage, leaf chlorophyll content and leaf water content.	Sun-synchronous	100.7 minutes	Descending	98.62 deg	786 km		10:30	10 days
814	Sentinel-1 D	Sentinel-1 D	Approved	2023-07-01 00:00:00	2030-06-01 00:00:00	Providing continuity of C-band SAR data for operational applications notably in the following areas: monitoring of sea ice zones and the arctic environment, surveillance of marine environment, monitoring of land surface motion risks and mapping in support of humanitarian aid in crisis situations.	Sun-synchronous	98.74 minutes	Ascending	98.19 deg	693 km		18:00	12 days
579	Sentinel-3 C	Sentinel-3 C	Approved	2023-06-01 00:00:00	2029-01-01 00:00:00	Supporting global land and ocean monitoring services, in particular: sea/land colour data and surface temperature; sea surface and land ice topography; coastal zones, inland water and sea ice topography; vegetation products.	Sun-synchronous	101 minutes	Ascending	98.65 deg	807 km		10:00	27 days
555	Sentinel-3 B	Sentinel-3 B	Approved	2018-02-01 00:00:00	2025-09-01 00:00:00	Supporting global land and ocean monitoring services, in particular: sea/land colour data and surface temperature; sea surface and land ice topography; coastal zones, inland water and sea ice topography; vegetation products.	Sun-synchronous	101 minutes	Ascending	98.65 deg	807 km		10:00	27 days
553	Sentinel-2 B	Sentinel-2 B	Approved	2017-05-01 00:00:00	2024-03-01 00:00:00	Supporting land monitoring related services, including: generation of generic land cover maps, risk mapping and fast images for disaster relief, generation of leaf coverage leaf chlorophyll content and leaf water content.	Sun-synchronous	100.7 minutes	Descending	98.62 deg	786 km		10:30	10 days
552	Sentinel-2 A	Sentinel-2 A	Currently being flown	2015-06-22 00:00:00	2022-05-01 00:00:00	Supporting land monitoring related services, including: generation of generic land cover maps, risk mapping and fast images for disaster relief, generation of leaf coverage leaf chlorophyll content and leaf water content.	Sun-synchronous	100.7 minutes	Descending	98.62 deg	786 km		10:30	10 days
554	Sentinel-3 A	Sentinel-3 A	Currently being flown	2016-02-16 00:00:00	2023-01-01 00:00:00	Supporting global land and ocean monitoring services, in particular: sea/land colour data and surface temperature; sea surface and land ice topography; coastal zones, inland water and sea ice topography; vegetation products.	Sun-synchronous	101 minutes	Ascending	98.65 deg	807 km		10:00	27 days
577	Sentinel-1 C	Sentinel-1 C	Approved	2021-02-01 00:00:00	2028-06-01 00:00:00	Providing continuity of C-band SAR data for operational applications notably in the following areas: monitoring of sea ice zones and the arctic environment, surveillance of marine environment, monitoring of land surface motion risks and mapping in support of humanitarian aid in crisis situations.	Sun-synchronous	98.74 minutes	Ascending	98.19 deg	693 km		18:00	12 days
576	Sentinel-1 B	Sentinel-1 B	Currently being flown	2016-04-25 00:00:00	2023-04-01 00:00:00	Providing continuity of C-band SAR data for operational applications notably in the following areas: monitoring of sea ice zones and the arctic environment, surveillance of marine environment, monitoring of land surface motion risks and mapping in support of humanitarian aid in crisis situations.	Sun-synchronous	98.74 minutes	Ascending	98.19 deg	693 km		18:00	12 days
803	SeaSat	Seafaring Satellite	Mission complete	1978-06-26 00:00:00	1978-10-08 00:00:00									
575	Sentinel-1 A	Sentinel-1 A	Currently being flown	2014-04-03 00:00:00	2021-01-01 00:00:00	Providing continuity of C-band SAR data for operational applications notably in the following areas: monitoring of sea ice zones and the arctic environment, surveillance of marine environment, monitoring of land surface motion risks and mapping in support of humanitarian aid in crisis situations.	Sun-synchronous	98.74 minutes	Ascending	98.19 deg	693 km		18:00	12 days
394	SCISAT-1	SCISAT-I/ACE	Currently being flown	2003-08-12 00:00:00	2018-03-01 00:00:00	The SCISAT satellite has been in continuous spaceflight operation since 2003. It now measures over sixty (60) atmospheric species at still one of the world’s highest vertical resolutions possible, and includes ozone, methane, and multiple CFCs. Many of these species are measured by no other instrument or satellite world-wide, making Canada the sole provider of these datasets globally. As of 2015, the objectives of the mission are to validate data used in: Environment Canada’s Air Quality Health Index, retrieve winds for forecasting, and retrieve chemical information from operational meteorological instruments. Additional objectives are to assess the quality of model predictions for: EC’s UV forecasting system, atmospheric carbon transport, and climate-chemistry process studies.	Inclined, non-sun-synchronous	97.7 minutes	N/A	74 deg	650 km			365 days
44	SCD-2	Data Collecting Satellite 2	Currently being flown	1998-10-22 00:00:00	2016-12-01 00:00:00	Data collection and communication.	Inclined, non-sun-synchronous	100 minutes	Ascending	25 deg	750 km			
43	SCD-1	Data Collecting Satellite 1	Currently being flown	1993-02-09 00:00:00	2016-12-01 00:00:00	Data collection and communication.	Inclined, non-sun-synchronous	100 minutes	Ascending	25 deg	750 km			
652	SCLP	Snow and Cold Land Processes	Considered	2030-01-01 00:00:00	2033-01-01 00:00:00	Phase-3 DS Mission, launch order unknown, 3-year nominal mission. Snow accumulation for fresh water availability.	Sun-synchronous							15 days
119	SCD-3	Data Collecting Satellite 3	Cancelled	2006-12-01 00:00:00	2010-12-01 00:00:00	Data collection and communication.	Inclined, non-sun-synchronous	107 minutes	TBD		1100 km			
671	Scatsat-1	Scatterometer Satellite-1	Cancelled	2018-01-01 00:00:00	2022-01-01 00:00:00	Ocean and atmosphere applications, wind speed over oceans, temperature.	Sun-synchronous							
764	SCATSAT-1	SCATSAT-1	Currently being flown	2016-09-26 00:00:00	2021-08-01 00:00:00	Observe the sea roughness, wind velocity vector	Sun-synchronous		Descending				12:00	
596	SARE-2A (S1)	\N	Planned	2020-01-01 00:00:00	2025-01-01 00:00:00	Earth observation with high spatial resolution, emergencies, agriculture, land use/land cover, change detection, urban environment, cartography, stereo acquisitions for DEM generation.	Sun-synchronous	95.6 minutes	Descending	97.6 deg	550 km		10:30	
572	SARAL	Satellite with ARgos and ALtiKa	Currently being flown	2012-02-25 00:00:00	2018-12-01 00:00:00	This will provide precise, repetitive global measurements of sea surface height, significant wave heights and wind speed.	Sun-synchronous	100.59 minutes	Descending	98.55 deg	799 km		18:00	35 days
808	SARE-2A (S3)	\N	Planned	2020-01-01 00:00:00	2025-01-01 00:00:00	Earth observation with high spatial resolution, emergencies, agriculture, land use/land cover, change detection, urban environment, cartography, stereo acquisitions for DEM generation.	Sun-synchronous	95.6 minutes	Descending	97.6 deg	550 km		10:30	
807	SARE-2A (S2)	\N	Planned	2020-01-01 00:00:00	2025-01-01 00:00:00	Earth observation with high spatial resolution, emergencies, agriculture, land use/land cover, change detection, urban environment, cartography, stereo acquisitions for DEM generation.	Sun-synchronous	95.6 minutes	Descending	97.6 deg	550 km		10:30	
809	SARE-2A (S4)	\N	Planned	2020-01-01 00:00:00	2025-01-01 00:00:00	Earth observation with high spatial resolution, emergencies, agriculture, land use/land cover, change detection, urban environment, cartography, stereo acquisitions for DEM generation.	Sun-synchronous	95.6 minutes	Descending	97.6 deg	550 km		10:30	
456	SAOCOM-2B	Satélite Argentino de Observación COn Microondas 2B	Approved	2022-01-01 00:00:00	2027-01-01 00:00:00	Earth observation and emergency management with an L-band SAR.	Sun-synchronous		Descending	98 deg	620 km		6:00	16 days
457	SAOCOM-2A	Satélite Argentino de Observación COn Microondas 2A	Approved	2021-01-01 00:00:00	2025-01-01 00:00:00	Earth observation and emergency management with an L-band SAR.	Sun-synchronous		Descending	98 deg	620 km		6:00	16 days
715	SAC-E/SABIA_MAR-A	Misión Satelital Argentina Brasileña para Información del Ambiente Marino	Planned	2020-01-01 00:00:00	2025-01-01 00:00:00	Ocean colour measurement (open ocean, coastal and in-land waters) (low & medium spatial resolution), SST, Sea & Coastal surveillance, urban lights, polar auroras, fires, data collection system.	Sun-synchronous	99.8 minutes	Descending	98.22 deg	702 km		10:20	9 days
452	SAOCOM 1B	Satélite Argentino de Observación COn Microondas 1B	Approved	2018-10-01 00:00:00	2023-10-01 00:00:00	'Earth observation and emergency management with an L-band SAR, soil moisture for agriculture and hydrology (main driver), interferometry.	Sun-synchronous	97.2 minutes	Ascending	97.89 deg	620 km		6:12	16 days
716	SAC-E/SABIA_MAR-B	Misión Satelital Argentina Brasileña para Información del Ambiente Marino	Planned	2019-01-01 00:00:00	2027-01-01 00:00:00	Ocean colour measurement (open ocean, coastal and in-land waters) (low & medium spatial resolution), SST, Sea & Coastal surveillance, urban lights, polar auroras, fires, data collection system.	Sun-synchronous	99.8 minutes	Descending	98.22 deg	702 km		10:20	9 days
356	SAGE/AEM-2	Stratospheric Aerosol and Gas Experiment Applications Explorer Mission 2	Mission complete	1979-02-18 00:00:00	1981-11-19 00:00:00		Sun-synchronous		N/A					
135	Resurs-01 N2	Resource satellite first series number 2	Mission complete	1988-01-01 00:00:00	1994-01-01 00:00:00	Agriculture and forestry, hydrology, environmental monitoring, hydrometeorology, ice and snow, land surface, meteorology.	Sun-synchronous		TBD		670 km			
687	SAGE-III-on-ISS	ISS/Stratospheric Aerosol and Gas Experiment	Approved	2017-01-01 00:00:00	2021-01-01 00:00:00	1-year design life, 3 year goal. efurbishment of the SAGE-III instrument and of a hexapod pointing platform, and accommodation studies. This mission flies on the ISS.  Objective is to monitor the vertical distribution of aerosols, ozone, and other trace gases in the Earth’s stratosphere and troposphere to enhance our understanding of ozone recovery and climate change processes in the upper atmosphere.	Inclined, non-sun-synchronous	90 minutes		51 deg	425 km			
405	SAOCOM 1A	Satélite Argentino de Observación COn Microondas 1A	Approved	2017-10-01 00:00:00	2022-10-01 00:00:00	Earth observation and emergency management with an L-band SAR, soil moisture for agriculture and hydrology (main driver), interferometry.	Sun-synchronous	97.2 minutes	Ascending	97.89 deg	620 km		6:12	16 days
453	SAC-D/Aquarius	SAC-D/Aquarius	Mission complete	2011-06-10 00:00:00	2015-06-08 00:00:00	Earth observation studies; measurement of ocean surface salinity; atmospheric and environmental parameters.	Sun-synchronous	98 minutes	Ascending	98 deg	657 km		18:00	7 days
344	SAC-C	\N	Mission complete	2000-11-21 00:00:00	2013-08-13 00:00:00	Earth observation, studies the structure and dynamics of the Earth’s surface, atmosphere, ionosphere and geomagnetic field.	Sun-synchronous	98 minutes	Descending	98.2 deg	705 km		10:25	9 days
343	SAC-A	\N	Mission complete	1998-12-01 00:00:00	1999-08-01 00:00:00	Technological mission.	Inclined, non-sun-synchronous		TBD	51.6 deg	389 km			
397	SABRINA	SAr Bissat Radar for INterferometric Applications	Cancelled	2012-04-20 00:00:00	2016-09-08 00:00:00	Resarch and testing on interferometric and bistatics techniques.	Sun-synchronous	97.15 minutes	Ascending	97.8 deg	622 km		6:00	16 days
454	SABIA-Mar	SABIA-Mar	Cancelled	2017-01-01 00:00:00	2021-01-01 00:00:00	Ocean Observation, Marine Services, Environmental Monitoring .	Sun-synchronous		Descending					
674	RISAT-2F	Radar Imaging Satellite	N/A	2013-01-01 00:00:00	2017-01-01 00:00:00	For research and disaster management applications purpose.	Sun-synchronous	90 minutes	Descending		550 km		6:00	
636	RISAT-2	Radar Imaging Satellite	Currently being flown	2009-04-20 00:00:00	2017-04-01 00:00:00	For research and disaster management applications purpose.	Sun-synchronous	97.6 minutes	Ascending	96 deg	609 km		6:00	
712	RISAT-1A	Radar Imaging Satellite	Approved	2018-09-01 00:00:00	2023-09-01 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils - especially during cloud season.	Sun-synchronous	96.5 minutes	Descending	97.844 deg	610 km		6:00	12 days
673	RISAT-3L	Radar Imaging Satellite	N/A	2014-01-01 00:00:00	2020-01-01 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils - Specially during cloud season.	Sun-synchronous	96.5 minutes	Descending	97.844 deg				12 days
799	Resurs-PM N4	Environmental Satellite Resurs-PM N4	Planned	2024-01-01 00:00:00	2031-01-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg				3 days
797	Resurs-PM N2	Environmental Satellite Resurs-PM N2	Planned	2021-01-01 00:00:00	2028-01-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg				3 days
441	RISAT-1	Radar Imaging Satellite	Currently being flown	2012-04-26 00:00:00	2017-04-01 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils - especially during cloud season.	Sun-synchronous	96.5 minutes	Descending	97.844 deg	610 km		6:00	12 days
796	Resurs-PM N1	Environmental Satellite Resurs-PM N1	Planned	2020-01-01 00:00:00	2027-01-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg				3 days
798	Resurs-PM N3	Environmental Satellite Resurs-PM N3	Planned	2023-01-01 00:00:00	2030-01-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg				3 days
789	Resurs-P N5	Environmental Satellite Resurs-P N5	Planned	2019-01-01 00:00:00	2024-01-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg	475 km			3 days
788	Resurs-P N4	Environmental Satellite Resurs-P N4	Planned	2018-01-01 00:00:00	2023-01-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg	475 km			3 days
760	Resurs-P N3	Environmental Satellite Resurs-P N3	Currently being flown	2016-03-13 00:00:00	2021-08-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		TBD	97.3 deg	475 km			3 days
626	Resurs-P N2	Environmental Satellite Resurs-P N2	Currently being flown	2014-12-26 00:00:00	2019-03-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		Descending	97 deg	475 km			3 days
140	Resurs-F2M series	Resource satellite F series number 2M	Mission complete	1996-01-01 00:00:00	1996-01-01 00:00:00	Land surface, physical oceanography.	Sun-synchronous		TBD		240 km			
137	Resurs-02	\N	Mission complete	1996-01-01 00:00:00	1998-01-01 00:00:00	Agriculture and forestry, hydrology, environmental monitoring, hydrometeorology, ice and snow, land surface, meteorology.	Sun-synchronous		TBD		670 km			
624	Resurs-P N1	Environmental Satellite Resurs-P N1	Currently being flown	2013-06-25 00:00:00	2018-06-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Sun-synchronous		Descending	97 deg	475 km			3 days
141	Resurs-F3 series	Resource satellite F series number 3	Mission complete	1993-01-01 00:00:00	1998-01-01 00:00:00	Cartography (land and ocean) 1:25000 and below.	Sun-synchronous		TBD		340 km			
139	Resurs-F2 series	Resource satellite F series number 2	Mission complete	1993-01-01 00:00:00	1996-01-01 00:00:00	Land surface, physical oceanography.	Sun-synchronous		TBD		240 km			
443	Resurs-01 N5	Resource satellite first series number 5	N/A	2005-01-01 00:00:00	2008-12-31 00:00:00	Environmental monitoring, agriculture and forestry, hydrology, hydrometeorology, ice and snow, land surface, agriculture, disaster management.	Sun-synchronous		TBD		680 km			
138	Resurs-F1M series	Resource satellite F series number 1M	Mission complete	1995-01-01 00:00:00	1998-01-01 00:00:00	Land surface, physical oceanography, geodesy/gravity.	Sun-synchronous		TBD		285 km			
136	Resurs-01 N3	Resource satellite first series number 3	Mission complete	1994-11-04 00:00:00	1996-01-01 00:00:00	Agriculture and forestry, hydrology, environmental monitoring, hydrometeorology, ice and snow, land surface, meteorology.	Sun-synchronous	98.01 minutes	TBD	97.88 deg	678 km			
153	Resurs-01 N4	Resource satellite first series number 4	Mission complete	1998-07-10 00:00:00	2002-02-07 00:00:00	Environmental monitoring, agriculture and forestry, hydrology, hydrometeorology, ice and snow, land surface, agriculture, disaster management. Currently only providing data from MR-900B instrument.	Sun-synchronous	101 minutes	TBD	98.75 deg	850 km			
817	RESOURCESAT-3A	Resource Satellite-3A	Approved	2019-12-01 00:00:00	2024-12-01 00:00:00	Natural resources management, agricultural applications, forestry, etc.	Sun-synchronous	101 minutes	Descending	98.72 deg	795 km		10:30	11 days
444	Resurs DK 1	Environmental Satellite Resurs-DK N1	Mission complete	2006-06-15 00:00:00	2016-03-01 00:00:00	Earth resources, environmental and disaster monitoring, cartography.	Inclined, non-sun-synchronous	94 minutes	Ascending	70 deg				6 days
819	RESOURCESAT-3SA	Resourcesat Sampler-3SA	Approved	2019-10-01 00:00:00	2024-10-01 00:00:00	High-resolution DEM, geo-engineering, cadastral and sub-taluk-level applications.	Sun-synchronous	97.5 minutes	Descending	97.89 deg	633 km		10:30	48 days
710	RESOURCESAT-2A	Resource Satellite-2A	Approved	2016-11-01 00:00:00	2021-11-01 00:00:00	Natural resources management, agricultural applications, forestry, etc.	Sun-synchronous	102 minutes	Descending	98.72 deg	817 km		10:30	26 days
439	RESOURCESAT-2	Resource Satellite-2	Currently being flown	2011-04-20 00:00:00	2017-04-01 00:00:00	Natural resources management, agricultural applications, forestry, etc.	Sun-synchronous	102 minutes	Descending	98.72 deg	817 km		10:30	26 days
573	RESOURCESAT-3	Resource Satellite-3	Approved	2019-07-01 00:00:00	2024-07-01 00:00:00	Natural resources management, agricultural applications, forestry, etc.	Sun-synchronous	101 minutes	Descending	98.72 deg	795 km		10:30	11 days
818	RESOURCESAT-3S	Resourcesat Sampler-3S	Approved	2019-04-01 00:00:00	2024-04-01 00:00:00	High-resolution DEM, geo-engineering, cadastral and sub-taluk-level applications.	Sun-synchronous	97.5 minutes	Descending	97.89 deg	633 km		10:30	48 days
586	RCM-3	RADARSAT CONSTELLATION-3	Approved	2018-07-01 00:00:00	2025-11-01 00:00:00	Ecosystem monitoring, maritime surveillance, disaster management.	Sun-synchronous	96.4 minutes	Ascending	97.7 deg	600 km		18:00	12 days
401	REFIR	Radiation Explorer in the Far IR	Cancelled	2006-01-01 00:00:00	1900-01-01 00:00:00	Study of radiation processes for climate change, study of water vapour feedback processes and gaseous forcing.	Sun-synchronous		TBD					
276	RESOURCESAT-1	Resource Satellite-1	Mission complete	2003-10-17 00:00:00	2013-12-07 00:00:00	Natural resources management, agricultural applications, forestry, etc.	Sun-synchronous	102 minutes	Descending	98.72 deg	817 km		10:30	26 days
585	RCM-2	RADARSAT CONSTELLATION-2	Approved	2018-07-01 00:00:00	2025-11-01 00:00:00	Ecosystem monitoring, maritime surveillance, disaster management.	Sun-synchronous	96.4 minutes	Ascending	97.7 deg	600 km		18:00	12 days
584	RCM-1	RADARSAT CONSTELLATION-1	Approved	2018-07-01 00:00:00	2025-11-01 00:00:00	Ecosystem monitoring, maritime surveillance, disaster management.	Sun-synchronous	96.4 minutes	Ascending	97.7 deg	600 km		18:00	12 days
561	RASAT	RASAT Remote Sensing Satellite	Currently being flown	2011-08-17 00:00:00	2016-12-01 00:00:00	Cartography, land cover/land use, city planning, disaster mitigation/monitoring, environmental monitoring.	Sun-synchronous	98.8 minutes	Ascending	98.21 deg	685 km		10:30	4 days
782	RapidScat-on-ISS	International Space Station/Rapid Scatterometer	Currently being flown	2014-09-20 00:00:00	2017-09-01 00:00:00	A speedy and cost-effective replacement for NASA's QuikScat Earth satellite, which monitored ocean winds to provide essential measurements used in weather predictions, including hurricane monitoring.	Inclined, non-sun-synchronous	90 minutes		51 deg	425 km			
358	QuikTOMS	Quick Total Ozone Mapping Spectrometer	Mission complete	2001-09-21 00:00:00	2001-09-21 00:00:00	Continues longterm ozone measurements of the TOMS instruments.	Sun-synchronous		Descending	98 deg	800 km		10:30	
469	RapidEye	RapidEye	Currently being flown	2008-08-29 00:00:00	2019-08-01 00:00:00	System of 5 satellites for cartography, land surface, digital terrain models, disaster management, environmental monitoring.	Sun-synchronous	97 minutes	Descending	98.7 deg	622 km		11:00	1 days
243	RADARSAT-1	RADARSAT-1	Mission complete	1995-11-04 00:00:00	2013-03-29 00:00:00	Environmental monitoring, physical oceanography, ice and snow, land surface.	Sun-synchronous	100.7 minutes	Ascending	98.594 deg	798 km		18:00	24 days
339	QuikSCAT	Quick Scatterometer	Currently being flown	1999-06-19 00:00:00	2017-10-01 00:00:00	The 3-year nominal QuikSCAT mission life is complete, and it is currently in extended operations. Due to technical failure (the antenna stopped rotating in November 2009), and the instrument no longer collects ocean wind vector data. However it still provides calibration data for other on-orbit scatterometers, which enables the continuation of a climate-quality wind vector dataset.  Mission is scheduled for desommissioning in 2014, but may be extended for cross-calibration activities with Rapidscat.	Sun-synchronous	101 minutes	Ascending	98.6 deg	803 km		6:00	
352	RADARSAT-2	RADARSAT-2	Currently being flown	2007-12-14 00:00:00	2019-04-01 00:00:00	Environmental monitoring, physical oceanography, ice and snow, land surface. Note: Ownership of RADARSAT-2 has been transferred to MDA Corporation. CSA investment in the project is paid back with the data generated by the satellite since it entered operations.	Sun-synchronous	100.7 minutes	Ascending	98.6 deg	798 km		18:00	24 days
403	PROBA	Project for On-Board Autonomy	Currently being flown	2001-10-22 00:00:00	2016-12-01 00:00:00	PROBA is a technology experiment to demonstrate the on-board autonomy of a generic platform suitable for small scientific or application missions. A number of earth observation instruments are included. CHRIS - a hyperspectral imager provides data related to Earth Resources science and applications.	Sun-synchronous	96.97 minutes	Descending	97.9 deg	615 km		10:30	7 days
396	PRISMA	PRecursore IperSpettrale della Missione Applicativa	Approved	2018-05-01 00:00:00	2023-08-01 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils.	Sun-synchronous	97 minutes	Descending	97.9 deg	615 km		10:30	29 days
737	PROBA-V	PROBA-V	Currently being flown	2013-05-07 00:00:00	2018-05-01 00:00:00	The PROBA-V mission’s main multispectral imager extends the 15-year\n\ndataset of Spot-4 & Spot-5’s Vegetation instrument, delivering global coverage every two days for uses including climate\n\nimpact assessments, surface water resource management, agricultural monitoring, and food\n\nsecurity estimates.	Sun-synchronous		Descending	98.73 deg	820 km		10:30 to 11:30	2 days
597	Post-EPS	Post EUMETSAT Polar System	Cancelled	2018-01-01 00:00:00	2023-01-01 00:00:00	Operational meteorology, climate monitoring, environmental services.	Sun-synchronous	101 minutes	Descending	98.7 deg	817 km		9:30	29 days
479	Pleiades 1B	\N	Currently being flown	2012-12-02 00:00:00	2019-12-01 00:00:00	Cartography, land use, risk, agriculture and forestry, civil planning and mapping, digital terrain models, defence.	Sun-synchronous		Descending		694 km		10:15	
142	PRIRODA	\N	Mission complete	1996-01-01 00:00:00	1999-01-01 00:00:00		Inclined, non-sun-synchronous		TBD		420 km			
478	Pleiades 1A	\N	Currently being flown	2011-12-17 00:00:00	2018-12-01 00:00:00	Cartography, land use, risk, agriculture and forestry, civil planning and mapping, digital terrain models, defence.	Sun-synchronous		Descending		694 km		10:15	26 days
416	PICARD	\N	Mission complete	2010-06-15 00:00:00	2014-04-04 00:00:00	Simultaneous measurements of solar diameter, differential rotation, solar constant, and variability.	TBD	99 minutes	TBD	98 deg	725 km		6:00	
632	PCW-2	Polar Communications and Weather-2	Considered	2021-01-01 00:00:00	2036-01-01 00:00:00	Continuous meteorological observation and communications service to the Arctic.	Highly elliptical	718 minutes	N/A	63.4 deg			N/A	1 days
627	PAZ	PAZ	Approved	2016-12-01 00:00:00	2020-12-01 00:00:00	Security, land use, urban management, environmental monitoring, risk management.	Sun-synchronous	95 minutes	Ascending	97.44 deg	514 km		18:00	11 days
840	METOP-SG B2	EUMETSAT Polar System, Second Generation	Approved	2029-12-01 00:00:00	2037-06-01 00:00:00	Meteorology, climatology. 3 satellites.	Sun-synchronous	101.4 minutes	Descending	98.7 deg	824 km		9:30	29 days
650	PATH	Precipitation and All-weather Temperature and Humidity	Considered	2030-01-01 00:00:00	2033-01-01 00:00:00	Phase-3 DS Mission, launch order unknown, 3-year nominal mission. High frequency, all-weather temperature and humidity soundings for weather forecasting and SST.	Geostationary		N/A		42000 km	0 deg		
415	PARASOL	Polarization and Anisotropy of Reflectances for Atmospheric Science coupled with Observations from a LIDAR	Mission complete	2004-12-18 00:00:00	2013-10-11 00:00:00	Micro-satellite with the aim of characterisation of the clouds and aerosols microphysical and radiative properties, needed to understand and model the radiative impact of clouds and aerosols.	Sun-synchronous	98.8 minutes	TBD	98.2 deg	705 km		13:30	16 days
684	PACE	Plankton, Aerosol, Cloud, ocean Ecosystem	Planned	2022-01-01 00:00:00	2025-01-01 00:00:00	Phase-2 DS Mission, launch order unknown, 3-year nominal mission. Aerosol and cloud profiles for climate and water cycle; ocean colour for open ocean biogeochemistry.	Sun-synchronous		Ascending	98 deg	675 km		12:00	16 days
631	PCW-1	Polar Communications and Weather-1	Considered	2021-01-01 00:00:00	2036-01-01 00:00:00	Continuous meteorological observation and communications service to the Arctic.	Highly elliptical	718 minutes	N/A	63.4 deg			N/A	1 days
744	OPSIS	OPtical System for Imagery and Surveillance	Cancelled	2017-07-01 00:00:00	2022-07-01 00:00:00	Land use, risk, agriculture and forestry, topographic mapping and cartography, vegetation and agriculture, natural resources, security, cultural heritage.	Sun-synchronous	98.6 minutes	Descending	98.2 deg	691 km		10:30	28 days
419	OSTM (Jason-2)	Ocean Surface Topography Mission	Currently being flown	2008-06-20 00:00:00	2017-10-01 00:00:00	3-year nominal mission life. Physical oceanography, geodesy/gravity, climate monitoring, marine meteorology.	Inclined, non-sun-synchronous	112.4 minutes	N/A	66 deg	1336 km			10 days
122	OKEAN-O	\N	Mission complete	1999-07-17 00:00:00	2002-01-31 00:00:00	Oceanography, agriculture and forestry, hydrology, environmental monitoring, crop and soil monitoring, forest and tundra fires, pollution monitoring.	Sun-synchronous	98 minutes	Descending	98 deg	670 km			
432	OKEAN-01 N7	\N	Mission complete	1994-10-11 00:00:00	2001-05-03 00:00:00		Inclined, non-sun-synchronous	98 minutes	N/A	82.5 deg	650 km			
480	Oersted	Oersted	Currently being flown	1999-11-21 00:00:00	2016-12-01 00:00:00	Earth magnetic field mapping.	Inclined, non-sun-synchronous	100 minutes	TBD	96.5 deg	655 km			
388	Odin	Odin	Currently being flown	2001-02-20 00:00:00	2017-12-01 00:00:00	Atmospheric research, stratospheric ozone chemistry, mesospheric ozone science, summer mesospheric science.	Sun-synchronous	97.6 minutes	Ascending	97.65 deg	570 km		18:00	
655	OCO-2	Orbiting Carbon Observatory-2	Currently being flown	2014-07-02 00:00:00	2017-09-01 00:00:00	High resolution carbon dioxide measurements to characterize sources and sinks on regional scales and quantify their variability over the seasonal cycle.	Sun-synchronous	98.8 minutes	Ascending	98.2 deg	705 km		13:30	16 days
741	OCO-3-on-ISS	ISS/Orbiting Carbon Observatory-3	Planned	2018-01-01 00:00:00	2022-01-01 00:00:00	High resolution carbon dioxide measurements to characterize sources and sinks on regional scales and quantify their variability over the seasonal cycle.	Inclined, non-sun-synchronous	93 minutes	Ascending	51.6 deg	410 km			
820	OCEANSAT-3A	Ocean Satellite-3A	Approved	2020-02-01 00:00:00	2025-02-01 00:00:00	Ocean and atmosphere applications.	Sun-synchronous	99.31 minutes	Descending	98.28 deg	720 km		12:00	2 days
450	OCO	Orbiting Carbon Observatory	Mission complete	2009-02-24 00:00:00	2009-02-24 00:00:00	High resolution carbon dioxide measurements to characterize sources and sinks on regional scales and quantify their variability over the seasonal cycle. Failed on launch.	Sun-synchronous	98.8 minutes	Ascending	98.2 deg	705 km			
551	OCEANSAT-1	Ocean Satellite-1	Mission complete	1999-05-26 00:00:00	2010-12-31 00:00:00	Ocean and atmosphere applications.	Sun-synchronous	99.31 minutes	Descending	98.28 deg	720 km		12:00	2 days
278	OCEANSAT-2	Ocean Satellite-2	Currently being flown	2009-09-24 00:00:00	2017-09-01 00:00:00	Ocean and atmosphere applications.	Sun-synchronous	99.31 minutes	Descending	98.28 deg	720 km		12:00	2 days
134	OCEAN-01	\N	Mission complete	1994-10-11 00:00:00	1996-01-01 00:00:00	Agriculture and forestry, climatology, data collection and communication, hydrology, hydrometeorology, ice and snow, land surface, meteorology.	Inclined, non-sun-synchronous	98 minutes	TBD	82.5 deg	650 km			
756	Obzor-R N4	SAR Operative Monitoring SatelliteObzor-R N4	N/A	2022-12-31 00:00:00	2027-12-31 00:00:00	Operative Earth and disaster monitoring.	Sun-synchronous		TBD	98 deg	650 km		TBD	2 days
754	Obzor-R N3	SAR Operative Monitoring SatelliteObzor-R N3	Planned	2024-01-01 00:00:00	2030-01-01 00:00:00	Operative Earth and disaster monitoring.	Sun-synchronous		TBD					2 days
753	Obzor-R N1	SAR Operative Monitoring Satellite Obzor-R N1	Planned	2019-01-01 00:00:00	2025-01-01 00:00:00	Operative Earth and disaster monitoring.	Sun-synchronous		TBD					2 days
571	OCEANSAT-3	Ocean Satellite-3	Approved	2018-08-01 00:00:00	2023-08-01 00:00:00	Ocean and atmosphere applications.	Sun-synchronous	99.31 minutes	Descending	98.28 deg	720 km		12:00	2 days
755	Obzor-R N2	SAR Operative Monitoring Satellite Obzor-R N2	Planned	2023-01-01 00:00:00	2029-01-01 00:00:00	Operative Earth and disaster monitoring.	Sun-synchronous		TBD					2 days
752	Obzor-O N4	Operative Monitoring Satellite Obzor-O N4	N/A	2026-12-31 00:00:00	2033-12-31 00:00:00	Operative environmental and disaster monitoring for Russian Federation and neighboring states territories.	Sun-synchronous		TBD	98.2 deg	700 km			7 days
759	Obzor-O N3	Operative Monitoring Satellite Obzor-O N3	N/A	2024-12-31 00:00:00	2031-12-31 00:00:00	Operative environmental and disaster monitoring for Russian Federation and neighboring states territories.	Sun-synchronous		TBD	98.2 deg	700 km			7 days
383	NPOESS-6	National Polar-orbiting Operational Environmental Satellite System - 4	Cancelled	2019-05-09 00:00:00	2024-05-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		17:30	
758	Obzor-O N1	Operative Monitoring Satellite Obzor-O N1	Planned	2023-01-01 00:00:00	2030-01-01 00:00:00	Operative environmental and disaster monitoring for Russian Federation and neighboring states territories.	Sun-synchronous		Descending	98.2 deg	700 km			30 days
757	Obzor-O N2	Operative Monitoring Satellite Obzor-O N2	Planned	2025-01-01 00:00:00	2032-01-01 00:00:00	Operative environmental and disaster monitoring for Russian Federation and neighboring states territories.	Sun-synchronous		TBD	98.2 deg	700 km			30 days
361	NPOESS-3	National Polar-orbiting Operational Environmental Satellite System - 3	Cancelled	2018-01-31 00:00:00	2025-01-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		17:30	
264	NPOESS-2	National Polar-orbiting Operational Environmental Satellite System - 2	Cancelled	2016-01-31 00:00:00	2022-01-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	824 km		17:30	
362	NPOESS-4	National Polar-orbiting Operational Environmental Satellite System - 4	Cancelled	2020-01-31 00:00:00	2027-01-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		21:30	
270	NPOESS-1	National Polar-orbiting Operational Environmental Satellite System - 1	Cancelled	2013-01-31 00:00:00	2020-01-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	824 km		13:30	
382	NPOESS-5	National Polar-orbiting Operational Environmental Satellite System - 4	Cancelled	2018-01-01 00:00:00	2023-06-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		13:30	
785	NORSAT-2	NORSAT-2	Approved	2017-01-01 00:00:00	2020-01-01 00:00:00	The satellite will carry multiple antennas for reception of AIS signals. It will also contain equipment for testing VDES (VHF data exchange system).	Sun-synchronous		Descending	98.3 deg	600 km		TBD	
97	NOAA-9	National Oceanic and Atmospheric Administration - 9	Mission complete	1984-12-12 00:00:00	1997-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
510	NOAA-4	National Oceanic and Atmospheric Administration - 4	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
513	NOAA-7	National Oceanic and Atmospheric Administration - 7	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
512	NOAA-6	National Oceanic and Atmospheric Administration - 6	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
746	NORSAT-1	NORSAT-1	Approved	2017-01-01 00:00:00	2020-01-01 00:00:00	Enhanced AIS performance; total solar irradiance; langmuir probe	Sun-synchronous		Descending	98.3 deg			18:00	
499	NOAA-8	National Oceanic and Atmospheric Administration - 8	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
511	NOAA-5	National Oceanic and Atmospheric Administration - 5	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
509	NOAA-3	National Oceanic and Atmospheric Administration - 3	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
508	NOAA-2	National Oceanic and Atmospheric Administration - 2	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
113	NOAA-19	National Oceanic and Atmospheric Administration - 19	Currently being flown	2009-02-04 00:00:00	2016-12-01 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis, search and rescue.	Sun-synchronous	102.1 minutes	Ascending	98.75 deg	870 km		14:00	
105	NOAA-17	National Oceanic and Atmospheric Administration - 17	Mission complete	2002-06-24 00:00:00	2013-04-10 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis, search and rescue.	Sun-synchronous	101.4 minutes	Descending	98.75 deg	833 km		10:00	
104	NOAA-16	National Oceanic and Atmospheric Administration - 16	Mission complete	2000-09-21 00:00:00	2014-06-09 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis, search and rescue.	Sun-synchronous	102 minutes	Ascending	98.8 deg	870 km		13:54	
106	NOAA-18	National Oceanic and Atmospheric Administration - 18	Currently being flown	2005-05-20 00:00:00	2016-12-01 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis, search and rescue.	Sun-synchronous	102.1 minutes	Ascending	98.75 deg	870 km		14:00	
224	NOAA-14	National Oceanic and Atmospheric Administration - 14	Mission complete	1994-12-30 00:00:00	2005-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	102.1 minutes	Ascending	99.1 deg	850 km		17:52	
99	NOAA-11	National Oceanic and Atmospheric Administration - 11	Mission complete	1988-09-24 00:00:00	2004-09-30 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Ascending	99.1 deg	845 km		22:37	
223	NOAA-12	National Oceanic and Atmospheric Administration - 12	Mission complete	1991-05-14 00:00:00	2005-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.3 minutes	Descending	98.5 deg	850 km		4:49	
127	Meteor-3 N7	\N	Mission complete	1994-01-25 00:00:00	1995-01-01 00:00:00	Hydrometeorology, climatology, land surface, physical oceanography, heliogeophysics, data collection.	Inclined, non-sun-synchronous		Ascending	82.5 deg	1200 km			
225	NOAA-15	National Oceanic and Atmospheric Administration - 15	Currently being flown	1998-05-01 00:00:00	2016-12-01 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis, search and rescue. NOAA-15 is being used on a limited basis as a "secondary morning orbit" satellite.	Sun-synchronous	101.4 minutes	Descending	98.6 deg	813 km		7:08	
101	NOAA-13	National Oceanic and Atmospheric Administration - 13	Mission complete	1993-08-09 00:00:00	1993-08-09 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous		TBD		850 km			
380	NMP EO-3 GIFTS	New Millenium Program EO-3 - Geosynchronous Imaging Fourier Transform Spectrometer - (GIFTS)	Cancelled	2006-10-01 00:00:00	2008-10-01 00:00:00	Continuous observation of atmospheric temperature, water vapour content and distribution, and the concentration of certain other atmospheric gases as a function of altitude over time - providing a new way to observe weather and the changing atmosphere.	Geostationary		N/A		36000 km	-83 deg		
98	NOAA-10	National Oceanic and Atmospheric Administration - 10	Mission complete	1986-09-17 00:00:00	1997-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.1 minutes	Descending	98.6 deg	804 km		4:38	0.5 days
354	NIMBUS-7	NIMBUS-7	Mission complete	1978-10-24 00:00:00	1994-10-01 00:00:00		Sun-synchronous	99.28 minutes	N/A	104.09 deg	943 km			
507	NOAA-1	National Oceanic and Atmospheric Administration - 1	Mission complete	1982-12-12 00:00:00	1995-12-31 00:00:00	Meteorology, agriculture and forestry, environmental monitoring, climatology, physical oceanography, Volcanic eruption monitoring, ice and snow cover, total ozone studies, space environment, solar flux analysis.	Sun-synchronous	101.9 minutes	Descending	98.9 deg	850 km			0.5 days
359	NIMBUS-4	\N	Mission complete	1970-04-15 00:00:00	1980-09-30 00:00:00		Sun-synchronous	107.1 minutes	N/A	99.9 deg	1200 km			
203	NMP EO-1	New Millenium Program Earth Observing-1	Currently being flown	2000-11-23 00:00:00	2017-02-01 00:00:00	1.5-year nominal mission life, currently in extended operations. Land surface, earth resources. NMP EO-1 completion of science is planned for 30 September 2016 with passivation planned for 20 March 2017.	Sun-synchronous	99 minutes	Descending	98.2 deg	690 km		10:00	16 days
642	NISAR	NASA ISRO  Synthetic Aperture Radar	Approved	2021-12-01 00:00:00	2025-09-01 00:00:00	3-year mission to study solid earth deformation (earthquakes, volcanoes, landslides), changes in ice (glaciers, sea ice) and changes in vegetation biomass	Sun-synchronous	100 minutes	Descending	98 deg	747 km		6:00	12 days
680	NigeriaSat-X	Nigeria Earth Observation Satellite X	Currently being flown	2011-08-17 00:00:00	2018-08-01 00:00:00	Small satellite mission with technical and scientific objectives (capability demonstration).	Sun-synchronous	97 minutes	Descending	98 deg	700 km		10:15	
353	NIMBUS-6	\N	Mission complete	1975-06-12 00:00:00	1983-03-29 00:00:00		Sun-synchronous	107.4 minutes	N/A	99.9 deg	1101 km			
564	NigeriaSat-2	Nigeria Earth Observation Satellite 2	Currently being flown	2011-08-17 00:00:00	2018-08-01 00:00:00	Small satellite mission with technical and scientific objectives (environmental) monitoring.	Sun-synchronous	97 minutes	Descending	98 deg	700 km			4 days
351	NIMBUS-3	\N	Mission complete	1969-04-14 00:00:00	1972-01-22 00:00:00		Sun-synchronous	107.3 minutes	N/A	101.1 deg	1232 km			
549	MTSAT-3	Multi-functional Transport Satellite	N/A	2013-02-18 00:00:00	2018-12-31 00:00:00	Meteorology, aeronautical applications.	Geostationary		N/A		36000 km	-140 deg		
385	MTSAT-1R	Multi-functional Transport Satellite-1R	Mission complete	2005-02-26 00:00:00	2015-12-04 00:00:00	Meteorology, aeronautical applications.	Geostationary		N/A		36000 km	-140 deg		
563	NigeriaSat-1	NigeriaSat-1	Mission complete	2003-09-27 00:00:00	2010-12-31 00:00:00	Small satellite mission with technical and scientific objectives (environmental) monitoring.	Sun-synchronous	97 minutes	Ascending	98 deg	686 km		10:15	3 days
384	MTSAT-2	Multi-functional Transport Satellite-2	Currently being flown	2006-02-18 00:00:00	2017-01-01 00:00:00	Meteorology, aeronautical applications.	Geostationary		N/A		36000 km	-145 deg		
307	MTSAT-1	Multi-functional Transport Satellite	Mission complete	1999-11-15 00:00:00	1999-11-15 00:00:00	Meteorology, aeronautical applications.	Geostationary		N/A		36000 km	-140 deg		
618	MTG-S2 (sounding)	Meteosat Third Generation S2 Sounding Satellite 2	Approved	2030-12-01 00:00:00	2039-06-01 00:00:00	Supporting European atmospheric composition and air quality monitoring services. MTG S2 carries the Sentinel-4 B mission.	Geostationary		N/A		35779 km	0 deg		
591	MTG-S2	Meteosat Third Generation - second sounding satellite	N/A	2024-09-15 00:00:00	2032-12-15 00:00:00	Meteorology, climatology, Atmospheric dynamics/water and energy cycles.	Geostationary		N/A		36000 km	0 deg		
548	MTG-I1 (imaging)	Meteosat Third Generation - Imaging Satellite 1	Approved	2020-12-01 00:00:00	2029-06-01 00:00:00	Meteorology, climatology, Atmospheric dynamics/water and energy cycles.	Geostationary		N/A		35779 km	0 deg		
590	MTG-S1	Meteosat Third Generation - first sounding satellite	N/A	2018-12-15 00:00:00	2027-06-15 00:00:00	Meteorology, climatology, Atmospheric dynamics/water and energy cycles.	Geostationary		N/A		36000 km	0 deg		
556	MTG-S1 (sounding)	Meteosat Third Generation S1 Sounding Satellite 1	Approved	2022-06-01 00:00:00	2030-12-01 00:00:00	Supporting European atmospheric composition and air quality monitoring services. MTG S1 carries the Sentinel-4 A mission.	Geostationary		N/A		35779 km	0 deg		
589	MTG-I4 (imaging)	Meteosat Third Generation - Imaging Satellite 4	Approved	2032-12-01 00:00:00	2041-06-01 00:00:00	Meteorology, climatology, Atmospheric dynamics/water and energy cycles.	Geostationary		N/A		35779 km	0 deg		
587	MTG-I2 (imaging)	Meteosat Third Generation - Imaging Satellite 2	Approved	2024-12-01 00:00:00	2033-06-01 00:00:00	Meteorology, climatology, Atmospheric dynamics/water and energy cycles.	Geostationary		N/A		35779 km	0 deg		
588	MTG-I3 (imaging)	Meteosat Third Generation - Imaging Satellite 3	Approved	2028-12-01 00:00:00	2037-06-01 00:00:00	Meteorology, climatology, Atmospheric dynamics/water and energy cycles.	Geostationary		N/A		35779 km	0 deg		
83	MOS-1B	Marine Observation Satellite	Mission complete	1990-02-07 00:00:00	1996-04-17 00:00:00	natural resource utilization and for environmental protection.	Sun-synchronous	103 minutes	Descending	99 deg	909 km		10:30	17 days
628	MOS-1	Marine Observation Satellite-1	Mission complete	1987-02-19 00:00:00	1995-11-29 00:00:00	natural resource utilization and for environmental protection.	Sun-synchronous	103 minutes	Ascending	99 deg	909 km		10:30	17 days
841	METOP-SG B3	EUMETSAT Polar System, Second Generation	Approved	2036-12-01 00:00:00	2042-06-01 00:00:00	Meteorology, climatology. 3 satellites.	Sun-synchronous	101.4 minutes	Descending	98.7 deg	824 km		9:30	29 days
679	MIOSAT	Piccola MIssione Ottica basata su microSATellite	Cancelled	2014-06-01 00:00:00	2016-06-01 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils and main atmospheric gases detection.	Sun-synchronous	97 minutes	Descending	97.9 deg	615 km		10:30	
445	Monitor-E	Monitor-E	Mission complete	2005-08-26 00:00:00	2008-01-21 00:00:00	Agriculture and forestry, hydrology, environmental monitoring, hydrometeorology, ice and snow, land surface, meteorology.	Sun-synchronous	95.2 minutes	TBD	97.5 deg	540 km		10:30	
839	METOP-SG A3	EUMETSAT Polar System, Second Generation	Approved	2035-06-01 00:00:00	2042-12-01 00:00:00	Meteorology, climatology. EPS-SG-a carries the Sentinel-5 mission. 3 satellites.	Sun-synchronous	101.4 minutes	Descending	98.7 deg	824 km		9:30	29 days
838	METOP-SG A2	EUMETSAT Polar System, Second Generation	Approved	2028-06-01 00:00:00	2035-12-01 00:00:00	Meteorology, climatology. EPS-SG-a carries the Sentinel-5 mission. 3 satellites.	Sun-synchronous	101.4 minutes	Descending	98.7 deg	824 km		9:30	29 days
557	METOP-SG A1	EUMETSAT Polar System, Second Generation	Approved	2021-06-01 00:00:00	2028-10-01 00:00:00	Meteorology, climatology. EPS-SG-a carries the Sentinel-5 mission. 3 satellites.	Sun-synchronous	101.4 minutes	Descending	98.7 deg	824 km		9:30	29 days
702	METOP-SG B1	EUMETSAT Polar System, Second Generation	Approved	2022-12-01 00:00:00	2030-04-01 00:00:00	Meteorology, climatology. 3 satellites.	Sun-synchronous	101.4 minutes	Descending	98.7 deg	824 km		9:30	29 days
229	Meteosat-8	Meteosat Second Generation-1	Currently being flown	2002-08-28 00:00:00	2019-01-01 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation. Meteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary	1436 minutes	N/A	4.3 deg	35779 km	41.5 deg		
231	Metop-C	Meteorological Operational Polar Satellite - C	Approved	2018-10-01 00:00:00	2023-09-01 00:00:00	Meteorology, climatology.	Sun-synchronous	101.36 minutes	Descending	98.702 deg	817 km		9:30	29 days
230	Metop-B	Meteorological Operational Polar Satellite - B	Currently being flown	2012-09-17 00:00:00	2024-09-01 00:00:00	Meteorology, climatology.	Sun-synchronous	101.7 minutes	Descending	98.702 deg	817 km		9:30	29 days
259	Meteosat-9	Meteosat Second Generation-2	Currently being flown	2005-12-22 00:00:00	2021-01-01 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation. Meteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary	1436 minutes	N/A	1.6 deg	35779 km	9.5 deg		
258	Meteosat-7	Meteosat-7	Currently being flown	1997-09-02 00:00:00	2017-03-01 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation. Meteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary	1436 minutes	N/A	10.2 deg	35779 km	57.5 deg		
261	Metop-A	Meteorological Operational Polar Satellite - A	Currently being flown	2006-10-19 00:00:00	2019-07-01 00:00:00	Meteorology, climatology.	Sun-synchronous	101.36 minutes	Descending	98.702 deg	817 km		9:30	29 days
497	Meteosat-1	Meteosat-1	Mission complete	1977-01-01 00:00:00	1985-01-01 00:00:00	Meteorology, climatology.	Geostationary		TBD		36000 km	0 deg		
228	Meteosat-6	Meteosat-6	Mission complete	1993-11-20 00:00:00	2011-05-02 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation.\n\nMeteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary		N/A		36000 km			
260	Meteosat-10	Meteosat Second Generation-3	Currently being flown	2012-07-05 00:00:00	2022-01-01 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation. Meteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary	1436 minutes	N/A		35779 km	0 deg		
10	Meteosat-5	Meteosat-5	Mission complete	1991-03-02 00:00:00	2007-04-26 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation. Meteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary		N/A		36000 km	-63 deg		
496	Meteosat-2	Meteosat-2	Mission complete	1981-01-01 00:00:00	1993-01-01 00:00:00	Meteorology, climatology.	Geostationary		TBD		36000 km	0 deg		
33	Meteosat-4	Meteosat-4	Mission complete	1989-01-01 00:00:00	1995-01-01 00:00:00	Meteorology, climatology.	Geostationary		TBD		36000 km	0 deg		
451	Meteosat-11	Meteosat Second Generation-4	Currently being flown	2015-07-15 00:00:00	2025-07-01 00:00:00	Meteorology, climatology, atmospheric dynamics/water and energy cycles. Meteosat 1-7 are first generation. Meteosat 8-11 are second generation and known as MSG in the development phase.	Geostationary	1436 minutes	N/A	2.4 deg	35779 km	-3.5 deg		
32	Meteosat-3	Meteosat-3	Mission complete	1988-01-01 00:00:00	1995-01-01 00:00:00	Meteorology, climatology.	Geostationary		TBD		36000 km	0 deg		
623	Meteor-MP N1	Meteor-MP Meteorological Satellite N1	Planned	2023-01-01 00:00:00	2028-01-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, DCS.	Sun-synchronous			98.7 deg	830 km		21:30	
736	Meteor-M N2-2	Meteorological Satellite Meteor-M N2-2	Approved	2017-12-01 00:00:00	2022-12-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and  environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	835 km		TBD	
612	Meteor-M N3	Oceanographical Satellite Meteor-M N3	Approved	2021-12-01 00:00:00	2026-12-01 00:00:00	Oceanography, hydrometeorology, climatology.	Sun-synchronous	102 minutes	Ascending	98.7 deg	835 km		TBD	37 days
811	Meteor-M N2-5	Meteorological Satellite Meteor-M N2-5	Approved	2022-12-01 00:00:00	2027-12-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and  environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	835 km		TBD	
681	Meteor-MP N2	Meteor-MP Meteorological Satellite N2	Planned	2024-01-01 00:00:00	2029-01-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, DCS.	Sun-synchronous			98.7 deg	836 km		9:30	
810	Meteor-M N2-4	Meteorological Satellite Meteor-M N2-4	Approved	2019-12-01 00:00:00	2024-12-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and  environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	835 km		TBD	
813	Meteor-M N2-3	Meteorological Satellite Meteor-M N2-3	Approved	2018-12-01 00:00:00	2023-12-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and  environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	835 km		TBD	
682	Meteor-MP N3	Meteor-MP Meteorological Satellite N3	Planned	2025-01-01 00:00:00	2030-01-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, DCS.	Sun-synchronous							
735	Meteor-M N2-1	Meteorological Satellite Meteor-M N2-1	Approved	2017-12-01 00:00:00	2022-12-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and  environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	835 km		TBD	
477	Meteor-M N2	Meteorological Satellite Meteor-M N2	Currently being flown	2014-07-08 00:00:00	2018-07-01 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and  environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	835 km		09:30	
476	Meteor-M N1	Meteorological Satellite Meteor-M N1	Mission complete	2009-09-17 00:00:00	2014-09-18 00:00:00	Hydrometeorology, climatology, heliogeophysics, Earth resources and environmental monitoring.	Sun-synchronous	101 minutes	Ascending	98.8 deg	832 km		09:30	
126	Meteor-3 N5	\N	Mission complete	1991-08-15 00:00:00	2002-12-31 00:00:00	Currently limited operation (only MR-900B instrument is working). Hydrometeorology, climatology, land surface, physical oceanography, heliogeophysics, data collection.	Inclined, non-sun-synchronous	109 minutes	Ascending	82.5 deg	1200 km			
129	Meteor-3M N1	\N	Mission complete	2001-12-10 00:00:00	2005-12-31 00:00:00	Hydrometeorology, climatology, land surface, physical oceanography, heliogeophysics and space environment, sounding of the atmosphere, agriculture. (Expected operational during 2002).	Sun-synchronous	105.3 minutes	Ascending	99.6 deg	1018 km			
130	Meteor-3M	\N	Mission complete	2001-12-01 00:00:00	2008-04-01 00:00:00	Hydrometeorology, climatology, land surface, physical oceanography, heliogeophysics and space environment, data collection, sounding of the atmosphere, agriculture.	Sun-synchronous	105.3 minutes	Ascending	99.6 deg	1024 km			
125	Meteor-2 N24	\N	Mission complete	1993-01-01 00:00:00	2001-01-01 00:00:00	Land surface, physical oceanography, atmospheric dynamics/water and land surface, physical oceanography, atmospheric dynamics/water and energy cycles.	Sun-synchronous		TBD		900 km			
128	Meteor-3 N8	\N	Mission complete	1994-01-01 00:00:00	1998-01-01 00:00:00	Land surface, physical.	Sun-synchronous		TBD	82.5 deg	1200 km			
434	Meteor-2 N21	\N	Mission complete	1991-08-31 00:00:00	2002-08-06 00:00:00	Currently limited operation (only 1 instrument working): Hydrometeorology, climatology, land surface, physical oceanography, heliogeophysics, data collection.	Inclined, non-sun-synchronous	109 minutes	Ascending	82.5 deg	1200 km			
375	MEGHA-TROPIQUES	Megha-Tropiques	Currently being flown	2011-10-12 00:00:00	2020-12-01 00:00:00	Study of the inter-tropical zone and its convective systems (water and energy cycles).	Inclined, non-sun-synchronous	102.16 minutes	Ascending	20 deg	867 km			
678	MERLIN	Methane Remote Sensing Lidar Mission	Approved	2021-12-01 00:00:00	2024-11-01 00:00:00	Global atmospheric methane concentration.	Sun-synchronous	90 minutes	Ascending		500 km			28 days
604	MAPSAR	Multi-purpose SAR	Cancelled	2015-12-03 00:00:00	2019-12-03 00:00:00	Multi-purpose SAR.	Sun-synchronous		Descending	98 deg	620 km			
748	LOTUSat 2	LOTUSat 2	Planned	2022-01-01 00:00:00	2024-01-01 00:00:00									
815	MAIA	Multi-Angle Imager for Aerosols	Approved	2020-01-01 00:00:00	2023-01-01 00:00:00	To determine associations between different types of airborne particulate matter and adverse human health outcomes.	TBD		TBD				TBD	
19	LARES	LAser RElativity Satellite	Currently being flown	2012-02-13 00:00:00	2052-02-01 00:00:00	Scientific objectives are the measurement of the dragging of inertial frames due to the Earth's angular momentum, or Lense-Thirring effect, and a high precision test of the Earth's gravitomagnetic field with accuracy of the order of a few percent. Gravitomagnetic field and dragging of inertial frames are predictions of Einstein's theory of General Relativity. In addition, LARES will allow other measurements in geodesy and geodynamics.	Inclined, non-sun-synchronous	99.1 minutes	Ascending	71 deg	1450 km		Not defined	
747	LOTUSat 1	LOTUSat 1	Planned	2019-01-01 00:00:00	2021-01-01 00:00:00									
780	LIS-on-ISS	International Space Station/Lightning Imaging Sensor	Approved	2017-01-01 00:00:00	2020-01-01 00:00:00	Spare LIS unit from the TRMM mission. NASA selected the LIS spare hardware to fly to the space station in order to take advantage of the orbiting laboratory’s high inclination. Will monitor global lightning for Earth science studies, provide cross-sensor calibration and validation with other space-borne instruments, and ground-based lightning networks. LIS will also supply real-time lightning data over data-sparse regions, such as oceans, to support operational weather forecasting and warning.	Inclined, non-sun-synchronous	90 minutes		51 deg	425 km			
649	LIST	Lidar Surface Topography	Considered	2030-01-01 00:00:00	2033-01-01 00:00:00	Phase-3 DS Mission, launch order unknown, 3-year nominal mission. Land surface topography for landslide hazards and water runoff.	Sun-synchronous							365 days
88	Landsat-4	Landsat-4	Mission complete	1982-07-16 00:00:00	1993-08-01 00:00:00		Sun-synchronous	98.9 minutes	Descending	98.2 deg	705 km			16 days
663	Landsat-2	Landsat-2	Mission complete	1975-01-22 00:00:00	1982-02-25 00:00:00		Sun-synchronous		Descending	99.2 deg	917 km		9:30	
664	Landsat-3	Landsat-3	Mission complete	1978-03-05 00:00:00	1983-03-21 00:00:00		Sun-synchronous		Descending	99.1 deg	917 km		9:30	
662	Landsat-1	Landsat-1	Mission complete	1972-06-23 00:00:00	1978-01-06 00:00:00		Sun-synchronous		Descending	99.2 deg	917 km		9:30	
772	Landsat 9	Landsat 9	Approved	2020-12-01 00:00:00	2025-03-01 00:00:00	5-year mission design life with at least 10 years of consumables. Earth resources, land surface, environmental monitoring, agriculture and forestry, disaster monitoring and assessment, ice and snow cover.	Sun-synchronous	98.9 minutes	Descending	98.2 deg	705 km		10:00	16 days
547	Landsat 8	Landsat 8	Currently being flown	2013-02-11 00:00:00	2023-05-01 00:00:00	10-year nominal mission life. Earth resources, land surface, environmental monitoring, agriculture and forestry, disaster monitoring and assessment, ice and snow cover.	Sun-synchronous	98.9 minutes	Descending	98.2 deg	705 km		10:11	16 days
226	Landsat 5	Landsat 5	Mission complete	1984-03-01 00:00:00	2013-06-05 00:00:00	Earth resources, land surface, environmental monitoring, agriculture and forestry, disaster monitoring and assessment, ice and snow cover.	Sun-synchronous	98.9 minutes	Descending	98.2 deg	705 km		10:00	16 days
349	Landsat 7	Landsat 7	Currently being flown	1999-04-15 00:00:00	2021-01-01 00:00:00	5-year nominal mission life, currently in extended operations. Earth resources, land surface, environmental monitoring, agriculture and forestry, disaster monitoring and assessment, ice and snow cover.  The LST will be allowed to drift below the mission specification towards end of mission life.	Sun-synchronous	98.9 minutes	Descending	98.2 deg	705 km		10:05	16 days
238	LAGEOS-2	Laser Geodynamics Satellite - 2	Currently being flown	1992-10-22 00:00:00	2052-10-01 00:00:00	Geodesy, crustal motion and gravity field measurements by laser ranging.	Inclined, non-sun-synchronous	223 minutes	N/A	52.6 deg	5800 km			
791	Kondor-FKA N2	SAR Satellite Kondor-FKA N2	Planned	2019-01-01 00:00:00	2023-01-01 00:00:00	Disaster monitoring, sea surface monitoring, information support of environmental managment	TBD		TBD					
790	Kondor-FKA N1	SAR Satellite Kondor-FKA N1	Planned	2018-01-01 00:00:00	2022-01-01 00:00:00	Disaster monitoring, sea surface monitoring, information support of environmental managment	TBD		TBD					
761	KOMPSAT-6	Korea Multi-Purpose Satellite -6	Approved	2019-06-01 00:00:00	2024-06-01 00:00:00	Cartography, land use and planning, disaster monitoring	Sun-synchronous	98.5 minutes	Descending		550 km			
638	KOMPSAT-5	Korea Multi-Purpose Satellite -5	Currently being flown	2013-08-22 00:00:00	2017-08-01 00:00:00	Cartography, land use and planning, disaster monitoring.	Sun-synchronous	98.5 minutes	Descending		550 km		6:00	28 days
637	KOMPSAT-3	Korea Multi-Purpose Satellite -3	Currently being flown	2012-05-18 00:00:00	2017-05-01 00:00:00	Cartography, land use and planning, disaster monitoring.	Sun-synchronous	98.5 minutes	Ascending		685 km		10:50	28 days
698	KOMPSAT-3A	Korea Multi-Purpose Satellite -3A	Currently being flown	2015-03-26 00:00:00	2019-03-01 00:00:00	Cartography, land use and planning, disaster monitoring.	Sun-synchronous	98.5 minutes	Ascending		528 km			28 days
407	KOMPSAT-2	Korea Multi-Purpose Satellite -2	Currently being flown	2006-07-27 00:00:00	2016-12-01 00:00:00	Cartography, land use and planning, disaster monitoring.	Sun-synchronous	98.5 minutes	Ascending	98.1 deg	685 km		10:50	28 days
201	LAGEOS-1	Laser Geodynamics Satellite - 1	Currently being flown	1976-05-04 00:00:00	2052-05-01 00:00:00	Geodesy, crustal motion and gravity field measurements by laser ranging.	Inclined, non-sun-synchronous	226 minutes	N/A	110 deg	5900 km			
406	KOMPSAT-1	Korea Multi-Purpose Satellite 1	Mission complete	1999-12-21 00:00:00	2008-01-31 00:00:00	Cartography, land use and planning, disaster monitoring, Global marine resource and environmental monitoring, ocean contamination and chlorophyll detection.	Sun-synchronous	98.5 minutes	Ascending		685 km		10:50	28 days
473	Kanopus-Vulkan	Kanopus-Vulkan	N/A	2007-01-01 00:00:00	2012-12-31 00:00:00	Hydrology, hydrometeorology, monitoring man-made and natural accidents, research into short-term forecasting of earthquakes.	Sun-synchronous			97 deg	700 km			
625	Kanopus-V-IR	Environmental Satellite Kanopus-V-IR	Approved	2017-12-01 00:00:00	2022-12-01 00:00:00	Disaster monitoring, forest fire detection, land surface, environmental monitoring.	Sun-synchronous	94.7 minutes	Ascending	97.4 deg	510 km			5 days
792	Kanopus-V N3	Environmental Satellite Kanopus-V N3	Planned	2017-01-01 00:00:00	2021-01-01 00:00:00	Disaster monitoring, forest fire detection, land surface, environmental monitoring.	Sun-synchronous	94.7 minutes	Ascending	97.4 deg	510 km			5 days
793	Kanopus-V N4	Environmental Satellite Kanopus-V N4	Planned	2017-01-01 00:00:00	2021-01-01 00:00:00	Disaster monitoring, forest fire detection, land surface, environmental monitoring.	Sun-synchronous	94.7 minutes	Ascending	97.4 deg	510 km			5 days
610	Kanopus-V	Environmental Satellite Kanopus-V	Currently being flown	2012-07-22 00:00:00	2017-07-01 00:00:00	Disaster monitoring, forest fire detection, land surface, environmental monitoring.	Sun-synchronous	94.7 minutes	Ascending	97.4 deg	510 km			5 days
794	Kanopus-V N5	Environmental Satellite Kanopus-V N5	Planned	2018-01-01 00:00:00	2024-01-01 00:00:00	Disaster monitoring, forest fire detection, land surface, environmental monitoring.	Sun-synchronous	94.7 minutes	Ascending	97.4 deg	510 km			5 days
795	Kanopus-V N6	Environmental Satellite Kanopus-V N6	Planned	2018-01-01 00:00:00	2024-01-01 00:00:00	Disaster monitoring, forest fire detection, land surface, environmental monitoring.	Sun-synchronous	94.7 minutes	Ascending	97.4 deg	510 km			5 days
802	JPSS-4	Joint Polar Satellite System - 4\n (Polar Follow-0n)	Planned	2031-01-01 00:00:00	2038-01-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection. Note that free-flyer options are being considered for the A-DCS4 and SARSAT instruments, though these are considered part of the JPSS system. Instrument complement for JPSS-3 and JPSS-4 remains TBD.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		13:30	16 days
436	KALPANA-1	Meteorological Satellite	Currently being flown	2002-09-12 00:00:00	2016-12-01 00:00:00	Meteorological applications.	Geostationary		N/A		36000 km	-83 deg		
801	JPSS-3	Joint Polar Satellite System - 3\n (Polar Follow-on)	Planned	2026-01-01 00:00:00	2033-01-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection. Note that free-flyer options are being considered for the A-DCS4 and SARSAT instruments, though these are considered part of the JPSS system. Instrument complement for JPSS-3 and JPSS-4 remains TBD.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		13:30	16 days
245	JERS-1	Japanese Earth Resource Satellite	Mission complete	1992-02-11 00:00:00	1998-10-12 00:00:00	Earth resources, Land surface.	Sun-synchronous	96 minutes	Descending	98 deg	570 km		10:45	44 days
668	JPSS-2	Joint Polar Satellite System - 2	Approved	2021-12-01 00:00:00	2028-12-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection. Note that free-flyer options are being considered for the A-DCS4 and SARSAT instruments, though these are considered part of the JPSS system.	Sun-synchronous	101 minutes	Ascending	98.75 deg	833 km		13:30	16 days
667	JPSS-1	Joint Polar Satellite System - 1	Approved	2017-03-01 00:00:00	2024-03-01 00:00:00	Meteorological, climatic, terrestrial, oceanographic, and solar-geophysical applications; global and regional environmental monitoring, search and rescue, data collection.	Sun-synchronous	101 minutes	Ascending	98.75 deg	824 km		13:30	16 days
566	ISTAG	Indian Satellite for Aerosol and Gases	N/A	2015-01-01 00:00:00	2020-01-01 00:00:00	Study of changes in atmospheric aerosol and trace gases.	Sun-synchronous		TBD					
286	Jason-1	Jason-1	Mission complete	2001-12-09 00:00:00	2013-07-03 00:00:00	3-year nominal mission life, currently in extended operations. Physical oceanography, geodesy/gravity, climate monitoring, marine meteorology.	Inclined, non-sun-synchronous	112.4 minutes	N/A	66 deg	1336 km			10 days
677	ISS/JEM	International Space Station/Japanese Experiment Mo	Mission complete	2009-09-10 00:00:00	2011-01-19 00:00:00	Scientific experiments on orbit.	Inclined, non-sun-synchronous	93 minutes	Ascending	51.6 deg	407 km			
357	ISS	International Space Station	N/A	2005-02-01 00:00:00	2015-01-01 00:00:00	Various applications, including platform for EO sensors.	Inclined, non-sun-synchronous		N/A					
257	IRS-P4	OCEANSAT-1	Mission complete	1999-05-26 00:00:00	2006-12-31 00:00:00	Ocean biology, physical oceanography.	Sun-synchronous	99.31 minutes	Descending	98.28 deg	720 km		12:15	2 days
235	IRS-1C	Indian Remote Sensing Satellite - 1C	Mission complete	1995-12-28 00:00:00	2007-09-21 00:00:00	Land surface, agriculture and forestry regional geology, land use studies, water resources, vegetation studies, coastal studies and soils, cartography, digital terrain models.	Sun-synchronous	101.35 minutes	Descending	98.6 deg	817 km		10:50	24 days
237	IRS-P3	Indian Remote Sensing Satellite - P3	Mission complete	1996-03-21 00:00:00	2003-12-31 00:00:00	Ocean biology, physical oceanography, land surface, agriculture and forestry, water resources, vegetation and coastal studies.	Sun-synchronous	101.35 minutes	Descending	98.7 deg	817 km		10:30	24 days
274	IRS-1D	Indian Remote Sensing Satellite - 1D	Mission complete	1997-09-29 00:00:00	2010-01-02 00:00:00	Land surface, agriculture and forestry regional geology, land use studies, water resources, vegetation studies, coastal studies and soils.	Sun-synchronous	101 minutes	Descending	98.6 deg	817 km		10:30	24 days
592	Jason-3	Jason-3	Currently being flown	2016-01-17 00:00:00	2019-03-01 00:00:00	3-year nominal mission lifetime, 5-year extended lifetime. Physical oceanography, geodesy/gravity, climate monitoring, marine meteorology.	Inclined, non-sun-synchronous	112.4 minutes	N/A	66 deg	1336 km			10 days
234	IRS-P2	Indian Remote Sensing Satellite - P2	Mission complete	1994-10-15 00:00:00	1997-12-31 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils.	Sun-synchronous	103 minutes	Descending	98 deg	904 km		10:15	22 days
277	IRS-1B	Indian Remote Sensing Satellite - 1B	Mission complete	1991-08-29 00:00:00	2002-08-31 00:00:00	Land surface, agriculture and forestry, regional geology, land use studies, water resources, vegetation studies, coastal studies and soils.	Sun-synchronous	101 minutes	Descending	99 deg	904 km		10:30	26 days
51	IRS-1A	Indian Remote Sensing Satellite - 1A	Mission complete	1988-03-17 00:00:00	1994-01-01 00:00:00	Land surface, agriculture and forestry regional geology, land use studies, water resources, vegetation studies, coastal studies and soils.	Sun-synchronous		Descending		904 km			
438	INSAT-3A	Indian National Satellite - 3A	Currently being flown	2003-04-10 00:00:00	2017-11-01 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		N/A		36000 km	-94 deg		
493	INSAT-3B	\N	Cancelled	\N	\N									
708	INSAT-3DS	Indian National Satellite - 3DS	N/A	2022-12-01 00:00:00	2029-12-01 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		N/A		36000 km	-93.5 deg		
494	INSAT-3C	\N	Cancelled	\N	\N									
233	INSAT-2E	Indian National Satellite - 2E	Mission complete	1999-04-03 00:00:00	2011-05-04 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		N/A		36000 km	-83 deg		
50	INSAT-2D	Indian National Satellite - 2D	Mission complete	1997-06-04 00:00:00	2003-01-01 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-74 deg		
442	INSAT-3D	Indian National Satellite - 3D	Currently being flown	2013-07-26 00:00:00	2020-07-01 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		N/A		36000 km	-93.5 deg		
707	INSAT-3DR	Indian National Satellite - 3DR (repeat)	Currently being flown	2016-09-08 00:00:00	2023-09-01 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		N/A		36000 km	-93.5 deg		
49	INSAT-2C	Indian National Satellite - 2C	Mission complete	1995-07-12 00:00:00	2002-01-01 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-74 deg		
504	INSAT-1B	Indian National Satellite - 1B	Mission complete	1982-07-10 00:00:00	1989-07-10 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-74 deg		
47	INSAT-2A	Indian National Satellite - 2A	Mission complete	1992-07-10 00:00:00	1999-07-10 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-74 deg		
400	IGPM	\N	Cancelled	2006-01-01 00:00:00	2008-01-01 00:00:00	To detect and measure rain and snowfall, to demonstrate the feasibility of high quality measurements of light rain and snow from space.	Sun-synchronous		TBD		510 km			
505	INSAT-1C	Indian National Satellite - 1C	Mission complete	1984-07-10 00:00:00	1989-07-10 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-74 deg		
506	INSAT-1D	Indian National Satellite - 1D	Mission complete	1986-07-10 00:00:00	1989-07-10 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-74 deg		
562	Ingenio	Ingenio	Approved	2019-03-01 00:00:00	2025-01-01 00:00:00	Cartography, land use, urban management, water management, agriculture and environmental monitoring, risk management and security.	Sun-synchronous	98 minutes	Descending	98 deg	685 km		10:30	49 days
570	IMS-1	Indian Mini Satellite-1	Mission complete	2008-04-28 00:00:00	2013-07-31 00:00:00	Micro-satellite for Third World countries for natural resources monitoring and management .	Sun-synchronous	97 minutes	Descending	97.92 deg	632 km		9:30	22 days
232	INSAT-2B	Indian National Satellite - 2B	Mission complete	1993-03-27 00:00:00	2000-03-27 00:00:00	Meteorology, data collection and communication, search and rescue.	Geostationary		TBD		36000 km	-94 deg		
613	ICESat-II	Ice, Cloud, and Land Elevation Satellite II	Approved	2017-10-01 00:00:00	2020-12-01 00:00:00	3-year nominal mission life, 5-year goal. Continue the assessment of polar ice changes and measure vegetation canopy heights, allowing estimates of biomass and carbon in aboveground vegetation in conjunction with related missions, and allow measurements of solid earth properties.	Inclined, non-sun-synchronous	97 minutes	TBD	92 deg	500 km			183 days
834	HY-3D	HY-3D	Considered	2024-01-01 00:00:00	2028-01-01 00:00:00	Ocean monitoring, environmental protection, coastal zone survey, etc.	Sun-synchronous							
644	HyspIRI	Hyperspectral Infrared Imager	Considered	2023-01-01 00:00:00	2026-01-01 00:00:00	Phase-2 DS Mission, launch order unknown, 3-year nominal mission. Land surface composition for agriculture and mineral characterization; vegetation types for ecosystem health.	Sun-synchronous		TBD	98 deg	626 km		11:00	19 days
615	HY-3A	HY-3A	Planned	2019-01-01 00:00:00	2024-01-01 00:00:00	Ocean monitoring, environmental protection, coastal zone survey, etc.	Sun-synchronous							
621	HyS-OP	Hyperspectral Operational Satellite	Cancelled	2014-01-01 00:00:00	2018-01-01 00:00:00	Operational satellite for hyperspectral applications.	Sun-synchronous							
449	HYDROS	Hydrosphere State	Cancelled	2010-12-01 00:00:00	2014-12-01 00:00:00	Measure soil moisture content and freeze-thaw state.	Sun-synchronous		TBD	98 deg	670 km			
212	ICESat	Ice, Cloud, and Land Elevation Satellite	Mission complete	2003-01-12 00:00:00	2010-08-14 00:00:00	3-year nominal mission life, currently in extended operations. Monitors mass balance of polar ice sheets and their contribution to global sea level change. Secondary goals: cloud heights and vertical structure of clouds/aerosols; roughness, reflectivity, vegetation heights, snow-cover.	Inclined, non-sun-synchronous	97 minutes	N/A	94 deg	600 km			183 days
616	HY-3B	HY-3B	Planned	2017-01-01 00:00:00	2022-01-01 00:00:00	Ocean monitoring, environmental protection, coastal zone survey, etc.	Sun-synchronous							
617	HY-3C	HY-3C	Planned	2022-01-01 00:00:00	2027-01-01 00:00:00	Ocean monitoring, environmental protection, coastal zone survey, etc.	Sun-synchronous							
832	HY-2G	Ocean dynamics satellite G	Planned	2022-01-01 00:00:00	2025-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
609	HY-2A	Ocean dynamics satellite A	Currently being flown	2011-08-16 00:00:00	2016-12-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous	104 minutes	Descending	99.3 deg	963 km		6:00	14 days
833	HY-2H	Ocean dynamics satellite H	Considered	2024-01-01 00:00:00	2027-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
720	HY-2D	Ocean dynamics satellite D	Planned	2019-01-01 00:00:00	2022-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
830	HY-2E	Ocean dynamics satellite E	Planned	2021-01-01 00:00:00	2024-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
718	HY-2B	Ocean dynamics satellite B	Planned	2017-01-01 00:00:00	2020-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
719	HY-2C	Ocean dynamics satellite C	Planned	2018-01-01 00:00:00	2021-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
831	HY-2F	Ocean dynamics satellite F	Planned	2020-01-01 00:00:00	2023-01-01 00:00:00	Detecting ocean surface temperature, wind field, wave and topography.	Sun-synchronous		Descending	99.3 deg	963 km		6:00	14 days
829	HY-1F	Ocean color satellite F	Considered	2023-01-01 00:00:00	2026-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.6 deg	798 km		10:30	7 days
828	HY-1E	Ocean color satellite E	Considered	2022-01-01 00:00:00	2025-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.6 deg	798 km		10:30	7 days
827	HY-1D	Ocean color satellite D	Considered	2018-01-01 00:00:00	2021-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.6 deg	798 km		10:30	7 days
607	HY-1C	Ocean color and temperature satellite C	Cancelled	2011-06-01 00:00:00	2013-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.6 deg	798 km		10:31	7 days
608	HY-1D	Ocean color and temperature satellite D	Cancelled	2011-12-01 00:00:00	2013-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Ascending	98.6 deg	798 km		13:30	7 days
467	HY-1B	Ocean color satellite B	Mission complete	2007-04-11 00:00:00	2011-04-11 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.6 deg	798 km		10:30	7 days
466	HY-1A	Ocean color satellite A	Mission complete	2002-05-01 00:00:00	2004-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.8 deg	850 km			7 days
826	HY-1C	Ocean color satellite C	Considered	2017-01-01 00:00:00	2020-01-01 00:00:00	Detecting ocean colour and sea surface temperature.	Sun-synchronous		Descending	98.6 deg	798 km		10:30	7 days
762	HRWS SAR	High Resolution Wide Swath SAR	Planned	2022-01-01 00:00:00	2028-01-01 00:00:00	Cartography, land surface, civil planning and mapping, digital terrain models, environmental monitoring.								
465	HJ-1C	Huan Jing-1C	Currently being flown	2012-11-19 00:00:00	2016-12-01 00:00:00	Disaster and environment monitoring and forecasting. Small satellite constellation.	Sun-synchronous		Descending	97.3 deg	499 km		6:00	31 days
464	HJ-1B	Huan Jing-1B	Currently being flown	2008-09-06 00:00:00	2016-12-01 00:00:00	Disaster and environment monitoring and forecasting. Small satellite constellation.	Sun-synchronous		Descending	97.9 deg	649 km		10:30	31 days
463	HJ-1A	Huan Jing-1A	Currently being flown	2008-09-06 00:00:00	2016-12-01 00:00:00	Disaster and environment monitoring and forecasting. Small satellite constellation.	Sun-synchronous		Descending	97.9 deg	649 km		10:30	31 days
729	Himawari-9	Himawari-9	Planned	2016-01-01 00:00:00	2031-01-01 00:00:00	Meteorology, environmental monitoring	Geostationary		N/A		36000 km	-140.7 deg		
651	GRACE-II	Gravity Recovery and Climate Experiment	Considered	2030-01-01 00:00:00	2033-01-01 00:00:00	Phase-3 DS Mission, launch order unknown, 3-year nominal mission. High temporal resolution gravity fields for tracking large scale water movement.	Inclined, non-sun-synchronous		TBD					
781	HICO-on-ISS	International Space Station/Hyperspectral Imager for the Coastal Ocean	Mission complete	2009-09-10 00:00:00	2014-09-13 00:00:00	Hyperspectral Imager for the Coastal Ocean was an imaging spectrometer based on the PHILLS airborne imaging spectrometers. HICO is the first spaceborne imaging spectrometer designed to sample the coastal ocean.	Inclined, non-sun-synchronous	90 minutes		51 deg	425 km			
728	Himawari-8	Himawari-8	Currently being flown	2014-10-07 00:00:00	2029-01-01 00:00:00	Meteorology, environmental monitoring	Geostationary		N/A		36000 km	-140.7 deg		
686	GRACE-FO	Gravity Recovery and Climate Experiment - Follow-on	Approved	2017-08-01 00:00:00	2022-11-01 00:00:00	5-year nominal mission life, Extremely high precision gravity measurements for use in construction of gravity field models. GRACE consists of two satellites (A, B) serving one mission.	Inclined, non-sun-synchronous	90 minutes	TBD	89 deg	500 km			
337	GRACE	Gravity Recovery and Climate Experiment	Currently being flown	2002-03-17 00:00:00	2017-09-01 00:00:00	5-year nominal mission life, currently in extended operations. Extremely high precision gravity measurements for use in construction of gravity field models. GRACE consists of two satellites (A, B) serving one mission.	Inclined, non-sun-synchronous	94 minutes	N/A	89 deg	350 km			
448	GPM Core	Global Precipitation Measurement Mission Core spacecraft	Currently being flown	2014-02-27 00:00:00	2017-05-01 00:00:00	3-year nominal mission life, 5-year goal. Study of global precipitation, evaporation, and cycling of water are changing. The mission comprises a primary spacecraft with active and passive microwave instruments, and a number of ‘constellation spacecraft' with passive microwave instruments.	Inclined, non-sun-synchronous	95 minutes	TBD	65 deg	407 km		N/A	
429	GPM Constellation	Global Precipitation Measurement Mission Constellation spacecraft	Cancelled	2014-11-01 00:00:00	2019-11-01 00:00:00	3-year nominal mission life, 5-year goal. Study of global precipitation, evaporation, and cycling of water are changing. The mission comprises a primary spacecraft with active and passive microwave instruments, and a number of ‘constellation spacecraft with passive microwave instruments.	Inclined, non-sun-synchronous		TBD	40 deg	635 km			
603	GPM-Br	Global Precipitation Measurement Satellite	Cancelled	2016-12-01 00:00:00	2020-12-01 00:00:00	Global precipitation measurements.	Inclined, non-sun-synchronous		TBD	30 deg	600 km			
458	GOSAT	Greenhouse gases Observing SATellite	Currently being flown	2009-01-23 00:00:00	2018-03-01 00:00:00	Observation of greenhouse gases.	Sun-synchronous	98.18 minutes	Descending	98.06 deg	666 km		13:00	3 days
721	GOSAT-2	Greenhouse gases Observing SATellite-2	Approved	2018-01-01 00:00:00	2023-01-01 00:00:00	Observation of greenhouse gases.	Sun-synchronous	96.9 minutes	Descending	97.8 deg	613 km		13:00	6 days
433	GOMS/Electro N3	Geostationary Operational Meteorological Satellite - 3	Cancelled	2010-01-01 00:00:00	1900-12-31 00:00:00	Hydrometeorology, climatology, disaster management, space environment, ice and snow, land surface, space environment, data collection and communication.	Geostationary		N/A		36000 km	-76 deg		
133	GOMS/Electro N1	Geostationary Operational Meteorological Satellite - 1	Mission complete	1994-11-01 00:00:00	1998-09-15 00:00:00	Hydrometeorology, climatology, disaster management, space environment, ice and snow, land surface, space environment, data collection and communication.	Geostationary		N/A		36000 km	-76 deg		
727	GOES-T	Geostationary Operational Environmental Satellite - T	Approved	2019-04-01 00:00:00	2033-07-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering.	Geostationary		N/A		36000 km			
724	GOES-U	Geostationary Operational Environmental Satellite - U	Approved	2024-10-01 00:00:00	2038-10-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering.	Geostationary		N/A		36000 km			
222	GOES-9	Geostationary Operational Environmental Satellite - 9	Mission complete	1995-05-23 00:00:00	2005-01-15 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection, platform, data gathering, WEFAX.	Geostationary		N/A		36000 km	255 deg		
91	GOES-7	Geostationary Operational Environmental Satellite - 7	Mission complete	1987-02-26 00:00:00	1995-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
200	GOES-8	Geostationary Operational Environmental Satellite - 8	Mission complete	1994-04-13 00:00:00	2003-01-04 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX.	Geostationary		N/A	0.09 deg	36000 km	195 deg		
363	FY-2C	FY-2C Geostationary Meteorological Satellite	Mission complete	2004-10-19 00:00:00	2008-11-25 00:00:00	Meteorology and environmental monitoring Data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
522	GOES-5	Geostationary Operational Environmental Satellite - 5	Mission complete	1984-02-26 00:00:00	1989-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
470	GOES-R	Geostationary Operational Environmental Satellite - R	Approved	2016-11-01 00:00:00	2026-11-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering.	Geostationary		N/A		36000 km			
546	GOES-S	Geostationary Operational Environmental Satellite - S	Approved	2018-01-01 00:00:00	2029-10-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering.	Geostationary		N/A		36000 km			
501	GOES-6	Geostationary Operational Environmental Satellite - 6	Mission complete	1984-02-26 00:00:00	1989-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
521	GOES-4	Geostationary Operational Environmental Satellite - 4	Mission complete	1984-02-26 00:00:00	1989-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
520	GOES-3	Geostationary Operational Environmental Satellite - 3	Mission complete	1984-02-26 00:00:00	1989-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
94	GOES-10	Geostationary Operational Environmental Satellite - 10	Mission complete	1997-04-25 00:00:00	2006-01-15 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX.	Geostationary		N/A		36000 km	135 deg		
519	GOES-2	Geostationary Operational Environmental Satellite - 2	Mission complete	1984-02-26 00:00:00	1989-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
266	GOES-14	Geostationary Operational Environmental Satellite - 14	Currently being flown	2009-06-27 00:00:00	2024-06-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX. On-orbit spare.	Geostationary		N/A		36000 km	105 deg		
95	GOES-11	Geostationary Operational Environmental Satellite - 11	Mission complete	2000-05-03 00:00:00	2011-12-14 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX.	Geostationary		N/A		36000 km	135 deg		
96	GOES-12	Geostationary Operational Environmental Satellite - 12	Mission complete	2001-07-23 00:00:00	2013-08-19 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX.	Geostationary		N/A		36000 km	60 deg		
335	GOES-15	Geostationary Operational Environmental Satellite - 15	Currently being flown	2010-03-04 00:00:00	2025-06-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX.	Geostationary		N/A		36000 km	135 deg		
518	GOES-1	Geostationary Operational Environmental Satellite - 1	Mission complete	1984-02-26 00:00:00	1989-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
495	GOES-13	Geostationary Operational Environmental Satellite - 13	Currently being flown	2006-05-24 00:00:00	2021-06-01 00:00:00	Meteorology (primary mission), search and rescue, space environment monitoring, data collection platform, data gathering, WEFAX.	Geostationary		N/A		36000 km	75 deg		
516	GOES (SMS 2)	Geostationary Operational Environmental Satellite (SMS 2)	Mission complete	1987-02-26 00:00:00	1995-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
515	GOES (SMS 1)	Geostationary Operational Environmental Satellite (SMS 1)	Mission complete	1987-02-26 00:00:00	1995-01-01 00:00:00	Meteorology, atmospheric dynamics, land surface, space environment, search and rescue, data collection, WEFAX (weather facsimile service).	Geostationary		N/A	4.3 deg	36000 km	170 deg		
81	GMS-4	Geostationary Meteorological Satellite	Mission complete	1989-09-06 00:00:00	1995-06-01 00:00:00	Meteorology.	Geostationary		N/A		36000 km	-140 deg		
574	GISAT	Geo Imaging Satellite	N/A	2010-04-01 00:00:00	2015-01-01 00:00:00	High repetivity sensor on geo-stationary platform .	Geostationary		N/A					
376	GOCE	Gravity Field and Steady-State Ocean Circulation Explorer	Mission complete	2009-03-17 00:00:00	2013-10-21 00:00:00	Research in steady-state ocean circulation, physics of Earth's interior and levelling systems (based on GPS). Will also provide unique data set required to formulate global and regional models of the Earth's gravity field and geoid.	Sun-synchronous	90 minutes	Ascending	96.7 deg	270 km		18:00	61 days
498	GMS-3	Geostationary Meteorological Satellite	Mission complete	1983-09-06 00:00:00	1990-06-01 00:00:00	Meteorology.	Geostationary		N/A		36000 km	-140 deg		
244	GMS-5	Geostationary Meteorogical Satellite - 5	Mission complete	1995-03-18 00:00:00	2005-06-01 00:00:00	Meteorology.	Geostationary		N/A		36000 km	-140 deg		
447	Glory	Glory	N/A	2010-11-22 00:00:00	2010-11-22 00:00:00	Mission failed to reach orbit due to LV separation problem.	Sun-synchronous	98.8 minutes	Descending	98.2 deg	705 km		10:33	16 days
822	GF-4	Gaofen-4	Currently being flown	2015-12-29 00:00:00	2023-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Geostationary			0 deg	36000 km			
669	GEO-KOMPSAT-2B	Geostationary Korea Multi-Purpose Satellite-2B	Approved	2019-03-01 00:00:00	2029-03-01 00:00:00	Korea's geostationary oceanographic and environmental satellite.	Geostationary							
773	GF-1	Gaofen-1	Currently being flown	2013-04-26 00:00:00	2018-04-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	97.466 minutes	Descending	97.9 deg	644 km		10:30	41 days
774	GF-2	Gaofen-2	Currently being flown	2014-08-19 00:00:00	2019-08-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	97.196 minutes	Descending	97.9 deg	631 km		10:30	69 days
766	GEDI-on-ISS	International Space Station/Global Ecosystem Dynamics Investigation (GEDI) Lidar	Planned	2018-01-01 00:00:00	2020-01-01 00:00:00	This project will use a laser-based system to study a range of climates, including the observation of the forest canopy structure over the tropics, and the tundra in high northern latitudes.This data will help scientists better understand the changes in natural carbon storage within the carbon cycle from both human-influenced activities and natural climate variations.	Inclined, non-sun-synchronous	93 minutes	Ascending	51.6 deg	407 km			
525	GEO-KOMPSAT-2A	Geostationary Korea Multi-Purpose Satellite-2A	Approved	2018-05-01 00:00:00	2028-05-01 00:00:00	Korea's geostationary meteorological satellite series.	Geostationary		N/A		36000 km	128.2 deg		
647	GEO-CAPE	Geostationary Coastal and Air Pollution Events	Considered	2023-01-01 00:00:00	2026-01-01 00:00:00	Phase-2 DS Mission, launch order unknown, 3-year nominal mission. Atmospheric gas columns for air quality forecasts; ocean colour for coastal ecosystem health and climate emissions.	Geostationary		N/A		42000 km	80 deg		1 days
543	GCOM-W3	Global Change Observation Mission - Water3	Considered	\N	\N	Understanding of water circulation mechanism.	Sun-synchronous	98 minutes	Ascending	98.2 deg	700 km		13:30	
693	GISAT	GEO HR IMAGER	Approved	2017-12-01 00:00:00	2026-12-01 00:00:00	Crop assessment, vegetation dynamics, drought assessment; quick monitoring of disasters, natural hazard and calamities, episodic events and short term events, oceanographic applications.	Geostationary		N/A		36000 km			
542	GCOM-W2	Global Change Observation Mission - Water2	Considered	\N	\N	Understanding of water circulation mechanism.	Sun-synchronous	98 minutes	Ascending	98.2 deg	700 km		13:30	
541	GCOM-C3	Global Change Observation Mission-Climate3	Considered	2024-01-01 00:00:00	2029-01-01 00:00:00	Understanding of climate change mechanism.	Sun-synchronous	101 minutes	Descending	98.6 deg	798 km		10:30	3 days
459	GCOM-W	Global Change Observation Mission - Water	Currently being flown	2012-05-18 00:00:00	2017-05-01 00:00:00	Understanding of water circulation mechanism.	Sun-synchronous	98 minutes	Ascending	98.2 deg	700 km		13:30	
540	GCOM-C2	Global Change Observation Mission-Climate2	Considered	2020-01-01 00:00:00	2025-01-01 00:00:00	Understanding of climate change mechanism.	Sun-synchronous	101 minutes	Descending	98.6 deg	798 km		10:30	3 days
653	GACM	Global Atmospheric Composition Mission	Considered	2030-01-01 00:00:00	2033-01-01 00:00:00	Phase-3 DS Mission, launch order unknown, 3-year nominal mission. Ozone and related gases for intercontinental air quality and stratospheric ozone layer prediction.	Sun-synchronous							
360	GCOM-C	Global Change Observation Mission-Climate	Approved	2016-12-01 00:00:00	2021-12-01 00:00:00	Understanding of climate change mechanism.	Sun-synchronous	101 minutes	Descending	98.6 deg	798 km		10:30	3 days
825	FY-4G	FY-4G Geostationary Meteorological Satellite	Planned	2033-01-01 00:00:00	2040-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
535	FY-4D	FY-4D Geostationary Meteorological Satellite	Planned	2023-01-01 00:00:00	2030-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
534	FY-4C	FY-4C Geostationary Meteorological Satellite	Planned	2020-01-01 00:00:00	2027-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
536	FY-4E	FY-4E Geostationary Meteorological Satellite	Planned	2027-01-01 00:00:00	2034-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
532	FY-4A	FY-4A Geostationary Meteorological Satellite	Approved	2016-12-01 00:00:00	2023-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
533	FY-4B	FY-4B Geostationary Meteorological Satellite	Planned	2018-01-01 00:00:00	2025-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
539	FY-4 M/C	FY-4C Microwave Geostationary Meteorological Satellite	N/A	2022-12-31 00:00:00	2027-12-31 00:00:00	Meteorology and environmental monitoring data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
538	FY-4 M/B	FY-4B Microwave Geostationary Meteorological Satellite	N/A	2018-12-31 00:00:00	2023-12-31 00:00:00	Meteorology and environmental monitoring data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
824	FY-4F	FY-4F Geostationary Meteorological Satellite	Planned	2030-01-01 00:00:00	2037-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
537	FY-4 M/A	FY-4A Microwave Geostationary Meteorological Satellite	N/A	2015-12-31 00:00:00	2020-12-31 00:00:00	Meteorology and environmental monitoring data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
800	FY-3RM	FY-3 Rainfall Mission	Considered	2020-01-01 00:00:00	2025-01-01 00:00:00	Raifall measurement.								
371	FY-3F	FY-3F Polar-orbiting Meteorological Satellite	Planned	2019-01-01 00:00:00	2022-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Sun-synchronous	101 minutes	Ascending	98.753 deg	830 km		14:00	
370	FY-3E	FY-3E Polar-orbiting Meteorological Satellite	Planned	2017-01-01 00:00:00	2020-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Sun-synchronous	101 minutes	Descending	98.753 deg	830 km		10:00	
369	FY-3D	FY-3D Polar-orbiting Meteorological Satellite	Approved	2016-12-01 00:00:00	2018-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Sun-synchronous	101 minutes	Ascending	98.753 deg	830 km		14:00	
823	FY-3H	FY-3H Polar-orbiting Meteorological Satellite	Planned	2021-01-01 00:00:00	2028-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Sun-synchronous		Descending				10:00	
372	FY-3G	FY-3G Polar-orbiting Meteorological Satellite	Considered	2021-01-01 00:00:00	2024-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Sun-synchronous		Descending				10:00	
368	FY-3C	FY-3C Polar-orbiting Meteorological Satellite	Currently being flown	2013-09-23 00:00:00	2018-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution. (Operational follow-on to FY-3B). FY-3C suffered a problem on May 30th 2015 and has recovered gradually over time. At present, 10 of 12 onboard instruments are back in operation.	Sun-synchronous	101 minutes	Descending	98.753 deg	830 km		10:00	
366	FY-3A	FY-3A Polar-orbiting Meteorological Satellite	Currently being flown	2008-05-27 00:00:00	2017-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Sun-synchronous	101 minutes	Descending	98.753 deg	830 km		10:10	
367	FY-3B	FY-3B Polar-orbiting Meteorological Satellite	Currently being flown	2010-11-05 00:00:00	2017-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution. (Experimental pre-cursor to FY-3C).	Sun-synchronous	101 minutes	Ascending	98.753 deg	830 km		14:00	
365	FY-2E	FY-2E Geostationary Meteorological Satellite	Currently being flown	2008-12-23 00:00:00	2017-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
700	FY-2G	FY-2G Geostationary Meteorological Satellite	Currently being flown	2014-12-31 00:00:00	2017-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km			
364	FY-2D	FY-2D Geostationary Meteorological Satellite	Currently being flown	2006-12-08 00:00:00	2017-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km	-86.5 deg		
531	FY-2F	FY-2F Geostationary Meteorological Satellite	Currently being flown	2012-01-13 00:00:00	2017-12-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km			
701	FY-2H	FY-2H Geostationary Meteorological Satellite	Planned	2017-01-01 00:00:00	2020-01-01 00:00:00	Meteorology and environmental monitoring; data collection and redistribution.	Geostationary		N/A		36000 km			
312	FY-2A	FY-2A Geostationary Meteorological Satellite	Mission complete	1997-06-10 00:00:00	2000-06-10 00:00:00	Meteorology and environmental monitoring Data collection and redistribution.	Geostationary		N/A		36000 km	-86 deg		
311	FY-2B	FY-2B Geostationary Meteorological Satellite	Mission complete	2000-06-25 00:00:00	2003-06-30 00:00:00	Meteorology and environmental monitoring Data collection and redistribution.	Geostationary		N/A		36000 km	-105 deg		
310	FY-1D	FY-1D Polar-orbiting Meteorological Satellite	Mission complete	2002-05-15 00:00:00	2012-06-01 00:00:00	Meteorology, environmental monitoring.	Sun-synchronous	102.3 minutes	Descending	98.8 deg	863 km		9:00	
309	FY-1C	FY-1C Polar-orbiting Meteorological Satellite	Mission complete	1999-05-10 00:00:00	2001-05-10 00:00:00	Meteorology, Environmental monitoring.	Sun-synchronous	102.3 minutes	Descending	98.85 deg	863 km		8:50	10.61 days
15	FY-1B	FY-1B Polar-orbiting Meteorological Satellite	Mission complete	1990-01-01 00:00:00	1991-01-01 00:00:00		Sun-synchronous		TBD		901 km			
399	FOURIER	\N	Cancelled	2006-01-01 00:00:00	1900-01-01 00:00:00	Atmospheric physics, radiative properties, climate change.	Sun-synchronous		TBD					
14	FY-1A	FY-1A Polar-orbiting Meteorological Satellite	Mission complete	1988-01-01 00:00:00	1988-02-01 00:00:00		Sun-synchronous		TBD		901 km			
726	Free Flyer-2	JPSS Free Flyer-2	N/A	2021-08-01 00:00:00	2026-07-01 00:00:00	Spacecraft carrying TSIS and user services payloads not accomodated on JPSS 1 or 2	Sun-synchronous		Ascending					
398	ESPERIA	Earthquake investigations by Satellite and Physics of the Environment Related to the Ionosphere and Atmosphere	Cancelled	2006-01-01 00:00:00	1900-01-01 00:00:00	Study of perturbations in the atmosphere and ionosphere caused by electromagnetic waves, shorterm earthquake prediction.	Sun-synchronous		TBD					
836	FLEX	Fluorescence Explorer	Planned	2022-01-01 00:00:00	2025-01-01 00:00:00	Mapping vegetation fluorescence to quantify photosynthetic activity.	Sun-synchronous		Ascending		815 km			
221	ERS-2	European Remote Sensing satellite - 2	Mission complete	1995-04-21 00:00:00	2011-07-04 00:00:00	Earth resources plus physical oceanography, ice and snow, land surface, meteorology, geodesy/gravity, environmental monitoring, atmospheric chemistry.	Sun-synchronous	100.5 minutes	Descending	98.52 deg	782 km		10:30	35 days
386	ESA Future Missions	ESA Future Missions	Cancelled	2008-01-01 00:00:00	2018-01-01 00:00:00	Physical Oceanogreaphy, land surface, ice and snow, atmospheric dynamics/water and energy cycles.	TBD		TBD					
216	ERBS	Earth Radiation Budget Satellite	Mission complete	1984-10-05 00:00:00	2005-10-14 00:00:00	Earth radiation budget measurements.	Inclined, non-sun-synchronous	96.3 minutes	N/A	57 deg	585 km			
322	FedSat	Federation Satellite	Mission complete	2002-12-14 00:00:00	2005-12-14 00:00:00	Communications, data relay, near Earth environment, upper atmospheric physics, meteorology.	Sun-synchronous	101 minutes	Descending	98.6 deg	803 km		10:30	
220	ERS-1	European Remote Sensing satellite - 1	Mission complete	1991-07-17 00:00:00	2000-03-07 00:00:00	Earth resources plus physical oceanography, ice and snow, land surface, meteorology, geodesy/gravity, environmental monitoring, atmospheric chemistry.	Sun-synchronous	100.5 minutes	Descending	98.52 deg	782 km		10:30	35 days
2	Envisat	Environmental Satellite	Mission complete	2002-03-01 00:00:00	2012-04-08 00:00:00	Physical oceanography, land surface, ice and snow, atmospheric chemistry, atmospheric dynamics/water and energy cycles.	Sun-synchronous	100.5 minutes	Descending	98.52 deg	782 km		10:30	35 days
695	Environsat-2	Environmental Satellite - 2	N/A	2018-10-01 00:00:00	2022-10-01 00:00:00	Monitoring of greenhouse gases, aerosols and other atmospheric trace gases which are responsible for global warming.								
730	ePOP on CASSIOPE	Enhanced Polar Outflow Probe on the CAScade, Smallsat and IOnospheric Polar Explorer	Currently being flown	2013-09-29 00:00:00	2017-05-01 00:00:00	The ePOP probe observes the Earth’s ionosphere, where space meets the upper atmosphere. The instruments are used in conjunction with other satellite-based and ground-based instruments to analyze radio wave propagation in the ionosphere, measure the densities of ionized particles, and observe the aurora from space, all as they respond to space weather.	Inclined, non-sun-synchronous	101 minutes	N/A	81 deg	350 km			
694	Environsat-1	Environmental Satellite - 1	N/A	2015-10-01 00:00:00	2019-10-01 00:00:00	Monitoring of greenhouse gases, aerosols and other atmospheric trace gases which are responsible for global warming.								
600	EnMAP	Environmental Mapping & Analysis Program	Approved	2019-07-01 00:00:00	2024-07-01 00:00:00	Hyperspectral imaging, land surface, geological and environmental investigation.	Sun-synchronous	97.5 minutes	Descending		650 km		11:00	21 days
530	Elektro-L N2	Geostationary Operational Meteorological Satellite	Currently being flown	2015-12-11 00:00:00	2025-12-01 00:00:00	Hydrometeorology, heliogeophysics, climatology, cloud information.	Geostationary		N/A		36000 km	-76 deg		
765	ECOSTRESS-on-ISS	International Space Station/ECOsystem Spaceborne Thermal Radiometer Experiment on Space Station (ECOSTRESS)	Planned	2018-01-01 00:00:00	2019-01-01 00:00:00	This project will use a high-resolution thermal infrared radiometer to measure plant evapotranspiration, the loss of water from growing leaves and evaporation from the soil. These data will reveal how ecosystems change with climate and provide a critical link between the water cycle and effectiveness of plant growth, both natural and agricultural.	Inclined, non-sun-synchronous	93 minutes	Ascending	51.6 deg	407 km			
523	EARTHPROBE	EARTHPROBE	N/A	\N	\N	Meteorology, climatology.								
611	Elektro-L N3	Geostationary Operational Meteorological Satellite	Approved	2017-12-01 00:00:00	2027-12-01 00:00:00	Hydrometeorology, heliogeophysics, climatology, cloud information.	Geostationary		N/A		36000 km			
152	Elektro-L N1	Geostationary Operational Meteorological Satellite	Currently being flown	2011-01-20 00:00:00	2021-01-01 00:00:00	Hydrometeorology, heliogeophysics, climatology, cloud information.	Geostationary		N/A		36000 km	14.5 deg		
491	EarthCARE	ESA's cloud & aerosol	N/A	2012-01-01 00:00:00	2015-01-01 00:00:00	Meteorology, climatology.								
580	EarthCARE	EarthCARE	Approved	2018-12-01 00:00:00	2021-12-01 00:00:00	To Improve the understanding of atmospheric cloud–aerosol interactions and of the Earth's radiative balance towards enhancing climate and numerical weather prediction models. The 2 active and 2 passive instruments of EarthCARE make unique data product synergies possible.	Sun-synchronous		Descending	97 deg	393 km		14:00	25 days
350	DSCOVR	Deep Space Climate Observatory	Currently being flown	2015-02-11 00:00:00	2020-02-01 00:00:00	Measure a combination of solar phenomena and earth climate measurements.  Provides 15 min warning for solar storms (CME) events. This mission is positioned at the Earth-Sun L-1 point.	Earth-Sun L-1	259200 minutes	N/A				Every 3 months.	1 days
301	DMSP F-9	Defense Meteorological Satellite Program F-9	Mission complete	1988-02-01 00:00:00	1991-02-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	TBD	98.7 deg	830 km		9:30	
300	DMSP F-8	Defense Meteorological Satellite Program F-8	Mission complete	1987-06-01 00:00:00	2004-09-30 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	Descending	98.7 deg	830 km		5:55	
500	DMSP F-7	Defense Meteorological Satellite Program F-7	Mission complete	1983-11-18 00:00:00	2002-09-30 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	Descending	98.7 deg	830 km		5:55	
409	DMSP F-18	Defense Meteorological Satellite Program F-18	Currently being flown	2009-10-18 00:00:00	2016-12-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide cloud cover data on a daily basis.	Sun-synchronous	101 minutes	Ascending	98.7 deg	850 km		17:31	
381	DMSP F-16	Defense Meteorological Satellite Program F-16	Currently being flown	2003-10-18 00:00:00	2016-12-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide cloud cover data on a daily basis.	Sun-synchronous	101 minutes	Ascending	98.9 deg	833 km		21:32	
411	DMSP F-20	Defense Meteorological Satellite Program F-20	Considered	2020-01-01 00:00:00	2025-01-01 00:00:00	Launch date is to be determined.  Spacecraft is on call-up. The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide cloud cover data on a daily basis.	Sun-synchronous	101 minutes	Ascending	98.7 deg	850 km		17:30	
408	DMSP F-17	Defense Meteorological Satellite Program F-17	Currently being flown	2006-11-04 00:00:00	2016-12-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide cloud cover data on a daily basis.	Sun-synchronous	101 minutes	Ascending	98.7 deg	850 km		17:31	
345	DMSP F-15	Defense Meteorological Satellite Program F-15	Currently being flown	1999-12-12 00:00:00	2016-12-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	Ascending	98.9 deg	833 km		20:29	
410	DMSP F-19	Defense Meteorological Satellite Program F-19	Mission complete	2014-04-03 00:00:00	2016-02-11 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide cloud cover data on a daily basis.	Sun-synchronous	101 minutes	Ascending	98.7 deg	833 km		17:31	
305	DMSP F-13	Defense Meteorological Satellite Program F-13	Mission complete	1997-03-24 00:00:00	2008-05-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	Ascending	98.7 deg	833 km		18:12	
567	DMSAR	Disaster Management SAR	N/A	2011-07-01 00:00:00	2016-07-01 00:00:00	For disaster management purpose, mainly to overcome the problems of cloud during observation, most useful for flood and cyclone.	Geostationary		N/A		36000 km			
306	DMSP F-14	Defense Meteorological Satellite Program F-14	Currently being flown	1997-04-04 00:00:00	2016-12-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. Tactical use only; on-board tape recorders failed; special sensor microwave instrument no longer operational; no longer provides global data.	Sun-synchronous	101 minutes	Ascending	98.7 deg	833 km		20:29	
304	DMSP F-12	Defense Meteorological Satellite Program F-12	Mission complete	1994-08-29 00:00:00	2004-09-30 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis.	Sun-synchronous	101 minutes	Ascending	98.7 deg	833 km		19:29	
302	DMSP F-10	Defense Meteorological Satellite Program F-10	Mission complete	1990-12-01 00:00:00	1993-12-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	TBD	98.7 deg	830 km		10:50	
303	DMSP F-11	Defense Meteorological Satellite Program F-11	Mission complete	1991-11-01 00:00:00	1991-11-01 00:00:00	The long-term meteorological programme of the US Department of Defense (DoD) - with the objective to collect and disseminate worldwide atmospheric, oceanographic, solar-geophyscial, and cloud cover data on a daily basis. (Primary operational satellite).	Sun-synchronous	101 minutes	Ascending	98.7 deg	850 km		19:30	
776	DESIS-on-ISS	DLR Earth Sensing Imaging Spectrometer for MUSES	Planned	2017-01-01 00:00:00	2019-01-01 00:00:00	DESIS detects changes in the land surface, oceans and atmosphere; it will contribute to the development of effective measures to protect the environment and climate and allows scientists to detect changes in ecosystems and to make statements on the condition of forests and agricultural land. Among other things, its purpose is to secure and improve the global cultivation of food.	Inclined, non-sun-synchronous	93 minutes	Ascending	51.6 deg	407 km			
423	Diademe 1&2	\N	Currently being flown	1967-02-15 00:00:00	2050-12-01 00:00:00	Geodetic measurements using satellite laser ranging.	Inclined, non-sun-synchronous	108 minutes	TBD	40 deg	1200 km			
414	DEMETER	Detection of Electro-Magnetic Emissions Transmitted from Earthquake Regions	Mission complete	2004-06-29 00:00:00	2010-12-10 00:00:00	Micro-satellite to study; ionospheric disturbances related to seismic activity, ionospheric disturbances related to human activity, pre and post-seismic effects in the ionosphere, global information on the Earth's electromagnetic environment.	Sun-synchronous		TBD		800 km		10:30	
635	CSG-2	COSMO-SkyMed di Seconda Generazione - 2	Approved	2019-03-01 00:00:00	2026-03-01 00:00:00	Environmental monitoring, surveillance and risk management applications, environmental resources management, maritime management, earth topographic mapping, law enforcement, informative / science applications.	Sun-synchronous	97.1 minutes	Ascending	97.8 deg	620 km		6:00	16 days
529	CryoSat-2	CryoSat-2 (Earth Explorer Opportunity Mission)	Currently being flown	2010-04-08 00:00:00	2021-12-01 00:00:00	To determine fluctuations in the mass of the Earth’s major land and marine ice fields.	Inclined, non-sun-synchronous	100 minutes	N/A	92 deg	717 km		0.25 degree nodal regression per day	369 days
740	CYGNSS	Cyclone Global Navigation Satellite System	Approved	2016-12-01 00:00:00	2019-02-01 00:00:00	To understand the coupling between ocean surface properties, moist atmospheric thermodynamics, radiation and convective dynamics in the inner core of a Tropical Cyclone (TC)	Inclined, non-sun-synchronous	94 minutes	TBD	35 deg	510 km			
378	CryoSat	CryoSat (Earth Explorer Opportunity Mission)	Mission complete	2005-10-08 00:00:00	2005-10-08 00:00:00	A radar altimetry mission to determine variations in the thickness of the Earth’s continental ice sheets and marine ice cover. Primary objective is to test the prediction of thinning arctic ice due to global warming.	Inclined, non-sun-synchronous		TBD	92 deg	717 km			369 days
528	COSMO-SkyMed 4	COnstellation of small Satellites for Mediterranean basin Observation - 4	Currently being flown	2010-11-06 00:00:00	2017-12-01 00:00:00	Environmental monitoring, surveillance and risk management applications, environmental resources management, maritime management, earth topographic mapping, law enforcement, informative / science applications.	Sun-synchronous	97.1 minutes	Ascending	97.8 deg	620 km		6:00	16 days
634	CSG-1	COSMO-SkyMed di Seconda Generazione - 1	Approved	2018-03-01 00:00:00	2025-03-01 00:00:00	Environmental monitoring, surveillance and risk management applications, environmental resources management, maritime management, earth topographic mapping, law enforcement, informative / science applications.	Sun-synchronous	97.1 minutes	Ascending	97.8 deg	620 km		6:00	16 days
527	COSMO-SkyMed 3	COnstellation of small Satellites for Mediterranean basin Observation - 3	Currently being flown	2008-10-25 00:00:00	2017-12-01 00:00:00	Environmental monitoring, surveillance and risk management applications, environmental resources management, maritime management, earth topographic mapping, law enforcement, informative / science applications.	Sun-synchronous	97.1 minutes	Ascending	97.8 deg	620 km		6:00	16 days
395	COSMO-SkyMed 1	COnstellation of small Satellites for Mediterranean basin Observation - 1	Currently being flown	2007-06-08 00:00:00	2017-12-01 00:00:00	Environmental monitoring, surveillance and risk management applications, environmental resources management, maritime management, earth topographic mapping, law enforcement, informative / science applications.	Sun-synchronous	97.1 minutes	Ascending	97.8 deg	620 km		6:00	16 days
526	COSMO-SkyMed 2	COnstellation of small Satellites for Mediterranean basin Observation - 2	Currently being flown	2007-12-09 00:00:00	2017-12-01 00:00:00	Environmental monitoring, surveillance and risk management applications, environmental resources management, maritime management, earth topographic mapping, law enforcement, informative / science applications.	Sun-synchronous	97.1 minutes	Ascending	97.8 deg	620 km		6:00	16 days
786	COSMIC-2B (Polar)	COSMIC-2B (Polar)	Planned	2018-01-01 00:00:00	2023-01-01 00:00:00	This is a radio occultation mission supporting meteorology and ionosphere & climate measurements. The 12-satellite COSMIC-2A/2B constellation (6 equatorial and 6 polar) will produce over 4 times the daily total of occultation events as COSMIC-1 (3000 versus 12,000). This provides the capability to reconstruct the 3D ionospheric electron density structures for ionospheric space weather monitoring within a dramatically short data accumulation period. TGRS will receive signals from GPS, Galileo, and Glonass. COSMIC-2B will be a ride-share mission; the listed orbital parameters are desired and TBC.			TBD	72 deg	720 km			
771	COSMIC-2A (Equatorial)	COSMIC-2A (Equatorial)	Planned	2017-01-01 00:00:00	2022-01-01 00:00:00	This is a radio occultation mission supporting meteorology and ionosphere & climate measurements. The 12-satellite COSMIC-2A/2B constellation (6 equatorial and 6 polar) will produce over 4 times the daily total of occultation events as COSMIC-1 (3000 versus 12,000). This provides the capability to reconstruct the 3D ionospheric electron density structures for ionospheric space weather monitoring within a dramatically short data accumulation period. TGRS will receive signals from GPS, Galileo, and Glonass.			Ascending	24 deg	520 km			
486	COSMIC-1 FM5	COSMIC-1 FM5	Currently being flown	2006-04-14 00:00:00	2018-12-01 00:00:00	Meteorology, ionosphere and climate.	Inclined, non-sun-synchronous	100 minutes	Ascending	72 deg	800 km			
485	COSMIC-1 FM4	COSMIC-1 FM4	Currently being flown	2006-04-14 00:00:00	2018-12-01 00:00:00	Meteorology, ionosphere and climate. The FM-4 satellite is currently in a severely degraded state.	Inclined, non-sun-synchronous	100 minutes	Ascending	72 deg	800 km			
484	COSMIC-1 FM3	COSMIC-1 FM3	Mission complete	2006-04-14 00:00:00	2010-07-05 00:00:00	Meteorology, ionosphere and climate.	Inclined, non-sun-synchronous	100 minutes	Ascending	72 deg	711 km			
483	COSMIC-1 FM2	COSMIC-1 FM2	Currently being flown	2006-04-14 00:00:00	2018-12-01 00:00:00	Meteorology, ionosphere and climate.	Inclined, non-sun-synchronous	100 minutes	Ascending	72 deg	800 km			
482	COSMIC-1 FM1	COSMIC-1 FM1	Currently being flown	2006-04-14 00:00:00	2019-09-01 00:00:00	Meteorology, ionosphere and climate.	Inclined, non-sun-synchronous	100 minutes	Ascending	72 deg	800 km			
487	COSMIC-1 FM6	COSMIC-1 FM6	Currently being flown	2006-04-14 00:00:00	2018-12-01 00:00:00	Meteorology, ionosphere and climate.	Inclined, non-sun-synchronous	100 minutes	Ascending	72 deg	800 km			
524	COMS	Communication, Oceanographic, Meteorological Satellite	Currently being flown	2010-06-26 00:00:00	2018-03-01 00:00:00	Korea's geostationary meteorological satellite series.	Geostationary		N/A		36000 km	128.2 deg		
347	CloudSat	CloudSat	Currently being flown	2006-04-28 00:00:00	2017-09-01 00:00:00	22-month nominal mission life, currently in extended operations. CloudSat uses advanced radar to "slice" through clouds to see their vertical structure, providing a completely new observational capability from space. First use of active 94 GHz radar from space to study clouds on global basis. Flies in formation with Aqua and CALIPSO in the A-Train Constellation.	Sun-synchronous	98.8 minutes	Ascending	98.2 deg	705 km		13:30	
689	CLARREO-3	Climate Absolute Radiance and Refractivity Observatory	Cancelled	2020-10-30 00:00:00	2023-10-30 00:00:00	Phase-1 DS Mission (follows SMAP and ICESAT-2), 3-year nominal mission. Solar radiation: spectrally resolved forcing and response of the climate system.	Inclined, non-sun-synchronous			90 deg	650 km			365 days
690	CLARREO-4	Climate Absolute Radiance and Refractivity Observatory	Cancelled	2020-10-30 00:00:00	2023-10-30 00:00:00	Phase-1 DS Mission (follows SMAP and ICESAT-2), 3-year nominal mission. Solar radiation: spectrally resolved forcing and response of the climate system.	Inclined, non-sun-synchronous			90 deg	650 km			365 days
688	CLARREO-2	Climate Absolute Radiance and Refractivity Observatory	Cancelled	2019-10-30 00:00:00	2022-10-30 00:00:00	Phase-1 DS Mission (follows SMAP and ICESAT-2), 3-year nominal mission. Solar radiation: spectrally resolved forcing and response of the climate system.	Inclined, non-sun-synchronous			90 deg	650 km			365 days
643	CLARREO-1	Climate Absolute Radiance and Refractivity Observatory	Cancelled	2017-10-30 00:00:00	2020-10-30 00:00:00	Phase-1 DS Mission (follows SMAP and ICESAT-2), 3-year nominal mission. Solar radiation: spectrally resolved forcing and response of the climate system.	Inclined, non-sun-synchronous			90 deg	650 km			365 days
778	CLARREO Pathfinder-on-ISS	International Space Station/Climate Absolute Radiance & Reflectivity Observatory Pathfinder	Planned	2020-01-01 00:00:00	2021-01-01 00:00:00	1 year nominal mission. The goal of the Climate Absolute Radiance and Refractivity Observatory (CLARREO) mission is to improve our understanding of climate change by providing high accuracy measurements of the change in key climate variables over decadal timescales. CLARREO Pathfinder is a technical demonstration on the ISS and a major step in reducing the cost and technical risk for these high accuracy measurements.	Inclined, non-sun-synchronous	90 minutes	Ascending	51 deg	425 km			
723	CFOSAT	Chinese-French Oceanic SATellite	Approved	2018-12-01 00:00:00	2021-12-01 00:00:00	The primary objective of CFOSAT is to monitor at the global scale the wind and waves at the ocean surface.	Sun-synchronous	94.7 minutes	Descending	97.5 deg	519 km		7am	
256	CHAMP	Challenging Mini-Satellite Payload for Geophysical Research and Application	Mission complete	2000-07-15 00:00:00	2010-09-19 00:00:00	Gravity field, precise geoid, magnetic field, atmospheric physics.	Inclined, non-sun-synchronous		N/A	87 deg	315 km			
725	CDARS	Cooperative Data and Rescue Services	Considered	2020-01-01 00:00:00	2024-01-01 00:00:00	Maintain three-orbit continuity for the Argos and SARSAT-COSPAS programs.	Sun-synchronous		Ascending					
393	CBERS-4	China Brazil Earth Resources Satellite - 4	Currently being flown	2014-12-06 00:00:00	2017-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	100.3 minutes	Descending	98.5 deg	778 km		10:30	26 days
392	CBERS-3	China Brazil Earth Resources Satellite - 3	N/A	2013-12-10 00:00:00	2013-12-10 00:00:00	Earth resources, environmental monitoring, land surface. Launch failure.	Sun-synchronous	100.3 minutes	Descending	98.5 deg	778 km		10:30	26 days
775	CBERS-4A	China Brazil Earth Resources Satellite - 4	Planned	2018-01-01 00:00:00	2021-01-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous		Descending					
460	CBERS-2B	China Brazil Earth Resources Satellite - 2B	Mission complete	2007-09-19 00:00:00	2010-04-16 00:00:00	Earth resources, environmental monitoring, land surface (joint with INPE).	Sun-synchronous		Descending	98.5 deg	778 km		10:30	26 days
784	CAS500-1	Compact Advanced Satellite 500 -1	Approved	2019-05-01 00:00:00	2023-05-01 00:00:00	Cartography, land use and planning	Sun-synchronous	98.5 minutes	Ascending		528 km			
779	CATS-on-ISS	International Space Station/Cloud-Aerosol Transport System	Currently being flown	2015-01-10 00:00:00	2018-09-01 00:00:00	The Cloud-Aerosol Transport System (CATS) is a lidar remote sensing instrument that will provide range-resolved profile measurements of atmospheric aerosols and clouds from the International Space Station (ISS). CATS is intended to operate on-orbit for at least six months, and up to three years.	Inclined, non-sun-synchronous	90 minutes		51 deg	425 km			
565	CARTOSAT-3	Cartography Satellite - 3	Planned	2018-01-01 00:00:00	2023-01-01 00:00:00	Suitable for cadastral and infrastructure mapping and analysis.	Sun-synchronous		Descending	97.9 deg	450 km		10:30	
267	CBERS-2	China Brazil Earth Resources Satellite - 2	Mission complete	2003-10-21 00:00:00	2009-01-10 00:00:00	Earth resources, environmental monitoring, land surface (joint with INPE).	Sun-synchronous	100.26 minutes	Descending	98.5 deg	778 km		10:50	26 days
704	CARTOSAT-2C	Cartography Satellite - 2C	N/A	2014-07-31 00:00:00	2018-07-31 00:00:00	High precision large-scale cartographic mapping and thematic applications with MX data at 1:4000 scales.	Sun-synchronous	97.4 minutes	Descending	97.87 deg	635 km		9:30	5 days
672	CARTOSAT-2B	Cartography Satellite - 2B	Currently being flown	2010-07-12 00:00:00	2017-07-01 00:00:00	High precision large-scale cartographic mapping of 1:10000 scale and thematic applications (with merged XS data) at 1:4000 scales.	Sun-synchronous	97.4 minutes	Descending	97.87 deg	635 km		9:30	5 days
374	CARTOSAT-2	Cartography Satellite - 2	Currently being flown	2007-01-10 00:00:00	2016-12-01 00:00:00	High precision large-scale cartographic mapping of 1:10000 scale and thematic applications (with merged XS data) at 1:4000 scales.	Sun-synchronous	97.4 minutes	Descending	97.87 deg	635 km		9:30	5 days
697	CARTOSAT-1B	Cartosat -1B	N/A	2017-03-01 00:00:00	2022-03-01 00:00:00	Ensure the continuity of high resolution imaging capability with multispectral capability, stereo imaging and hyperspectral imaging.	Sun-synchronous							
275	CARTOSAT-1	Cartography Satellite - 1	Currently being flown	2005-05-05 00:00:00	2017-06-01 00:00:00	High precision large-scale cartographic mapping of 1:10000 scale and thematic applications (with merged XS data) at 1:4000 scales.	Sun-synchronous	97 minutes	Descending	97.87 deg	618 km		10:30	5 days
696	CARTOSAT-1A	Cartography Satellite -1A	N/A	2014-08-01 00:00:00	2019-08-01 00:00:00	Ensure the continuity of high resolution imaging capability with multispectral capability, stereo imaging and hyperspectral imaging.	Sun-synchronous							
703	CARTOSAT-2A	Cartography Satellite - 2A	Currently being flown	2008-04-28 00:00:00	2017-04-01 00:00:00	High precision large-scale cartographic mapping of 1:10000 scale and thematic applications (with merged XS data) at 1:4000 scales.	Sun-synchronous	97.4 minutes	Descending	97.87 deg	635 km		9:30	5 days
738	CARTOSAT-2E	Cartography Satellite - 2E	Approved	2017-07-01 00:00:00	2022-07-01 00:00:00	High precision large-scale cartographic mapping and thematic applications with MX data at 1:4000 scales.	Sun-synchronous	97.4 minutes	Descending	97.87 deg	500 km		9:30	5 days
605	BJ-1	Beijing-1 Small Satellite	Mission complete	2005-10-27 00:00:00	2010-10-27 00:00:00	Earth Observation.	Sun-synchronous		TBD	98.17 deg	686 km			
602	AMAZONIA-1	Amazonia 1	Approved	2018-11-01 00:00:00	2020-12-01 00:00:00	Earth resources, environmental monitoring, land surface.	Sun-synchronous	99.9 minutes	Descending	98.4 deg	752 km		10:30	26 days
630	ALOS-3	Advanced Land Observing Satellite-3	N/A	2015-12-31 00:00:00	2020-12-31 00:00:00	Cartography, digital terrain models, environmental monitoring, disaster monitoring, civil planning, agriculture and forestry, Earth resources, land surface.	Sun-synchronous		Descending		618 km		10:30	60 days
787	BJ-2	Beijing-2 Constellation	Currently being flown	2015-07-11 00:00:00	2022-07-01 00:00:00	High-resolution domestic mapping. Operational monitoring applications including urban planning and intelligent management. Constellation of three satellites spaced 120 degrees apart.	Sun-synchronous				651 km			
629	ALOS-2	Advanced Land Observing Satellite-2	Currently being flown	2014-05-24 00:00:00	2019-05-01 00:00:00	Environmental monitoring, disaster monitoring, civil planning, agriculture and forestry, Earth resources, land surface.	Sun-synchronous	100 minutes	Descending	97.9 deg	628 km		12:00	14 days
242	ALOS	Advanced Land Observing Satellite	Mission complete	2006-01-24 00:00:00	2011-04-22 00:00:00	Cartography, digital terrain models, environmental monitoring, disaster monitoring, civil planning, agriculture and forestry, Earth resources, land surface.	Sun-synchronous	98.7 minutes	Descending	98.16 deg	692 km		10:30	46 days
422	CALIPSO	Cloud-Aerosol Lidar and Infrared Pathfinder Satellite Observations	Currently being flown	2006-04-28 00:00:00	2017-09-01 00:00:00	3-year nominal mission life, currently in extended operations. Measurements of aerosol and cloud properties for climate predictions, using a 3 channel lidar and passive instruments in formation with Aqua and CloudSat for coincident observations of radiative fluxes and atmospheric state.	Sun-synchronous	98.8 minutes	Ascending	98.2 deg	705 km		13:30	
745	AISSat-3	Automatic Identification System Satellite-3	Approved	2017-10-01 00:00:00	2021-01-01 00:00:00	Extend performance and access to AIS (Automatic Identification System) signals beyond the land-based AIS system operated by the Norwegian Coastal Administration today. Observe ship traffic in the High North.	Sun-synchronous		Descending				TBD	
377	ADM-Aeolus	Atmospheric Dynamics Mission (Earth Explorer Core Mission)	Approved	2017-07-01 00:00:00	2021-07-01 00:00:00	Will provide wind profile measurements for global 3D wind field products used for study of atmospheric dynamics, including global transport of energy, water, aerosols, and chemicals.	Sun-synchronous	92.5 minutes	Ascending	97.01 deg	405 km		18:00	7 days
633	AISSat-1	Automatic Identification System Satellite-1	Currently being flown	2010-07-12 00:00:00	2019-12-01 00:00:00	Demonstrate and extend access to AIS (Automatic Identification System) signals beyond the land-based AIS system operated by the Norwegian Coastal Administration today. Observe ship traffic in the High North.	Sun-synchronous	97.4 minutes	Descending	97.71 deg	614 km		9:30	
241	ADEOS-II	Advanced Earth Observing Satellite - II	Mission complete	2002-11-01 00:00:00	2003-10-24 00:00:00	An earth observation satellite observing the changes in water on the earth, biological systems, and the ozone layer.	Sun-synchronous	101 minutes	Descending	98.6 deg	803 km		10:30	4 days
240	ADEOS	Advanced Earth Observing Satellite	Mission complete	1996-08-17 00:00:00	1997-06-30 00:00:00	An earth observation satellite acquiring global-scale observation data such as maritime meteorological conditions, atmospheric ozone, and gases that promote global warming.	Sun-synchronous	100.92 minutes	Descending	98.59 deg	797 km		10:50	41 days
714	AISSat-2	Automatic Identification System Satellite-2	Currently being flown	2014-07-08 00:00:00	2017-06-01 00:00:00	Extend access to AIS (Automatic Identification System) signals beyond the land-based AIS system operated by the Norwegian Coastal Administration today. Observe ship traffic in the High North.	Sun-synchronous		Descending		635 km		TBD	
143	ALMAZ-1B	\N	Mission complete	1997-01-01 00:00:00	2000-01-01 00:00:00		Sun-synchronous		TBD		400 km			
648	ACE	Aerosol Clouds and Ecosystem Mission	Considered	2022-01-01 00:00:00	2023-01-01 00:00:00	Phase-2 DS Mission, launch order unknown, 3-year nominal mission. Aerosol and cloud profiles for climate and water cycle; ocean colour for open ocean biogeochemistry.	Sun-synchronous		Ascending	98.2 deg	650 km		13:00	
147	ACRIMSAT	Active Cavity Radiometer Irradiance Monitor	Mission complete	1999-12-20 00:00:00	2013-12-14 00:00:00	5-year nominal mission life, currently being decommissioned due to age-related degradation of batteries.  Operational mission will end in 2014.	Sun-synchronous	98.5 minutes	Descending	97.81 deg	600 km		18:00	1 days
265	CBERS-1	China Brazil Earth Resources Satellite - 1	Mission complete	1999-10-14 00:00:00	2003-10-12 00:00:00	Earth resources, environmental monitoring, land surface (joint with INPE).	Sun-synchronous	100.26 minutes	Descending	98.5 deg	778 km		10:50	26 days
\.


--
-- Name: missions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('missions_id_seq', 1, false);


--
-- Data for Name: operators; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY operators (agency_id, mission_id) FROM stdin;
16	474
16	471
12	654
11	670
8	768
135	560
30	390
4	622
1	622
12	207
149	207
151	207
126	207
2	207
16	751
119	751
16	691
16	812
119	812
12	645
16	713
119	713
12	206
10	206
13	206
130	821
11	717
130	732
130	731
16	472
188	750
188	749
146	749
4	601
137	601
1	402
12	767
14	767
2	426
12	213
30	599
2	582
12	816
12	215
13	215
12	837
2	404
14	514
14	355
12	217
12	210
4	210
12	462
25	475
2	427
11	569
11	435
30	391
12	739
12	204
5	204
32	204
14	734
12	734
30	835
201	835
12	646
4	646
5	646
2	646
30	598
8	468
4	468
5	468
129	559
131	559
123	783
131	488
129	488
12	413
14	413
4	249
4	255
10	45
10	46
4	424
4	253
4	251
4	285
4	247
12	614
5	614
8	379
136	379
4	379
15	318
130	743
3	743
12	346
130	742
3	742
15	123
15	121
8	639
114	639
8	770
4	770
114	770
9	770
12	770
14	770
8	769
4	769
114	769
9	769
12	769
14	769
8	581
114	581
126	581
8	641
114	641
8	640
114	640
8	777
114	777
8	578
114	578
8	814
114	814
8	579
114	579
9	579
8	555
114	555
9	555
8	553
114	553
8	552
114	552
8	554
114	554
9	554
8	577
114	577
8	576
114	576
140	803
8	575
114	575
5	394
8	394
12	394
10	44
10	43
12	652
10	119
11	671
11	764
24	596
4	572
11	572
24	808
24	807
24	809
24	456
1	456
24	457
1	457
24	715
200	715
24	452
1	452
200	716
24	716
12	356
12	687
24	405
1	405
24	453
12	453
24	344
24	343
1	397
24	454
10	454
11	674
11	636
11	712
11	673
16	799
16	797
11	441
16	796
16	798
16	789
16	788
16	760
16	626
119	626
16	140
16	137
16	624
119	624
16	141
3	139
16	139
16	443
16	138
16	136
119	136
16	153
11	817
16	135
16	444
119	444
11	819
11	710
11	439
11	573
11	818
5	586
191	586
190	586
189	586
192	586
37	586
193	586
1	401
11	276
5	585
191	585
190	585
189	585
192	585
37	585
193	585
5	584
191	584
190	584
189	584
192	584
37	584
193	584
135	561
12	782
12	358
30	469
5	243
12	339
5	352
157	352
8	403
1	396
8	737
165	737
9	597
30	597
4	479
16	142
4	478
4	416
5	632
189	632
192	632
136	627
198	627
197	627
12	650
4	415
12	684
5	631
189	631
192	631
1	744
12	419
4	419
9	419
14	419
119	122
119	432
127	480
4	480
17	388
4	388
5	388
8	388
138	388
12	655
12	741
11	820
12	450
11	551
11	278
16	134
16	756
16	754
16	753
11	571
16	755
16	752
16	759
14	383
16	758
16	757
14	361
14	264
14	362
14	270
14	382
21	785
14	97
14	510
14	513
14	512
21	746
14	499
14	511
14	509
14	508
14	113
14	105
14	104
14	106
14	224
14	99
14	223
14	225
14	101
12	380
14	98
12	354
14	507
12	359
12	203
12	642
11	642
134	680
12	353
134	564
12	351
31	549
31	385
142	385
134	563
31	384
142	384
31	307
9	618
114	618
8	618
9	591
9	548
8	548
9	590
9	556
114	556
8	556
9	589
8	589
9	587
8	587
9	588
8	588
144	83
13	83
144	628
13	628
9	841
4	841
8	841
1	679
9	840
4	840
8	840
16	445
9	839
4	839
114	839
30	839
8	839
9	838
4	838
114	838
30	838
8	838
9	557
4	557
114	557
30	557
8	557
9	702
4	702
8	702
9	229
8	229
9	231
4	231
8	231
14	231
9	230
4	230
8	230
14	230
9	259
8	259
9	258
8	258
9	261
4	261
8	261
14	261
8	497
9	228
8	228
9	260
8	260
9	10
8	10
8	496
9	33
8	33
9	451
8	451
8	32
119	623
16	736
119	736
16	612
119	612
16	811
119	811
119	681
16	810
119	810
16	813
119	813
119	682
16	735
119	735
16	477
119	477
16	476
119	476
119	126
16	126
119	127
16	127
119	129
16	129
119	130
16	130
119	125
16	125
119	128
16	128
119	434
16	434
4	375
11	375
4	678
30	678
10	604
188	748
12	815
1	19
188	747
12	780
12	649
53	88
12	663
12	664
12	662
12	772
53	772
53	547
12	547
53	226
12	226
53	349
12	349
1	238
12	238
16	791
16	790
123	761
123	638
148	638
123	637
146	637
123	698
146	698
123	407
146	407
147	407
12	201
1	201
123	406
16	473
16	625
119	625
16	792
16	793
16	610
119	610
16	794
16	795
14	802
9	802
12	802
11	436
14	801
9	801
12	801
144	245
13	245
14	668
9	668
12	668
14	667
9	667
12	667
11	566
12	286
4	286
13	677
12	357
11	257
11	235
11	237
11	274
9	592
14	592
4	592
12	592
11	234
11	277
11	51
11	438
11	493
11	708
11	494
11	233
11	50
11	442
11	707
11	49
11	504
11	47
1	400
11	505
11	506
136	562
8	562
11	570
11	232
12	613
139	834
3	834
12	644
139	615
3	615
11	621
12	449
12	212
139	616
3	616
139	617
3	617
139	832
3	832
139	609
3	609
139	833
3	833
139	720
3	720
139	830
3	830
139	718
3	718
139	719
3	719
139	831
3	831
139	829
3	829
139	828
3	828
139	827
3	827
139	607
3	607
139	608
3	608
139	467
3	467
139	466
3	466
139	826
3	826
30	762
130	465
3	465
130	464
3	464
130	463
3	463
31	729
12	651
12	781
31	728
12	686
164	686
12	337
30	337
8	337
164	337
12	448
13	448
12	429
13	429
10	603
4	603
13	458
41	458
125	458
13	721
41	721
125	721
119	433
16	433
119	133
16	133
14	727
12	727
14	724
12	724
14	222
14	91
14	200
14	522
14	470
12	470
14	546
12	546
14	501
14	521
14	520
14	94
14	519
14	266
14	95
14	96
14	335
14	518
14	495
14	516
14	515
13	81
11	574
8	376
13	498
13	244
12	447
130	822
123	669
158	669
159	669
130	773
130	774
12	766
123	525
161	525
153	525
12	647
13	543
11	693
13	542
13	541
13	459
13	540
12	653
13	360
140	825
20	825
140	535
20	535
140	534
20	534
140	536
20	536
140	532
20	532
140	533
20	533
20	539
140	539
20	538
140	538
140	824
20	824
20	537
140	537
140	800
140	371
20	371
140	370
20	370
140	369
20	369
140	823
20	823
140	372
20	372
140	368
20	368
140	366
20	366
140	367
20	367
140	365
20	365
140	700
20	700
140	364
20	364
140	531
20	531
140	363
20	363
140	701
20	701
20	312
20	311
140	310
20	310
20	309
140	309
3	15
140	15
1	399
3	14
140	14
14	726
12	726
1	398
8	836
8	221
8	386
12	216
6	322
124	322
8	220
8	2
11	695
5	730
11	694
30	600
16	530
119	530
12	765
53	765
8	523
16	611
119	611
16	152
119	152
8	491
8	580
13	580
14	350
12	350
33	350
14	301
14	300
14	500
14	409
33	409
14	381
33	381
14	411
33	411
14	408
33	408
14	345
33	345
14	410
33	410
14	305
11	567
14	306
33	306
14	304
14	302
14	303
30	776
4	423
4	414
1	635
143	635
8	529
12	740
14	740
8	378
1	528
143	528
1	634
143	634
1	527
143	527
1	395
143	395
1	526
143	526
14	786
132	786
14	771
133	771
132	771
14	486
133	486
132	486
14	485
133	485
132	485
14	484
133	484
132	484
14	483
133	483
132	483
14	482
133	482
132	482
14	487
133	487
132	487
123	524
146	524
153	524
158	524
12	347
5	347
35	347
12	689
14	689
12	690
14	690
12	688
14	688
12	643
14	643
12	778
4	723
152	723
30	256
14	725
33	725
130	393
10	393
130	392
10	392
130	775
10	775
130	460
10	460
123	784
194	784
12	779
11	565
130	267
10	267
11	704
11	672
11	374
11	697
11	275
11	696
11	703
11	738
20	605
10	602
13	630
20	787
195	787
13	629
13	242
12	422
4	422
21	745
8	377
21	633
13	241
4	241
12	241
14	241
13	240
4	240
145	240
41	240
12	240
21	714
16	143
12	648
12	147
130	265
10	265
\.


--
-- Data for Name: type_of_instrument; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY type_of_instrument (instrument_id, instrument_type_id) FROM stdin;
184	115
645	115
697	106
730	101
1562	120
988	106
1733	104
1730	108
817	108
391	97
1625	118
459	108
1732	108
1698	108
768	110
138	100
81	108
699	108
642	108
406	108
1680	105
966	108
1681	108
1776	108
14	108
77	108
718	104
78	108
1676	104
1539	105
1539	108
412	108
412	114
257	108
402	108
67	108
684	108
1637	114
404	108
1504	97
1664	108
1742	100
137	98
942	97
855	112
860	112
1602	98
941	97
949	97
1513	97
1697	106
247	108
1546	97
1536	108
679	102
1770	107
764	98
764	116
1715	102
1724	98
246	106
485	108
275	98
906	98
765	117
415	97
763	107
721	104
685	97
414	107
1743	119
327	108
1524	108
719	108
1746	108
1712	108
644	102
1573	97
1506	120
1725	98
923	104
1655	97
959	116
905	97
349	97
1654	108
904	108
1644	118
141	119
875	119
771	97
953	115
569	104
568	104
929	108
329	98
156	102
741	119
908	108
742	119
861	116
636	119
453	98
1556	116
452	98
740	112
634	112
454	98
635	112
451	107
633	119
738	119
254	114
632	119
903	117
1672	97
739	119
1671	97
1558	97
321	108
321	113
369	97
330	98
868	97
761	102
789	98
1529	102
663	97
1587	97
419	102
1763	107
880	119
743	97
760	102
975	102
902	108
769	104
253	106
1632	102
944	104
688	117
781	102
1755	108
874	119
991	116
252	115
1694	108
1693	108
626	102
901	108
901	114
1624	119
1502	119
218	97
1780	119
683	112
683	119
65	119
302	108
1781	119
1518	100
367	97
637	119
952	119
974	119
427	118
1704	119
455	119
1512	118
869	118
752	118
1645	118
1703	118
972	118
345	118
1749	118
864	102
318	97
177	97
1665	106
657	97
1631	118
382	102
826	106
1521	106
731	106
251	106
737	101
249	106
250	106
922	107
704	106
706	106
963	120
790	106
971	106
456	106
1695	106
800	106
703	106
946	106
655	97
189	115
348	97
357	97
659	97
1598	97
656	97
675	98
821	97
821	98
927	98
715	102
1509	100
978	115
1706	119
136	115
766	116
958	98
958	116
1628	98
194	107
899	98
899	116
193	106
89	116
210	102
227	102
783	115
1744	119
716	108
837	108
839	115
1716	102
717	98
1738	118
840	112
840	119
968	107
995	99
1640	119
967	107
912	108
913	108
379	117
245	115
198	107
378	117
834	104
197	107
1516	104
836	108
443	104
1723	117
762	102
286	115
1761	99
1633	117
337	99
829	117
751	113
898	98
930	107
18	117
793	113
390	113
182	117
646	112
646	119
283	115
712	98
1649	119
707	112
100	112
1650	119
1517	108
1722	106
1514	106
1601	97
802	108
962	108
1600	119
613	108
914	104
700	104
1592	104
446	104
832	104
1659	104
1610	104
857	104
1675	104
917	104
867	104
436	104
1647	104
796	104
1728	104
1586	104
989	112
1747	104
845	119
364	106
244	115
977	104
1729	104
1589	106
1718	97
681	97
1623	97
734	108
734	114
437	97
686	97
336	104
662	97
1769	108
450	108
1754	104
791	104
630	97
896	108
896	114
1560	120
897	108
359	114
838	115
850	108
425	118
1527	102
935	114
1597	114
464	114
1638	114
1595	108
561	100
916	104
812	108
1710	119
647	102
915	108
1663	98
1531	113
672	107
925	108
895	98
1611	108
1622	98
222	107
1629	107
1621	98
185	98
185	107
1668	103
262	107
1630	107
803	113
667	98
13	108
274	115
671	108
1775	108
669	98
394	108
180	108
1774	108
1726	108
1540	108
1731	108
818	108
1658	108
1727	108
1674	104
1532	114
563	100
792	104
1525	110
674	98
673	107
1500	101
196	108
570	108
779	108
191	108
195	108
777	108
852	114
192	107
1692	108
229	107
784	108
1691	108
980	104
228	104
567	104
243	108
328	98
848	115
835	104
80	107
794	104
465	107
940	104
326	108
938	108
296	100
831	104
780	115
976	108
735	104
1748	108
776	115
1690	108
872	119
217	108
216	108
462	108
209	115
208	108
858	108
1689	108
119	97
1700	119
353	97
353	98
395	108
395	114
722	108
126	98
807	108
725	112
233	115
1741	119
689	107
689	113
396	113
223	98
795	108
232	115
215	98
1709	112
338	97
338	98
996	98
1548	97
965	108
304	98
670	107
894	108
79	108
1620	108
1759	108
893	108
320	108
320	114
295	100
428	110
892	108
149	115
702	97
918	113
919	97
920	97
1768	108
878	112
368	97
368	98
653	97
1501	100
1594	97
865	107
1557	116
1713	108
770	106
1667	103
1721	116
708	112
1510	116
106	116
1678	106
891	111
1639	97
1679	106
461	104
969	111
110	111
1773	104
438	104
444	104
439	104
934	104
1533	110
654	97
628	108
335	106
1526	106
890	111
772	116
1777	106
986	106
1554	107
819	106
29	116
767	116
1542	110
711	98
221	108
849	120
1544	106
214	108
804	107
801	108
190	101
234	108
230	108
1545	107
559	100
220	102
107	107
231	108
1541	117
695	108
241	108
661	102
727	116
213	102
1745	119
749	115
665	108
410	108
1708	119
866	108
950	98
889	98
1673	107
666	98
651	98
785	98
732	108
1547	97
1528	102
825	108
1590	97
298	100
1538	108
332	102
747	112
668	98
331	108
728	116
466	108
788	108
593	108
778	98
333	97
1688	108
240	107
239	107
854	102
334	97
238	107
696	108
750	119
714	107
746	119
729	119
888	98
833	99
1662	107
1607	108
748	119
1626	98
1608	108
926	108
627	105
627	108
1612	108
305	97
305	98
924	108
994	98
798	120
713	104
1613	104
724	108
705	105
705	108
824	108
964	105
964	108
805	108
698	108
442	98
1636	108
1696	106
26	104
1711	104
723	108
19	104
759	104
1606	108
1520	104
1757	108
1609	108
97	97
1603	108
183	104
1561	120
309	98
564	98
1653	101
887	104
1634	104
1634	105
351	97
650	115
313	98
1737	105
871	108
1551	110
1753	115
350	97
1652	100
961	104
1740	104
1660	103
237	117
1686	115
306	98
306	116
1687	115
1553	98
987	103
1752	115
682	119
943	116
583	98
583	116
105	98
105	116
983	116
856	120
1552	98
786	116
366	97
710	98
370	97
726	98
726	116
881	98
562	100
773	107
307	97
299	100
1619	98
816	108
816	114
877	111
886	114
1720	98
1720	116
1779	98
421	110
631	98
813	97
1685	119
362	108
841	112
841	119
853	112
853	119
303	102
1583	97
1543	107
1684	104
847	112
847	119
844	104
1717	110
879	98
1618	97
1707	119
885	108
951	115
1705	119
782	115
603	112
1648	119
876	115
293	100
884	102
1582	102
1617	102
322	108
1537	104
873	119
143	102
733	104
1615	108
691	103
691	116
148	115
294	100
709	112
170	100
843	119
862	103
862	119
1714	108
774	99
842	119
1508	116
285	115
389	116
1734	105
1734	108
236	115
1507	116
1669	115
957	101
775	107
181	116
955	101
1505	101
1635	101
135	101
954	101
822	101
758	101
1511	114
799	101
970	101
188	101
163	101
828	108
1519	106
990	112
325	98
1523	106
649	99
372	99
909	108
1534	110
745	97
680	98
680	107
623	100
1535	97
1739	108
827	114
1701	102
1736	105
1666	115
660	102
1530	99
1782	115
814	99
720	108
1646	102
207	108
1656	119
787	108
432	98
432	116
431	112
397	102
430	103
823	104
1762	108
409	104
956	119
806	119
1657	108
1735	110
939	106
212	97
219	102
171	116
1751	106
820	110
921	106
652	97
226	108
287	115
910	108
911	108
1750	106
1756	108
284	115
900	106
225	115
248	110
937	102
363	104
282	115
460	108
405	108
324	108
358	104
408	108
408	113
383	107
403	108
407	108
310	108
276	98
933	104
374	110
416	104
1616	98
308	118
413	98
859	112
998	110
261	106
1599	106
846	119
154	101
694	101
344	106
260	106
851	98
664	107
736	113
985	118
1555	98
984	107
1772	104
312	98
323	98
1719	107
434	106
882	107
883	107
815	107
435	118
360	107
433	106
678	117
235	102
422	104
973	117
1593	108
931	117
928	117
932	108
1699	100
1614	104
347	98
1522	104
947	101
1651	108
1568	118
375	110
1574	114
1565	108
1564	108
1567	107
1575	108
1570	98
1566	98
1569	106
1572	112
1572	119
418	102
863	116
863	119
870	108
701	97
301	100
693	102
1571	101
411	108
411	113
1627	97
211	98
\.


--
-- Data for Name: wavebands; Type: TABLE DATA; Schema: public; Owner: arnau
--

COPY wavebands (id, name, wavelengths) FROM stdin;
73	UV	~0.01 µm - ~0.40 µm
74	VIS	~0.40 µm - ~0.75 µm
75	NIR	~0.75 µm - ~1.3 µm
76	SWIR	~1.3 µm - ~3.0 µm
77	MWIR	~3.0 µm - ~6.0 µm
78	TIR	~6.0 µm - ~15.0 µm
79	FIR	~15.0 µm - ~0.1 cm
80	MW	~1.0 cm - ~100 cm
81	W-Band	94 GHz
82	Ka-Band	40 - 26.5 GHz
83	K-Band	26.5 - 18 GHz
84	Ku-Band	18 - 12.5 GHz
85	X-Band	12.5 - 8 GHz
86	C-Band	8 - 4 GHz
87	S-Band	4 - 2 GHz
88	L-Band	2 - 1 GHz
89	P-Band	0.999 - 0.2998 GHz
90	TBD	
91	N/A	
\.


--
-- Name: wavebands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arnau
--

SELECT pg_catalog.setval('wavebands_id_seq', 91, true);


--
-- Name: agencies agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY agencies
    ADD CONSTRAINT agencies_pkey PRIMARY KEY (id);


--
-- Name: broad_measurement_categories broad_measurement_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY broad_measurement_categories
    ADD CONSTRAINT broad_measurement_categories_pkey PRIMARY KEY (id);


--
-- Name: geometry_types geometry_types_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY geometry_types
    ADD CONSTRAINT geometry_types_pkey PRIMARY KEY (id);


--
-- Name: instrument_types instrument_types_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instrument_types
    ADD CONSTRAINT instrument_types_pkey PRIMARY KEY (id);


--
-- Name: instruments instruments_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instruments
    ADD CONSTRAINT instruments_pkey PRIMARY KEY (id);


--
-- Name: measurement_categories measurement_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurement_categories
    ADD CONSTRAINT measurement_categories_pkey PRIMARY KEY (id);


--
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (id);


--
-- Name: missions missions_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY missions
    ADD CONSTRAINT missions_pkey PRIMARY KEY (id);


--
-- Name: wavebands wavebands_pkey; Type: CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY wavebands
    ADD CONSTRAINT wavebands_pkey PRIMARY KEY (id);


--
-- Name: designers designers_agency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY designers
    ADD CONSTRAINT designers_agency_id_fkey FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: designers designers_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY designers
    ADD CONSTRAINT designers_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: geometry_of_instrument geometry_of_instrument_instrument_geometry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY geometry_of_instrument
    ADD CONSTRAINT geometry_of_instrument_instrument_geometry_id_fkey FOREIGN KEY (instrument_geometry_id) REFERENCES geometry_types(id);


--
-- Name: geometry_of_instrument geometry_of_instrument_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY geometry_of_instrument
    ADD CONSTRAINT geometry_of_instrument_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: instrument_wavebands instrument_wavebands_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instrument_wavebands
    ADD CONSTRAINT instrument_wavebands_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: instrument_wavebands instrument_wavebands_waveband_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instrument_wavebands
    ADD CONSTRAINT instrument_wavebands_waveband_id_fkey FOREIGN KEY (waveband_id) REFERENCES wavebands(id);


--
-- Name: instruments_in_mission instruments_in_mission_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instruments_in_mission
    ADD CONSTRAINT instruments_in_mission_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: instruments_in_mission instruments_in_mission_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY instruments_in_mission
    ADD CONSTRAINT instruments_in_mission_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES missions(id);


--
-- Name: measurement_categories measurement_categories_broad_measurement_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurement_categories
    ADD CONSTRAINT measurement_categories_broad_measurement_category_id_fkey FOREIGN KEY (broad_measurement_category_id) REFERENCES broad_measurement_categories(id);


--
-- Name: measurements measurements_measurement_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurements
    ADD CONSTRAINT measurements_measurement_category_id_fkey FOREIGN KEY (measurement_category_id) REFERENCES measurement_categories(id);


--
-- Name: measurements_of_instrument measurements_of_instrument_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurements_of_instrument
    ADD CONSTRAINT measurements_of_instrument_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: measurements_of_instrument measurements_of_instrument_measurement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY measurements_of_instrument
    ADD CONSTRAINT measurements_of_instrument_measurement_id_fkey FOREIGN KEY (measurement_id) REFERENCES measurements(id);


--
-- Name: operators operators_agency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY operators
    ADD CONSTRAINT operators_agency_id_fkey FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: operators operators_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY operators
    ADD CONSTRAINT operators_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES missions(id);


--
-- Name: type_of_instrument type_of_instrument_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY type_of_instrument
    ADD CONSTRAINT type_of_instrument_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES instruments(id);


--
-- Name: type_of_instrument type_of_instrument_instrument_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arnau
--

ALTER TABLE ONLY type_of_instrument
    ADD CONSTRAINT type_of_instrument_instrument_type_id_fkey FOREIGN KEY (instrument_type_id) REFERENCES instrument_types(id);


--
-- PostgreSQL database dump complete
--

