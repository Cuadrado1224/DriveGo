PGDMP                      |         	   DB_Driver    17.2    17.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            	           1262    16387 	   DB_Driver    DATABASE     ~   CREATE DATABASE "DB_Driver" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "DB_Driver";
                     postgres    false            �            1259    24594    reservas    TABLE       CREATE TABLE public.reservas (
    id_res integer NOT NULL,
    ced_usu_res character varying(10) NOT NULL,
    nom_usu_res character varying(20) NOT NULL,
    matricula_veh character varying(10),
    fec_res date NOT NULL,
    fec_dev date NOT NULL,
    est_veh_dev character varying(20),
    tar_adi numeric(10,2) DEFAULT 0,
    des_dev character varying(100),
    CONSTRAINT check_estado_dev CHECK (((est_veh_dev)::text = ANY ((ARRAY['NUEVO'::character varying, 'DESCOMPUESTO'::character varying])::text[])))
);
    DROP TABLE public.reservas;
       public         heap r       postgres    false            �            1259    24593    reservas_id_res_seq    SEQUENCE     �   CREATE SEQUENCE public.reservas_id_res_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.reservas_id_res_seq;
       public               postgres    false    221            
           0    0    reservas_id_res_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.reservas_id_res_seq OWNED BY public.reservas.id_res;
          public               postgres    false    220            �            1259    24577    usuarios    TABLE     �  CREATE TABLE public.usuarios (
    id_usu integer NOT NULL,
    nom_usu character varying(15) NOT NULL,
    ape_usu character varying(20) NOT NULL,
    corr_usu character varying(50) NOT NULL,
    con_usu character varying(20) NOT NULL,
    cargo character varying(15) NOT NULL,
    cont_temp character varying(20),
    tmp_cont character varying(2) DEFAULT 'no'::character varying,
    verificado boolean DEFAULT false,
    codigo_verificacion character varying(255)
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    24576    usuarios_id_usu_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_usu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.usuarios_id_usu_seq;
       public               postgres    false    218                       0    0    usuarios_id_usu_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.usuarios_id_usu_seq OWNED BY public.usuarios.id_usu;
          public               postgres    false    217            �            1259    24583 	   vehiculos    TABLE     7  CREATE TABLE public.vehiculos (
    mat_veh character varying(10) NOT NULL,
    mar_veh character varying(20) NOT NULL,
    mod_veh character varying(20) NOT NULL,
    tip_veh character varying(20) NOT NULL,
    anio_veh integer NOT NULL,
    est_veh character varying(20) NOT NULL,
    tip_trans_veh character varying(20) NOT NULL,
    kil_veh integer NOT NULL,
    num_ocu_veh integer NOT NULL,
    num_pue_veh integer NOT NULL,
    img_veh text,
    precio_veh numeric(10,2) DEFAULT 0.00,
    chasis character varying(20),
    combustible character varying(20)
);
    DROP TABLE public.vehiculos;
       public         heap r       postgres    false            d           2604    24597    reservas id_res    DEFAULT     r   ALTER TABLE ONLY public.reservas ALTER COLUMN id_res SET DEFAULT nextval('public.reservas_id_res_seq'::regclass);
 >   ALTER TABLE public.reservas ALTER COLUMN id_res DROP DEFAULT;
       public               postgres    false    221    220    221            `           2604    24580    usuarios id_usu    DEFAULT     r   ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usu SET DEFAULT nextval('public.usuarios_id_usu_seq'::regclass);
 >   ALTER TABLE public.usuarios ALTER COLUMN id_usu DROP DEFAULT;
       public               postgres    false    218    217    218                      0    24594    reservas 
   TABLE DATA           �   COPY public.reservas (id_res, ced_usu_res, nom_usu_res, matricula_veh, fec_res, fec_dev, est_veh_dev, tar_adi, des_dev) FROM stdin;
    public               postgres    false    221                     0    24577    usuarios 
   TABLE DATA           �   COPY public.usuarios (id_usu, nom_usu, ape_usu, corr_usu, con_usu, cargo, cont_temp, tmp_cont, verificado, codigo_verificacion) FROM stdin;
    public               postgres    false    218   �                 0    24583 	   vehiculos 
   TABLE DATA           �   COPY public.vehiculos (mat_veh, mar_veh, mod_veh, tip_veh, anio_veh, est_veh, tip_trans_veh, kil_veh, num_ocu_veh, num_pue_veh, img_veh, precio_veh, chasis, combustible) FROM stdin;
    public               postgres    false    219   �                  0    0    reservas_id_res_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.reservas_id_res_seq', 3, true);
          public               postgres    false    220                       0    0    usuarios_id_usu_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.usuarios_id_usu_seq', 45, true);
          public               postgres    false    217            l           2606    24601    reservas reservas_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_pkey PRIMARY KEY (id_res);
 @   ALTER TABLE ONLY public.reservas DROP CONSTRAINT reservas_pkey;
       public                 postgres    false    221            h           2606    24582    usuarios usuarios_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usu);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    218            j           2606    24589    vehiculos vehiculos_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_pkey PRIMARY KEY (mat_veh);
 B   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_pkey;
       public                 postgres    false    219            m           2606    24602 $   reservas reservas_matricula_veh_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_matricula_veh_fkey FOREIGN KEY (matricula_veh) REFERENCES public.vehiculos(mat_veh);
 N   ALTER TABLE ONLY public.reservas DROP CONSTRAINT reservas_matricula_veh_fkey;
       public               postgres    false    219    221    4714               �   x�=���0 �ۯ��l�T��O*&�^�4t5$�&���o3����,��	��K>�6���ו���*Ԋ��kp<W�0C���s`���|�n���ը�$臗��&��ֻJ����Ҥt���m�l���\5mv�$���q˄�.�          �   x���KK1�ϝ����$7eO+("x�K'�^f&2A���T�VPP_U!�=���i�}����qY[��W����H�p(mc� ǡ�ie8?��`��蚭���G+%"&���E����&x�߁&���+�;�iF��뒌����d��PP9�e$�Q��6y(�Z����c?��z�����3��%
V�rJ�X94������C������/@�tIȔZSJ"��~N�*!S����� �t           x����j� ��듧�$�Ucrُ�$[J!��0(�9&�8;ַ�Y�(���㝈?���Y�S�;9�`�g��4�Y���5�4�ư4��Mg5Ԫ?*��8�qEwe=����8�i���Z�i�����<£��C���T���WA�H�ū~G[{h��q�g	�� ��dA�Ee	<��W�����ң����!�bX�qD�1�2�B�/6K�LI�YKHέrW�LT�ŵu��Ôg0������	��c������޻?�T��X~��9��˜��+�A�	�$��     