PGDMP  /                    {         
   doctor_who    13.13 (Debian 13.13-0+deb11u1)    16.0 5               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16385 
   doctor_who    DATABASE     v   CREATE DATABASE doctor_who WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE doctor_who;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false                       0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    4            �            1255    16598    convert_story()    FUNCTION     k  CREATE FUNCTION public.convert_story() RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT * FROM episodes
    LOOP
        IF rec.story IS NULL OR rec.story = '' THEN
            UPDATE episodes SET story_new = NULL WHERE id = rec.id;
        ELSIF rec.story ~ '[a-z]$' THEN
            UPDATE episodes SET story_new = substring(rec.story from '^[0-9]+') || '.' || (ascii(substring(rec.story from '[a-z]$')) - 96)::text WHERE id = rec.id;
        ELSE
            UPDATE episodes SET story_new = rec.story || '.0' WHERE id = rec.id;
        END IF;
    END LOOP;
END;
$_$;
 &   DROP FUNCTION public.convert_story();
       public          postgres    false    4            �            1259    16386    actors    TABLE     a   CREATE TABLE public.actors (
    id integer NOT NULL,
    name text NOT NULL,
    gender text
);
    DROP TABLE public.actors;
       public         heap    postgres    false    4            �            1259    16392 
   companions    TABLE     ^   CREATE TABLE public.companions (
    id integer NOT NULL,
    name text,
    actor integer
);
    DROP TABLE public.companions;
       public         heap    postgres    false    4            �            1259    16398 	   directors    TABLE     S   CREATE TABLE public.directors (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.directors;
       public         heap    postgres    false    4            �            1259    16404    doctors    TABLE     |   CREATE TABLE public.doctors (
    id integer NOT NULL,
    incarnation text NOT NULL,
    primary_actor integer NOT NULL
);
    DROP TABLE public.doctors;
       public         heap    postgres    false    4            �            1259    16410    episodes    TABLE     V  CREATE TABLE public.episodes (
    id integer NOT NULL,
    title text NOT NULL,
    serial_id integer NOT NULL,
    story text,
    episode_order text NOT NULL,
    original_air_date text NOT NULL,
    runtime text,
    uk_viewers_mm numeric,
    appreciation_index integer,
    missing integer DEFAULT 0,
    recreated integer DEFAULT 0
);
    DROP TABLE public.episodes;
       public         heap    postgres    false    4            �            1259    16418    seasons    TABLE     Q   CREATE TABLE public.seasons (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.seasons;
       public         heap    postgres    false    4            �            1259    16424    serials    TABLE     �   CREATE TABLE public.serials (
    id integer NOT NULL,
    season_id integer NOT NULL,
    story text,
    serial integer,
    title text NOT NULL,
    production_code text
);
    DROP TABLE public.serials;
       public         heap    postgres    false    4            �            1259    16430    serials_companions    TABLE     n   CREATE TABLE public.serials_companions (
    serial_id integer NOT NULL,
    companion_id integer NOT NULL
);
 &   DROP TABLE public.serials_companions;
       public         heap    postgres    false    4            �            1259    16433    serials_directors    TABLE     l   CREATE TABLE public.serials_directors (
    serial_id integer NOT NULL,
    director_id integer NOT NULL
);
 %   DROP TABLE public.serials_directors;
       public         heap    postgres    false    4            �            1259    16436    serials_doctors    TABLE     h   CREATE TABLE public.serials_doctors (
    serial_id integer NOT NULL,
    doctor_id integer NOT NULL
);
 #   DROP TABLE public.serials_doctors;
       public         heap    postgres    false    4            �            1259    16439    serials_writers    TABLE     h   CREATE TABLE public.serials_writers (
    serial_id integer NOT NULL,
    writer_id integer NOT NULL
);
 #   DROP TABLE public.serials_writers;
       public         heap    postgres    false    4            �            1259    16442    writers    TABLE     Q   CREATE TABLE public.writers (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.writers;
       public         heap    postgres    false    4            �          0    16386    actors 
   TABLE DATA           2   COPY public.actors (id, name, gender) FROM stdin;
    public          postgres    false    200   �A       �          0    16392 
   companions 
   TABLE DATA           5   COPY public.companions (id, name, actor) FROM stdin;
    public          postgres    false    201   �D                  0    16398 	   directors 
   TABLE DATA           -   COPY public.directors (id, name) FROM stdin;
    public          postgres    false    202   YG                 0    16404    doctors 
   TABLE DATA           A   COPY public.doctors (id, incarnation, primary_actor) FROM stdin;
    public          postgres    false    203   L                 0    16410    episodes 
   TABLE DATA           �   COPY public.episodes (id, title, serial_id, story, episode_order, original_air_date, runtime, uk_viewers_mm, appreciation_index, missing, recreated) FROM stdin;
    public          postgres    false    204   �L                 0    16418    seasons 
   TABLE DATA           +   COPY public.seasons (id, name) FROM stdin;
    public          postgres    false    205   ��                 0    16424    serials 
   TABLE DATA           W   COPY public.serials (id, season_id, story, serial, title, production_code) FROM stdin;
    public          postgres    false    206   �                 0    16430    serials_companions 
   TABLE DATA           E   COPY public.serials_companions (serial_id, companion_id) FROM stdin;
    public          postgres    false    207   ��                 0    16433    serials_directors 
   TABLE DATA           C   COPY public.serials_directors (serial_id, director_id) FROM stdin;
    public          postgres    false    208   ��                 0    16436    serials_doctors 
   TABLE DATA           ?   COPY public.serials_doctors (serial_id, doctor_id) FROM stdin;
    public          postgres    false    209   ��                 0    16439    serials_writers 
   TABLE DATA           ?   COPY public.serials_writers (serial_id, writer_id) FROM stdin;
    public          postgres    false    210   �       	          0    16442    writers 
   TABLE DATA           +   COPY public.writers (id, name) FROM stdin;
    public          postgres    false    211   A�       [           2606    16449    actors actors_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.actors DROP CONSTRAINT actors_pkey;
       public            postgres    false    200            ]           2606    16451    companions companions_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.companions
    ADD CONSTRAINT companions_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.companions DROP CONSTRAINT companions_pkey;
       public            postgres    false    201            _           2606    16453    directors directors_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.directors DROP CONSTRAINT directors_pkey;
       public            postgres    false    202            a           2606    16455    doctors doctors_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.doctors DROP CONSTRAINT doctors_pkey;
       public            postgres    false    203            c           2606    16457    episodes episodes_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.episodes DROP CONSTRAINT episodes_pkey;
       public            postgres    false    204            e           2606    16459    seasons seasons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.seasons DROP CONSTRAINT seasons_pkey;
       public            postgres    false    205            i           2606    16461 *   serials_companions serials_companions_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.serials_companions
    ADD CONSTRAINT serials_companions_pkey PRIMARY KEY (serial_id, companion_id);
 T   ALTER TABLE ONLY public.serials_companions DROP CONSTRAINT serials_companions_pkey;
       public            postgres    false    207    207            k           2606    16463 (   serials_directors serials_directors_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.serials_directors
    ADD CONSTRAINT serials_directors_pkey PRIMARY KEY (serial_id, director_id);
 R   ALTER TABLE ONLY public.serials_directors DROP CONSTRAINT serials_directors_pkey;
       public            postgres    false    208    208            m           2606    16465 $   serials_doctors serials_doctors_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.serials_doctors
    ADD CONSTRAINT serials_doctors_pkey PRIMARY KEY (serial_id, doctor_id);
 N   ALTER TABLE ONLY public.serials_doctors DROP CONSTRAINT serials_doctors_pkey;
       public            postgres    false    209    209            g           2606    16467    serials serials_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.serials
    ADD CONSTRAINT serials_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.serials DROP CONSTRAINT serials_pkey;
       public            postgres    false    206            o           2606    16469 $   serials_writers serials_writers_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.serials_writers
    ADD CONSTRAINT serials_writers_pkey PRIMARY KEY (serial_id, writer_id);
 N   ALTER TABLE ONLY public.serials_writers DROP CONSTRAINT serials_writers_pkey;
       public            postgres    false    210    210            q           2606    16471    writers writers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.writers
    ADD CONSTRAINT writers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.writers DROP CONSTRAINT writers_pkey;
       public            postgres    false    211            r           2606    16472     companions companions_actor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.companions
    ADD CONSTRAINT companions_actor_fkey FOREIGN KEY (actor) REFERENCES public.actors(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 J   ALTER TABLE ONLY public.companions DROP CONSTRAINT companions_actor_fkey;
       public          postgres    false    2907    200    201            s           2606    16477 "   doctors doctors_primary_actor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_primary_actor_fkey FOREIGN KEY (primary_actor) REFERENCES public.actors(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.doctors DROP CONSTRAINT doctors_primary_actor_fkey;
       public          postgres    false    2907    200    203            t           2606    16482 7   serials_companions serials_companions_companion_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_companions
    ADD CONSTRAINT serials_companions_companion_id_fkey FOREIGN KEY (companion_id) REFERENCES public.companions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 a   ALTER TABLE ONLY public.serials_companions DROP CONSTRAINT serials_companions_companion_id_fkey;
       public          postgres    false    207    2909    201            u           2606    16487 4   serials_companions serials_companions_serial_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_companions
    ADD CONSTRAINT serials_companions_serial_id_fkey FOREIGN KEY (serial_id) REFERENCES public.serials(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 ^   ALTER TABLE ONLY public.serials_companions DROP CONSTRAINT serials_companions_serial_id_fkey;
       public          postgres    false    206    2919    207            v           2606    16492 4   serials_directors serials_directors_director_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_directors
    ADD CONSTRAINT serials_directors_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.directors(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 ^   ALTER TABLE ONLY public.serials_directors DROP CONSTRAINT serials_directors_director_id_fkey;
       public          postgres    false    2911    208    202            w           2606    16497 2   serials_directors serials_directors_serial_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_directors
    ADD CONSTRAINT serials_directors_serial_id_fkey FOREIGN KEY (serial_id) REFERENCES public.serials(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 \   ALTER TABLE ONLY public.serials_directors DROP CONSTRAINT serials_directors_serial_id_fkey;
       public          postgres    false    206    208    2919            x           2606    16502 .   serials_doctors serials_doctors_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_doctors
    ADD CONSTRAINT serials_doctors_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctors(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.serials_doctors DROP CONSTRAINT serials_doctors_doctor_id_fkey;
       public          postgres    false    2913    203    209            y           2606    16507 .   serials_doctors serials_doctors_serial_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_doctors
    ADD CONSTRAINT serials_doctors_serial_id_fkey FOREIGN KEY (serial_id) REFERENCES public.serials(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.serials_doctors DROP CONSTRAINT serials_doctors_serial_id_fkey;
       public          postgres    false    206    209    2919            z           2606    16512 .   serials_writers serials_writers_serial_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_writers
    ADD CONSTRAINT serials_writers_serial_id_fkey FOREIGN KEY (serial_id) REFERENCES public.serials(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.serials_writers DROP CONSTRAINT serials_writers_serial_id_fkey;
       public          postgres    false    2919    210    206            {           2606    16517 .   serials_writers serials_writers_writer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.serials_writers
    ADD CONSTRAINT serials_writers_writer_id_fkey FOREIGN KEY (writer_id) REFERENCES public.writers(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 X   ALTER TABLE ONLY public.serials_writers DROP CONSTRAINT serials_writers_writer_id_fkey;
       public          postgres    false    2929    210    211            �     x�]T˒�0<_�[n)�d9��*P��\{����8_���Z�LwO�"x�JI<�'�N�RpBE�6�,�bgMs����A/F�Y�I�A)��I��H�2ؐ#+��C���9,�����������]�v��n#����S�Zi��X�����x(
��.Q�k)v�5��vktNlO�UJ��Q�2�i�6u%�!��/%��J:w��N�	�Bk���bil9�L��_�fOl�pr7x������h�$K���/s+I�_���j�X�+L(�Y�o�W>��P�5ں�ĳ9��j��6Y�8��,*$%��)�9,�?���@b��7+�Ny��"��tي��ƶ>�����x2�Wt-����L���5��Ub���������t}��V��5�����w�.@+�!�	�Dۊ�NýV����(��%=}z�d+�����}���R�����m�6�]y�c��(�����<����2�`�da��ܶ>�}��M����~��4��9W|2S��+��R�+v|VW{k�q8�a�Hb#��X���F�KEa/ӻ��9Zk>Oؓ��7㳢XY�%��Dv��1�ش�rq���١%_�?���D�R�Cs��Ւ�<�����R��eyd7u2�YW5����_�,�����gT�$�k�Q��������A�GVJL�x��\�+��e�<W��<�5�w&����Jh�}�,�p5鞨US`P��<,�Ν��Õg����˓P���R�/^�~�F���      �   [  x�=�Ko�0�ϻ����|��1N�$v��ѠE/��Sd@�1�_�U�8R"gg�Y	�y�(>��� +T���L��S�Ǿ�\��;�tݻ��\߫��7ߝ�x���d����\{�Bʠ�X��
e	��������!���)��kp��Sӿ�ʠ\E7ԝF��,J	���:�a��V(�l����=�����
��ɉ[�}b���{�K�=]@5(-l����%���g�#���KZ�\�-�<��̡��V(k�w.h���mڠZ���DI܁����#����C��*{wd��Ċ'֩Qx�ƑDz�L'ǓT���U��9���D5\���HT+xt��|�l����_�uN��Pհc��٭�#+hTw�S�'qC���U�L��DƠ^���.4����L��)p��B=��;_�ޅ �7G�ܚ`l���L����W�M���e��<����.QW��\zb,��D��'^�;�]*�F]��0��`���\m�G�	�a^�/�x,�-/8��7��P)4(ϭ4��Sq�O��`��=~�Ѿ|Xg�eT-ǟ����.��P�E�i|[FU�??"�o"��          �  x�eUɎ�6=�_�[Nh_�m����{mc	ra[e�0E�d�����vA_����^U1w��Ԫ3C+qg�S��;;��~�@��dh6�����v�N���5�N�itN�h��N;Y2�ԓoY����4��$k1�!Lꅆ��q$fG-�'d���V��Z�=�`�S�n�q*�zh)G�ǽFƙ��:X�՛��`����r�2..x�\V�d\���Ʃ5��H2�wj���0�8P�{����[�D�ߐU��%��$������A�$��jf��d�M���z��L�S�=�07�2ə	f�G�|s2N&��G�V#z�ma��Iy�z�7�A��r���1�_-��{�29�F����f���X<ﴚ�]�¦�xDa�j��4O�� �V8cv�VrP��G��n��Cж������ɴO>4ީGK��^*��#�2�@-䐵Z��oZ�E ���w��s��S��,Ϻ��}�^f����C3Ƹ��'G2��3
ݡ���Cf�x����-������02�.h�f� dV_vWyt�H*�y����>Ц2Gh�5�:Iyz�N�Lw�yX��Cp����3{�y.�Ϋ��{�@�冎�Q2���f��y%^������Z��#bU3t�ՖE$�T�ɩ7�.MS�LM��4;�E4��,{��t�I���8�"K���\,ͦ����/�<��,��Ha7��7
�L�/<��E}#��_)���6��B�s�]JZ&��N�eč^�H���:�e&^q�_��Z�̙۫��(ī�3Љc-K�l����Yβ1b�)8�^e}��~ڐ��Z��Q���خo���J��B�����&���N�����,��ʯh��0�*Ļ޴�w�-~pT�w���#z*��	6�{Y�7�[dݘ9レc���!���N�8d�Q���X���L�s�����b�J��ݳ�u!PIlU,q��\C`Kf�xL0ۮ���fR�cË����tk������"��w�G10f�	;��5opHwO�a�,_K�)n�� �(/���S{��Q~yW�.Q���ߣ�0��Os ��+e��p@5��^!*��U��XX-T��b1ްg��-}Co{T:�C�ju�/1b<e]��1���|�s�-�o:���1��:��)��_��� ��o�         �   x�U���0Eg߯�*	���N]@��%��DB ����U���c���L����͖	5����B��Ʈ ��z~Z7,D@zK�DF���!�ڗ��QPe�C J�(��%8��٬pfj�fpBոws�W���9�S��Eqz7,����s���~�
\ �v,W�            x���K�7���ٿ"��s��]���"%-�-َ�%Xb�2+���E����ň�i��
_���p ����ϻ��f�ڍ�{�m�������u?��O|��˅`7��t���ۼ?���ǿ�W�i�oL�����O�c0��I؄�1��q����w�ǭ�wf�����W�>ɏ��3�k� ��Y�lr1��Pʘ���3������?z��s�vL�JxD��b,�r���$���u/RHJ
Dq�2T)l��2�j3�񪌍��n�E
C���B�?t��� k,�R"r��J�J����z����є�Ͽ��V�&�X)Zu�b�z���\]"S��)
@���� ���A�p���O�"�`���h���(��H���ĵuI&kl�F+�b�vב>EC��A*���������HLi�)U
Y��Gl����A���gT	c��6�x�wCG���#�j
��ev4T�`��S�mB�1רbں�~��6!X-�T8�A��"�i�i�x����J�E^� KX]���5K�u'-�8E�8�Ճ�\&��W[����An�#h`J�-�M��g	��Q�[�%�*aІ�9d~�*rt����� �-�-��%vZH�2�9ȂE���L�����B��hD{�Fa�Xm���T�.=m��U"�X�iIgSD�Ք�a�������ҏ8e�%h��/K�D�W��φ>�Z�R������)X���������>~QQ,�p�/�J<b��ĔT(��T6-r�-u�_|�_�l�@�0�E���}�%�.�z�'��1e�bu�"�)�A�Ā۹���qr�W��Ţ[�03��M�e�çe�P7�����)h� ��%��0���\e���S%�y�.�e�ɔ������h�(R�^k6R���mf�?J]��H)�>�/~�n �otr��(
���,�~"ݾ�S�XM���%�H]=E�S����Xh˥o�)��,�2������>BJ��A��T"���Q�0�Ծ��>*�gg�wJ��ǔ֩�rR�'�UG��~i���������g��wK#DV���O�(4�-�H�.C��O��(4�/��AF�Q��d+a����E���?S(�����F�g��}��(4'��yH���>B��Z�eK^F�tPT	���"�{��w�����p<��z���J$-{,u��x���J�eo�3�B3W�Kk ���A�?�(4ʺ~ɧ$J�\-{�8E�Q�qtaN"S���N�xeY��a͍�B��?��G��	��>BJTe~�KNL�3z��S}�q��Jaa|E��D�}p6����u�S�,O�(<����c��s:��L��Q��#zN'JP����[���t����g��'k�&�}�F����^ɿg�bò�N=��jJ�5ǂF�,�������M���������š0TfRk�|Me����,�����J�z���?�� u���8E����R̎�����H|� ���4*2E��%w��!��ۣ���F�"F�
Ű�wv�.lAm�cH��B>բ��r���!�)
�Y~qU���R��XǱ�����5Z���(�y��[�՞#Qʨ_3q�F�����.q���Pl��Y�f��� B+����Mh�R,�}8�����<�,��(��K��촡9���53'��L3�[��J�]��Q$]Qh�a����7�R�,�l\��,K�xsHq�ҳ�ҳ�k<1,T�#1�_�Կ�ΐ�I<�,�2R�F{��hJϫ�:�F��b�↝]�%�!�hR��P�������C�הt̆�9�4�Rjy��¨M ��2�/�e�*�{Wq)ffY������v��#^{tYf�S��qw,��K��7*cU�4��֟����Qj/^kѶ�\�y��ڣ#�W�CʬvwL�Q����^]�GG��(��Zp9�|������v�,t��w�vTz���G��`�e�.\fPeh��-�{��O:Q�Nq(r� {.64Z�ia�p�)q����D�U���B,�?eJ��Hq��8�5��-�F/���cыq}�����Sg8��?�g�R���.Q�\���5��xeJ�V�(NQ(��q�P����2^�)���k�ȣ3jK��)���Im���2��q�F�+U�x=���Ј�/�uE��B���0o�K��N2Q���|����yu��(��<zp���x��z%B%�*A��l7��X��@�D�4���Ǽd%��@��(6��'`�}�Ĕڇ��g�Yy'�Kf���Հ��㝟gJ]�/I�(���?v~a�Z(ڗ$�SZϠ���\DÒ����vg�@����G�D���QcO�I����G���H��:�5L��$�$E�x�s跔�댇@�PT��,C��Կ�D��2�.c_K��*�T	Z�.�%��n �W�u+��9�P�~s�X��P��v�Z]�~3Q�,G6�Y��
E�@�)��k)�����We��}��oT(z��(ASR�ퟳ������ű�ҼZ(�V��o����P�F+�b��:��C��X��\J?,�F+�R�ã��+��E��he�Q����lW(�V"�jJ��fД2�b��p&[���R��A,S�$"�=2��F�4����144:���(%�ۺ��U(�b�(
����0�1�u�"�j� r�%�U��W�v�K.�F������1������)�����~���'�z:Y�0���a�W]�CB�)��ZXW}?8+E�d���"���W2D�BQ(��)�VJ�1�^Gi%�6e5�:����iI�69��wR+��>����`��X��Ρ"Nam2����!�ה��"W��3���E�\c��*�u�
��* �+6��u�)
�����0��$�ה��']�%(
��{�.�%J,ʞ�qY�4Z��3�L϶f}L�F-�b�F���H�6���S[wj�V��h*R���9(/�Y�"�2U�A����/�5:Q���ζý�R���>�ʀ��J�z
�6�)VS�w�^���}EJ��U�F����W���P�bk�$JД��!b-���T"��-���:�[|�?8	��:E����I>�T��7mV��,$�SZN<�P9�7���,��fF�+�Q��є�[vʭt�QJ,S� �G���D��X©�|;���a	�K������l��Qr��#.�k6��R�뤽�#F��"�S�͘�f��x]��K�o��A�E!)��\ �P#���(��~� E�4���W{�s���u�4�8TĪ"��p�}�TJ��Hq�bq��Pt3���F-��5�g�y}>ovq�R;$��g!*���4�8D��bpw���W+8�gt�E���Bc�b�����>�4f)�G"F���YV�1�H�-�H�:E�L%(���Jy�_�Ι JT�|E�4�C3���t��v�6���t���Q�6�S��<t���!VAx���_����i��u������	3��������P6v��#�N������gĠ�
#!n��(��X����X��e��0����Wz�?U��Hm��y^�V'�*Tb�E~$���hj�@%�vs��
�"R���C+��Ϩ"e_:Ǳz�!�
U�iq�P�=�j���.4�� V����_n�)^Q(���OK��V�QE��axČ%�G�M�<��|�i�1U�<�iCk.zjT)^Q�'��5��uCJPK.zl|���D]$q���� i�����p��#C2iD�Uc8�f��H�R"�i2��S��H���>��P�N�RjD�v�=��!�D��ޭ˥���|��8�}�م�D�z�:�AA��p�|�+�tb��p>�����AwR���L$��ZG#|F�P��i�u!U�c)gnn�+�VG�4��U^�}���(R�����p�]�ڔ&�����`�v�m7�D���h������,7h}��3��ĸ��Z!�kef�&�!�B"�)��RRO�C�~X��2CIZIxqC��)�P()�ק�i@R�!QAh�QӅs��U�    xckx�~wP��"V��%ه�c��>b��Kz�#f�wF�R��Ppʚ�����;���v��B��Y>����R��e@ �ruu��w�R�)9ݰt��3F�)Q��P��Ǯ��S�3OF�Qbd��M�)�I�"89�J�����XN�8�1�Sj�=1F[N�xM�9�;?�p���yz�m����y�#b1ʘ��E�� 3�,oy���Dq���Z�ۼ�>(Q���9�P����9o�����(��]����D�T��beٴ.��H)U*��I�v���&i� �+JI��uY�~��k���� G��W�(�JE�*�1Ӹ��&ۘW�8�I&^���(^Q��:3�j�jXm^|Z�$�$I1�V�W�T�X v�#�a[��0T$�aY�lc]��ʉ�\�5�j'�(AS0�����P�@�X ��c(��f����_��A�_���صZob�H�x��aC�Z�E�Ә�sW�N�5z��(��Á��U����_L]V�Ȫ�wZob5D��V�u�Z�E�S
�X��r>�Q\�xE�N\��_N� =|Z���7���. 2�d�N���c��u����2��n�{,�U>T�P{�Sy���>�@��\?ίX
DO��"��u����1Nah����7�=B���L��#ӽW�}^J]#ޔ�Ч3�eu�j�'F���6eƊI��tO�0��Ve��{�xM8w8Wf�b���!����(��t��xeG�Q��$��-;J�0 !�u��%�הa�	]	V�tD	��by$�ル3Ab�x��%�H&�����W;h�[�����!VA8�[ߝ���[�8��{��BG�6z��(�:,��Xo��[_LR��E�ʾ�Zqb5�/w|��	��*.b��Э��ױl5�2^����Y��3G¨�>;�o������'K]�|O�*��~3�S!�
qJ�#�R>�ٝ(^S�W�+B^�*>� 4V1gH�_��T�6�\JӤ(�v�
9U�����O���!�kJ*��ȍ�U"|��^.贴�?[��5��*H��a5�ķ�J�q
C�
xDpM�]%�xM�����_(�V&��X�
���ŇN�V"�*�1�2ǧ�V"�iL��b���Xƫ2���p���,�#�J4w!%�k6?��t�U©Q1H�K#��ZK{�jw�6�-�8Q�^k)B����������R�8��Ո�^���"�+���υ×<u�ZK��X\WN��^k)B�X�
�@}��h}���q
c<�,4�Ë}��H�B�苙م�ft���U���~|dmN�՜.�*�c>�a�fV�S ��[:�Y@z����&$-<e���P�3�mmQ�����(��-�d�h7��4h���f�ٌ�W#�� ��T&�[�G��L�I�~H��TH7�r& �gu�6�m�	�$��%�4|hN�80��;;gӞt�:-G�(���`L�	\�haP!�%ζX�4�m�A�*���n��r�0��ǐ|�}�N"NМ�f��J,LT�:�)׬�A����O!�G� ��;��@�AT��b���Ӳ����#b9���vх�@��YM��^"�W$X�D����ki���4*����@W�b0�����(�f.�P�y��r
dd��̝���i��8^q8�=;=�i0v)J��O�4&����i&�}(�T�^Ӡr�u;�b�%�8���j&4{Q��#W�c�q
��0����Oc�8��ҡtK�Zm���@N�z#>j��x�1r��F�Xv�8=��0t�n�?ݸTD����D듁}��D�w�U���ۺ��c����ǜ�aյ��0lP�����\��?��oL��O�ك�?���?�C��Ğ����y���u�\��.��a.��;���gq�;v";YE��z�o��$��؂��d_���ؑBN"Wn�N�2^���-�g�[�N���?(X�$N'�(
z�F
X*���[�o���n��]��U]���f'G(�R�K|�f�z���V���&T ����zYo�D�b�������n��U�h��;B��6���,�q*���rn��"�yp�/\4W���L�T�Pb�Y�3�@��1"��0�߮��C��#_(�U��20Eϖ�. Fr7���ٔ#�蹒!�@�Q��S�n�`\�`��<r�94�9B��'*��Ң��@�qr�z�Xf��$��E�9�z�5��IW0F6?�Z�[�9%�/���ʈm	�y��I�Z=lBcr	"b�K�hA8��\¸��{��#:�&�(�PX,K}$�%6&7 Vr��B�հx���%����Fa}]�\¸��B��/[�K_)t�ꑬ����B�y�53�K�*��}䒣�\�T�Ь�у��(�&�(U,�o��SClL�@ �H���Ҙ\��
�������\¸���R��2����ZF�zZe��v*���#C&iː*�z$�0���2�
��:�z�ZH��eJ���V���>kd ��vE,rMpx$].�F�B�/汚h-��+ktMzޭ}����2D�d`_t}����2�L��c}��7z�_)��v}�7z�T �6�<e���R�*ҋ�����B���z�\��J�����x䊬�7*�	'"�22�Bb�oT� �BB�K�s���"H;�3�L�s�.J^�7G���+Ų",��C��h��P�Wb�#Zq������`���@�~�0�� A�P����l���>I�[?�1U��L��D�C�'0�����{����H)����� 8��AEr����/o>N����|9�__v���d�e��hbA�0�C����	���x�L'�Y�3����.����ܻcF��������f��Q8+��B�N�D����1۫�psF���HY�w���z�'m_�nN���巉P��g���T�Z�9����7;&yE2��ߢ��	�ͻ��t��u:�m�n�����#,(�5%<���B�m��>�^�m���w�_2YQ�P-�Ofe<=gM8���v�l�>�@X*0����f���tv�����J<��v騐\�K��Ǵ�2]�N�c5����z��Ԓ�_]���4�����	iN�(�ć�Z񕸤�W���3���t:O�*!w����U���p��S+��QC�<\�W�z�2}�j�� �?#,*]?`o2���I��Ow��X��_v{��Wuc�Y=.>�ƞ��;�ε���
Ǐ4.=-(�Al���j�>���]Oȫ����]�L�@v�{1~Ú��O��|F�W0��ZL��fsu9�=���t�y��5Pr����ي� ���:|�����"A�Y�K����������f:�FBS�ر���l����<ݾ���>�����½	4�i=',�k������0~ƿ�騝_rj��b��<~�N�,��r"�V��V��Xʰ7y��~5��\�l4�g�{��}�o~��S3���n��t���x��9�M�:�g?�[�R�={CO��a�@%�9w�ew��4�h��Wm�=��I��˪y����rMu�&Icϙ�K����z�}6�����t�G�Ԯ���;]a��/{i��&�Ϗ���t�*��*F���d�ŷi���cۏ�	��.����ԙһp���k��o
�QE��x��3;����J������%�|�<�sGUq�<������d���W�v޾<�lp�H�Ȱ���R?�v�����Og����E�B�AI?ܰ�|7]:�a Vm��x�j��(�Ȥ�����xw�S�W�y�� t�g:�p���>��1*h�,.�*��?�y�Ϸ���Å)QQ�,>�H<�%���u:�u����mp�K�/ȭ�Ɉ��!R���i<g{w�V�Q����_A��~̎��Ә=�3��m~�<�l�{���Yjٯo��7�x���������aN2����<w�Q}��;��ߘ���H�O塜,��M�Ñ�ޗ���j쀒�u3���aKCd�j���^�!Z �����a�e�*C7�@����k������y��tJE�.��`ۢ&[�ܛ'2���:��:v^`��k�    ����x�������<���7���<�y��"Q�8��w��Hz����ĂV�?���< o�&�s�믑qUڞ/2�(⇭#y��N.�^O�{XDci�J�Q��Rd&����x��I*�u�ݐ
�(E�������y�������ra����~y$�z����u�h��`Bbm}��n�NL֠��
�t}��)=�8�U���^��~���x���� ��d&�A�=]�C��H�O�d7$��%˕H��9�Mƒ��|͊�kI��>[]X�B��x��v�2��x������*Ӥ��z��!�O^�QQ���t��Jr�Rl���x}9���4`��]J�Iߪ��b��ш��Q���#�G�F�$����-ؔ�_)�$]m�U`)�����o��O�
F餸�1Sf�;��.Z
������f�}���������f��.[@�x�\�ni�>��Bq%��b�z�U��+4:��Gly�:����e�VR�f��z��ĺ�ȅA��q(O���-��.��ڽ9.�j����Dl���+e(?=��7��@b������<4��B0r_|����=��BU|�8E�9�(v���M��%���k���@�-'c���k69b+��F�BH=0���a\���p�,������ ����S�V7b�l{*>��/��5��b�-�Ž�����JF�"�`�
�Y��#��w�
5��p.������˙�l����
���OJU�Ps!W
ѦK�����fP3�W���/(��_�7`Z�QB�{������-C�8���p�t��J��Ϊ���I����D���_M��������v�1��L/]�]$��1�W��-�����<ݝ�o�ןx�rj��m(�1��쁕�6J��.���	��0�Z��h�� �@��xX�4�I����կZi��q�ؤV3��*M����� ��1ҟN.�z��ئU3�W��SݵD���
�=O�u�c���"��g���k�Tpr��X�.�J���o(NKY\6��T |��]52�F	R�·�,��l.��K�*N$��3�ךX*QE�e�M�����H�y�s^�ʾMt��%�-X����S�d���@2 d��v��M�8CjM��"H�U�G�e5n(����wA�lל�#b+���L�4�����;U�U���7�IgH�	�O���D� ���8.�����T�AR���@2���$��M�'�-��[ܪ1]G�!	��:%�kB�ZpexWn%g$J�7��6n��D9��A�?M���z]��BaO�/Pd�,�����q�C~��}�_d�-��dt�+&�D8�@Ur�������Ȇ�s���5IHΪ5B��·�A�hv̰l�U>ӗ�P9�rd~��\�W�_Bܧr|���}k�;T�E�� LM$�O/?-��`����;�A�¾ܳ$�
�w�����*:����������t��N	P7JD��gNa**�mQ"'���r���$�vO�  tm�le�k`bI �qM[ ���3�tW���aMW0��x?�X9���@�j��J������$6�w�@��x ��;KEl)b$�2��E��a\�Ƚ`��S	_Jp:�r+"T� ��ci�<���wWI��2�V�d�.�6��jj.c\����	F���B:�T�hU�J}��j���H���ǄU�v��E��r�����������<{�}�XXU�����R��<��N�b1�ULQ���935��_(<�jVH��9�P. �̒�������V�\��0%��?P6¸�ae[��i�͓�?�t�If�&?�!�A�ze��tƃ�m�H�D%�҄[0�J��!�m��*+d�($����G����|�@!	S+o������Y��V!��
9�cP�34�<*�FI#i6CĻ����Ͽ/U%%�-�_>-8�"�ၒ��������FR�Y,D�8ˠܝ��=��Dŉ����(��W=�B>,�)B�\*�j9Tnq��=;p�k���P�������
+�Z�6��E\-"ｨ"M\�K�R�!^ijnҁ��Js�������.P�F&f7�����Hs�0r1i�s�fw�#��E��O��|�\����W����;�v8<����	|�����v�5J�T#�쥚o �:�����@��^ʑ�֔$�����_��	�+�H(60�ҷ�����}ǰ�y��M�v��x���h��H[ӓتq?8_��S
$THW�3������`0Xng+xos;z˰a�Ih�x$�	�q�����{��2!r�>n1� �ܙ��EL];?�>k�4,��Wc�ӿ�!8Cz�y���*u�!�ʀo
��%�>_�m���P��`p&��mZ�rTK��9��/ g��;�U���$D���zn³��n���5+<�}ǔ&��@;T�,�gcր�����{��S��
<vy�(u!%�1	
2r�o�@���VY��̕A=�>�����;_����K�{f��n��FƎ�C�Z��S���ͯ����\��L	�@��|vQ�6e�xdAZ;l����-�?ߏ_3*�b�����v�aa�M,������q�}7��m�����R+���r�V|T��i���~=M����n�=�d
����[Ɋ�r;��Γt��o����A�dGE�YA��NI�t�9��p<�\��4�7^�I��$�ܫ6Lh������xɣ��x��4�y��j൵�d:��d���|<�w�S�?��d���w��������g9���x����Tm->�-��٭46m��L��	)@p��d<)rEՆ��|��J��7�&�}�I���p��j=L;��b�V�6OOw�8�����D�FEJULp�|�_������4.�/�=;߀��'R�J�%ʔY�b��h��?�_�ot�$�zDk�k��бmpvsu�����6�3�x�'~iYj�����uM={b�.ݎ� x<��t����}W���߶�%͸���7?���qn����YVNh��.o���x�j�y4~T@[���Z7��n���_�{L/�!��p}y/�<��e*�q�J-i*x3���t޾���t��<��2�ޕz�k�Eu��9l^������N�.݇Q�l5�iΆK~��<�� %���c!D��[�5]���'������y7���?*�r�f�6a�z��u}q��;xU����%<�y3�/҅��]3Ⱥ�p�i� .L�X�8[&��<|��q�6~��b�����4F	H�3!и�I���s>���"3�R���n_��nڎ)�K��t�����x�y��2��(-@LT��H�'��.2���h�oGhl��ZiC�Zv��<\�SVS8�vɢ���"��Q��v��Fn3�,��G8�����-�X?z~�Ot6����M�"�`�7�~���[8}l�r���څ:��'�����r���������Lh�WfZ7o� �m�v{<��>ћ݇�x�-��C�Ug[c�����ᯎYEJ����1�!TIFm�gG�������[eNG�T*6+��@v�8,�N�}ۛ�/��R;)
�;��3U�>�pu9f���lFM�sqj�2^���2�n�!'Y�C_efveY��wv�

�����2Od���>�,�z�v'���CioGH��Pg�4�T�4\��GWq*�k��[ ʵ�g��XƢ~��BX�����t�zQ��ft����]�즼�X��jGco0�������C|���v�ٴ?~�,K毰L�^��ۘ
+n�؁i���	�0��J�C���O��ϧ�a"�ȧ���p�x���0�����Og����CgB���
q�����O��1�}���� ��-latIz,���A�yz����@�,i��ׄ�e�Л��φ��?|̲�!��n��O��zI�o����q�}�?���n��u���u��]�K1�4sl,>U�d���JM��'��7p^�B*�1
cT�I��@V�8tq�9�v������!�$�;j�Pz�{Ke�u�3'�v�����L��B�E   �ӕ$ �)�a	<O�}�y��D{`p�w�WY��a��}z�����>O��hxq��T7q!")���(�����apY</o	�0V����?y~��g�������j�h
anhfعe�J��W�s�Wa�g�����]�H-�Qy7}��[4!�5�d4*�

ή0y`����������y���j&U	6A�df�&-���?�
k��_�q�!���g<�!F�>�-��sM�L[�e��o_�.{n�f�B�!�R<������ͯt�q���B���ٹq&MM5���-4rw��$�X�x�����+5���S���#ܔ�wf�KZ��a�E������b�xR�Bv�u
T&���m�D3-|�y�����ݗ�˂lY ��z�҃`%h6s�~������f�n�_��}�9?@�{��'���fDP����xz����{8��ֻ�Qg�� Q����¼�x�;��=xpyy@�9Ϸ��:��o�4��]>�Br�F�ϳm��<h��u^����O�g�V�!ԣ�xJ�T,l��A����MR=�I��پ?M*Bcao�u�Z��~.��yH���ZغtF8b�m�(
.���[���tu�.���<�3��LW�DI��OL1@a�c�.�:2�~ʭ�JF�G�u�ڷ�"�B�la��_����g��ji\�&����V�#{�)+�ְm�����"ٵ�3��_�)�\y����W�?���5�*͓	��"\K����iR:�͛8ĕ���:�ո�f��Ԧ����{FF}OCt8�1�2^Rb�e&�-���o��6!jef�=���F�����g'���ƀ�r���\��Q��QJ;h���3N�hu��	N0���9��?�G�[�lJ�s���FH;�	opt�a=7na2��e���]�3+�͐z)9�u��*^���JoǏ���xȎ��ϟOp�,S\�%�#���fn�������]�o3��x���`�&8=#�#���L�]�������0^�G���:���3����ۻ���m��NG�Ը�t_~����f�w�&hL�^����t3�{dDŰx�Y����2���I"��7y�.2xJ�ˆ�{p0�J�K}�q�Njv�����}��~(;��N�q���n��ɋ';89,#^����<D������:�=y�$��M�]zs�g�y�[�Edƨe��+!@��a�3�x`���2��$�"K���1�u��3'�Wޝ6Ivl=��m!�L������#�xE�w�	Q&�0��ݼ�;�Ow�l7��=ޏ&LzAf�l7xC��o��;7p�e.�&2�h~�s��Ι{���������ʎۿc���l��C�Via��6Ds���X6���&3ίL�6��>��$=Al�w#���"�s�Z��vJL�i��q?��y?fI�zK��@�K0z(�r6e���ȣ����l�������7�vw���	B*�;�J��@��i�{�?gF��[tv�5��,^O�Al�������1}�X�9�c��x2�@�u���慽�>0[f�O����U�ޔK����t��0�4�oKXz��������=�����o�˿o���.�w�%����
�w#��6��f�����H��$�Ht i�>'���Ϙ}���]���/Y�u��R�0��eӭq�f�w�� K�u)kD4���X>���;f����x��d_ҵ6�V.q7��tD�o̤8�H����}^� �*�Y�a�i�,Fx7!��������["fQ�Fdٞ��kA�xE�\k�~�^�+qnd�a���7��J����ݪ@I(e�\mg�d��gu���n��#�4;���%GW#%~9E��r�U1ipd�^2)�2���?�L��+l^�e?�\7��N*"��xJ�Z��Χ�zY����f����׼Ĺ�~~�7�K����*A��L��ě��,������ND|5�r;8;�ء����e2i�/m�q�|�k���>c\�+q����� =�B(�4�����{5e���d8)��C� ���QC��ԇ:?�v5f)A��=f�8Ȼ�� #o�TUx���x��:��vUg5]~�m��������,����%;�t���/�8	�T���.��M�;��.#3�Ӏ����l��G�mË��3���~������[4�D��\:p����e:}؏w�#C��s���ǀ��F��DR]#��;�����#O����X����Q�����O���6��a�Ph�W��>i_\\.�z7Ο�y<=����?BM��t #��I=�s��u��h����*߳����P2s��\ży���5d����W��<.��o6p{�^�o���l����\O�E���*������#�5��l���m7ؤP�ݏ��.οځ�72��6�����q���x�Y��/p���i�F<Ě�/�}v�e�D�Ӥ��fߗ�V�@=�;��0UZ����[�ȃ����=��?ʏU�B�[��pM'l�A}u/B��ֳ�� a�l��Ư&N
����h�%���ڒ��9r.�����z<�"����Ԉ���m�t����CΠ9rZw�F~�+�^}S#Z�)��ˏ1��Rx�F`��0ݴ�b�*ϗ�-=��M����*7-2�j ]�h�³/ t8�	���_���#�Y��*_��ϣ�#�䰘U���hv�c-��g�r�G�����J�y���!n`_��l<�1�+���Ņs��4�$4�m�������c	�W|dx��o~��3,dU!���[w�_�&K:�8���������U���gǻ�
§f���(+��O��G�q�}�vB�R"���BqZ�>	�z�^��JZ]r��o�K9�2�aQ�j7K:U�o.^z��{��"�>}�[�(�PV.����Kx4l��e�~w�g���̭w ��Ȅ���{���B�͋���.۫��\�������*� ��/ݯ�f�l���6ؑAN���DX��j�c�3�ÿ����	��H�Dw������N}&=����&@��¡@Q�<�և��RŃ��k�7N�:�*�1�)
?{0lB�][Jx.�u	����P�8�bXs�Gy{�,\,�W���B��H�-N<̺��qE��#�i���q�/�<Gl�R@�W�wp��@T1����V����n��e��r)%�XMI|�׼�7g e�R@�S��9��㰞��i) �H��'h�G]�2FKa���2����W=���~=f?�7��������x3^v��cQq��� �lpY������n���T����f�BG�?��ǫ#����=�<0zvBdd���|�#(�'Axݜ��w��Q��<gk$�����,����;~8��y;��bbL��#��A��ֹj6$�r�ɖ���cnOE�L�ك��ȳ lA�����3{*F��
���<%>��F�`����Iu�6J%0��e��d0iG�y;?�=m)M���wp���e_�p�h<��0�f����S����х�nu�����������@�� :��d��JI��c�N�ڠ��bq/��n�/�*p��ӄ�B����=�ك�����˚����I��yteZ�ˆw��+��,^�Yh��^� ����	S�����s����� �aRL婬��>ec�J�Ƿ�YYʩ\����kٕa>�W�׷���@pX�*>S>�����3����;~=�aq�0c��=�J������I�	�� ����2��Q�*a��>�JeaP^�^	��E��Q���Ϟ\�����c�QL��՛�ki+|���V�燩�C��:��kF�y��QW���UwG�]��$��~&P�a�����d�sJ�`K�@�ĝ޶��������W��         �   x�U�;N1E빫��{��6DE�)FJb�����8�{��X�uγ9��~��	9
�hȎű�:V4ǆ�ر8.`
G��������2�!fC�
��=;\�(P��@c濡E��e(
T�(P����:�/�m��_ۺ�sq���F����};���A)���%�G�����V����MךowX�,��?������;r���Ȋ�����k�U            x�uZ�v�Ȗ|���y��rڃ�Ҽ����U�����U�$�e4%$�$좿~"�N�]ݳ���@�Fdx��M��cmMۯ��h�.��7�CB�=����T�G��F����Ջ5�Gg���ݲ/�ڛ�11�nL�lFwM�xg~��	���+���6 �z�y�~
k�?Z'�v�y3?��|8�u״eo;���a��Gý-_j~؃mۦ�.�+.���Lm{�.JS����ư��aK�O���p�� ���� p����rg�k?�3���fc�λ񃈏#��g��W{�~���M�]gVֻ�ϓas[����]gw�w?HiL��k�Y��2>Ͱ5>}(7x�]�*�zs?ȱր~�0���a�~P�!�qSv�ž�x�c��n�j���1@����k��m;���0p����]o[٣��!1��<l�Y����dtJ�"6������z�~�����v����c>��?��BB��=4�W�}�Ä��y�bW/_�=��S�R盹y5/H�	v�ѐ1��b��uY�|z�9��m�����'N�~X�T�Ty�5��zv�GcX��kw��-��B9?�#z.�w����+~�l�GL�h��#���������"BG�4M�`*\^��+܅�f��ϟ�(�u���wv�/��Օ�4�:-�_�~}�Ge�1�f1`���m7��nn�('*w>�,�MY�EO"���������y��R�Ж����a���E���/znZ4��;?f㐗�����Wy����� ^Ro�k���m�ѭX������e������jT�Zq�|�Ǭ�8v=��\�Ã'�%n{7e�B�/�}��яٮ�tؗk"�ӓg�dnOWm�7h��~�Ӑ��̭]u�<���qA{��M�l��ׯ~2�/�!�/��o����2a�oᘵ5+u��s�JHBB��Κ%v_4#��xk^V��d7;EU$tW2���f��^�)��NQ!	�/a&~��۶F�Ge$̻��^r�d'n8G]$lmI�ޯ�HD��O2�3���ʼ�O~6��(���?a�N�Y��1��(����pN>3vï���H�Hy�ޙ����W��4�=p˚��N�؝��y����r���[����f�\�iDc��~��e�ܢҘ�حI[7V�jG|�ӄ�)M�j[�����<�G�� 豩i���Hɺ��P$w~*M.��fmS�%Z��1��R�\ ��q2�s�Ր��w���.�(�l̡���F\5�$�,;]�~�ʗ�u�����g2]3:R>}Ln)��H w�^��+j"�E�~��|[J�����m�z�ߦ�≟��lHBL���⩟eb�p���ԣ�[�b�5>���rAѥݵ�~�i|�g�`��{�jk%L:i|��c�|�����a��3?B��*E_�����۷fS�����0Eb�9�WmS��]+���@�$=mMYk���-���D �Р�i6^|��)�_.���e��K�/���L`�s��������y.�ܹ��%����`�w~^�p��;��w��\��N$��ZW|�� ���6"�g��7�_S�x��/���ջl���`ć.x�_D���^�в+9e�y�_Ă ���1���l�2k,��H����w�@��g�Hň��)I����L�����caz�7��I#���ܗ�4 l��'�(1��6�INA���W	��V|uZ5��K���	>���P6^rP����8dUy�9 �B�Ԑ[��ctC/���?uGY����DQ��Ӳ��\�u���h�?ܕ����"9�oI87F���
��@*�sEs���t[n�dȆqAv5_��ɀ6K�N���ږpY�#'hk�X��/�_i�^"���g��M�vY�-�J (󞁔M/��K 9��b&#8�?�!z�
�$�A�\�Ai�Zd#vE��D�rݼ4ۦ*��'X2J`HA6�R���7�r���gͮe�g��V\�3 �X�W�x�W���>
�	�ջ���@�!��2��/-���K'0�jd�����,�)Fj"!b��6�X/E*C��[	�&풻�)kd��"E�?�NY7�ᖕ�11R$8䇘(Sn�۪��B����3�7Z�F�o����y-K��L��JBk>D��_��Δ֤�t�A�j�2��R$(]q�q?Tir���@&o�9��K)p#��v�tL��� b�d�L޵��S�_*2E�A��㬞�-܇Ć �0]��U��t�?M]z)r�D`���oSgee7�Hc�Cj�I�3-~��)�D`/O�ʌ�2-����,Ƞ]0L�u/�AB�t�0o����lH��|A�U�[{)�;��@�BbP������Gf��{2���uC�ΐ��)[�ޯWo��z�"E-Kn��x��+;��!�!Y�r{y��r�62k�"rj�@��ߠ�� �El�wh����||�0�P?�/bO��U�9|ĩ�kO�j���������^�aЪbN�{���E������D�,Lc�����S�eH|�8ȠW��[|*����x�d�<̶N
L��|ݼ�2�;����P��5������+������Fld�r-�'C�Cψ-&� ?��r�e�B���(�w�+u���� jxƁ��Sw���DAW%����z�I���>���r���NB�"E�X�{W�n�ɀ����tf�M����nj2��$$q��?\���  RE�WK��8��L����/"ya�`��F��0�m˾����j��pα����fpR�d�"��s�ө���@��(�P�,f3w���z1M9�)D�sS}���"g\�5��BG=8���[��L����;�k�T�;R��F`L�[��+C�J�&�����baQ<���db�$͗릩F�vW�'3�1b?�y�VCz�Go+*����hh�i�&dT!f��܋;����!d8���*�Q��r�-?q��"�Z�6ۦS���_ȈC�(nq8�"2޹�8�}�`H��QA��\�Kmx�#�KH�Pb����Lbj*�R�X���ǙD�@pB	1&0��!������!� T�х�)�|S�~&��"����|8���a;���?�����>�"�c��,V�1�����@!�3�b���6��oS��"�~m�4-��;�1�P6��y�]ĨB�ȳ�Q��m�[��0#��5j�9����G�1���4��Ӫ��Q�PW�V�=�Ͷ44~8vNd����v��v�W��9/fK���v����]	44�!/<����;�wf6�]Q�5��	�-f�8ڊV;��䰘Q�k��5��-K��m��ޏG_����kO"q�p|1��@�u�:��Q�� ������tE�C��)}v'��
��r	t��Ϧ���!�$H	;ƭ��vm��$o����2fMk���3�a��/$n�U-�4F��:�*de��\��1	�����o��QcI��y:�r��R�=o1j�z�b'��Dܭ��;C�Y��Nm��^��!h�oz�=��� >�eA��|5H����ż�Q`����@x��;������+�O��\b�BB^���<�,�S[5o�B��@��Tr㿊q҄0��)�r�b�N�BH�$ f㬲�6@9q�򚇈����l�C��ėK+�!�q9�q�a̦�F�tP��b(�����ؓ=�h�
a�MP�:$!�}���L��\��Tw��F��@�E�¬^l��!�ԹAxH�;|J�gxHSwJ$�(r��8-_ȗ_�=���1����w������J � "��	�zmv�0��J��N�y�$\"��D�+W/J|�mt�PXN�[ġ�<�߭p��
���Gvva����p��J.Qmȟ�l�����K0����Ɇ�A~�9�����8�\[ҍ���F�e_ɰG���	ya �>�r���o���,�>�ٔ=���0V����,i�^^ٟJ*�X}M�zӪ�H��NE���x���]���/�U��_�a�PD��(��t��ځ��ʱ�����M���� �  6�n_�6�ԯR�ӛ�1>�����n]n	�3���d$`UY����=�"����j "D�ѭv��h�;�\����t�n�%QK������07%��s�T���w�åz��ߡ�)$F�H`�����%��#�AnJ�S���P���Os�%U�Fِd�z�L�:3���#�(D���D�ܸ5�#��6Tī^���|w�u�Ċ�~���$�����-����%�k��794fj����x	ƚ��觰�j���F��C����������ᐨ���> �@m���Cӂ-Tk�f�!wW��-ٽ�X1F���"D&,�Yez�JMK�r��+� �~JB��g<3�yNS�LB=�����U���&Ȱ�}\硕Ә����o�K�,M�6�b�u�	`���_��
]JCB4,�ke`p%���.�S���W3^3ўׄC�;+��#�Qz�ep��%�X�_Z�r�u�@$�pC�� 5r�T!B5������d��Tf�\�1�::W_�2�����×��R���%�Z�
uY��s����/���?w`Q9�g{�O�'�����ؐ?~�M{��B��|A�B��o�oz�����x<�����w�we�A��[X����SS���T/:����ΐ��w�W5$�H^Ֆ��w�_~�_�Sy\��?S8����);"J.lwC92���/gO��"
W�]Z�5���P1�w?�HH��#��Ü>?k=x�z,K�^�|�n o$2��8�A7�p�0����33�=��G�[����Cz�Ke̘j�JB�+v8��Û�މ�H��B�kg�!�ʇ9O�'�Y�k^�9��x��@1Ïj���=�!���*��To�����5E
�0����2��PC��؅P���R%�D��z���k����^�"�!�z�*5g��G�O^GW������i��s�j�y���7�ͷ���?�L�I �,� >( ޴|i�k�|C,�X�#Ƙ�?��?��*�������D��
'��^ʞW6γ�w�ƭ�P`!`w��iw�I�Ay�V4�"�K�V���Q@���]�]=�<>a4t�fe�Rѩ�:f5��w�3=Af�p,7,;9Wm�z�H%��	��:�}�� �y�S         [  x�=�ɕ�FD�f0~l�����U��9j��HP��iO�믞.�Ż��C|�O�)�ěp���#~ď���W����+� ��a<�%�k+H�jsyIn�@Aҵ��P�\��rYn�|���zE�k����z��:�<5̆���Rp���5��x���W�����-�}T_a�(���6z�c�1f�ic�X��۲�w�	?�7�����Q<]8��G���usS�Q<�S�Q<�S�QC*:���xf%�đ���+q'������{���c��]9�rtUb�n]�n���G�������w�6_id��7�5?ɬ����zN���Ť?I��$����\}D�%Vb����>Q�
_�;|�k�^G����ז!���P�1�=^�	���Fm�A���-�P���6�1��s=�E<z𥊊9Q�����ܘ�`̃y1o����0 ��a6L�6�fGu��Ǩ���n(+3ؤ#���э�b����V�Q5P�6��f���n@o�@
�>�[�6h{�'u����L`8�h��=-r��֚:0�i8�צu����F�@�or�Hi��2L
�	�s�?��o�+tc���w(t�pH}H}H}H}T�?J�����ЁL`;�׌o���\�Wo�����˖����M�\��|��_����ӿ������Z�.��N�S���N��~]_@�өt` �C?��-��BZ�\��,���Z�5��I�Ti���N��B9��~V7���ʅ:�9N�O�#�ҿ
���ft�ڴ|$-���5hI�u�Q|�����5:t6�l�٠��?��w���������(�N�N���?�d���L{n߹�y�ОP@�2��ՎI�E�E�M�M�M�M�M�M/�,�,�,�,�,��G��v8w��$ӊf��Y��CO�vs���n6pŗ�݌y}�k7�V��Uq�c�q��0L`��B���{9|K'3�w�����y0�������K���6f�l��Y���1;f��s`N̉91��\�LԘ�1Qc��D��5&jLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLTLT��������         �  x�-�I�� �p�~�$����)k��d�Qx��E��>��{�W��}9�ں=[~}��i{1��-���ks��{����l�plG�#��msiT�����}e�l��m�B�D<�%��?Y#�}�7>oc�5zL�#ډ석e�ە�q6�=ܻ����cה�
��X�\�&�W��_=}q ��H��l��e�{g$��s^wҟ=�V����{�d���p|9�����q��q�����~���󄪏�yR&����������iqw(r}�7h�KM7�t�=r�n�����'�����mY-�!]�����𻎻w|<W2ھ�T��l��,k��<>Λ��|�2��m�=
��p�pj��e[�	=�����
>AN}0���eu���t๒7�٭ ��C�l�O+��#)ܘF�����n��{��� Q9P�,�A,�?FWr<*9%�0>W �bi�J��'���0�>�xr��i�!�I��r�%��Y��=h�����A�e8��(Y�˒mk0����yېj��be�ja;
f��`!�R.0;t�|%,�W.�\ ��t��#��y-z�Z�2�(Y̪dG��\�zY��d*5�R��<��^��=�:��5�h�a6��r$=�v��������*��/����i�t�������x-i�X�> �Q	�*�4@������r��P�sd� k�>5�unU���	���:X�]�q������O�zV.`�ʭ=!������l%`� �^�l-Q9ւ�^}�vɩ�2�V������#��*�^+�E+���U����˖>�͢D����?՞X�ȵ^TO�	ݼ��w���pU��dɶg|򺨼��~����Q��0�����㚯_>���SO�f�h?.���O�Ǉ�K�����-���??�����{�cu[5         k  x�%�KN-I��Ŵʟ̴������q*D�@B��~>O̓�y�<o����O0A���5�lz����}���p-\�µp-\�µp-\����&�B
G��J�Aj�Z��Ej�Z��Ej�Z-����B
G��J���-�W���ݟ�����j{���^m��Oۧ���i��_���PB�Lp!��(-J�Ң�h-Z�֢�h-Z�֢�h-Z���-}�\��]�e-wk����nm��[ۭ�v��k�✄hK_�2�gy�����ncpOD�e.��m�6c����flsn�k�✏����/c�˳��-�1�a�sN�-}�\��]��n�n�j8�!��Q�D]�P�^ͅ��<*��\����*ԫ���!G����RT�JQi*M��4���T�JSi*��>d�Q�D]�P!*FŨ�bT��Q1*FŨ8��@���B���JT�JP	*A%���T�JRI*I%�$���T�JR9T�C�P9T�C�P9T�K�R�T�v{��%yI�ct�C�z�C�9
��ʣ�<*�JQ)*E����RT�JQ)*M���s�JSi*M���V���!G�t����i�Q�^�%C�%:�"*FŨ8��T��Sq*Nũ�V��������3�           x�=���(C�I1{���^��:�J~3?V #L�HF�_�w��b|���m5SO���n��^��]#c(s���l���MR�)ǃ��>������b�yh8BK#����M�jc(�{Ŭ/�/n�u���ks����&�WQ�����T�\b������I�2'Q�����i�e�5�O�ꕙz���q+*i��c~+Q��]F��;�z��]�D���=�g�Bݠ.����vR��0��u�k�+ޥx��:�Z7͜�t�)���v�vwj�<N�օS��k�k�L�sq��M��x\�1���]h�w�ʻЄ�NEfݩ��V�M��o�J�2�5�������_��}�������K���Ṋ�)���� j��(p��\�JY�@��x��[�̂S�P�� .[׀�d6��v{J@�jN��^lc��&)2�8�-��)�c0gfuS�.�?O����M��N�6��P��K�=}�Cn"�v�@(�!z;װ�Z>���&$H$kU�	Y�&�;�y��V�V�jy���1Т"D��v	�qbz�dm,�t�MA8%��*WZ̖��|��.��y��-
�o<^ �0�)b(�S,����O鲆�q�6�Q8�>�Hݬ��x�BR�-�[���g�
SWqU�d����H�mc����g�@��Q��[���onf���j�@��o&���XF��U����O���m���ʢ8���gHݭ]�źԯ�jӁ�h�v`x�Y,h�P,�Xк�3S&�᳆�9�@冪e˪ZP��3���@�Z	E;�X@��URV&Rv���U̮b�r�y��%�[ϥI�t"fU�ULKKb���YYVI�#�ʎ���@�G�e4����~���m�����nm�˭:���G�kd�������-�[��*{u�=�D��4jW��]�u�w�J\/�L3{��;�+��>��1uW̾*ed��Y�~�?����.Я<C_�J�w�G��t�+�G1�b�^9�oz\5����ߪ(T��VϨ�(;��������G      	   f  x�UUMo�6<���轁�?�����KR�6�K.��X�)2�������?�`@3&�˝�e��m��Y�6���t<��v�OC��$��0z˳�U�����V�l!�Az)�F��$�'�Bx�ʊ{�u�:༚-�1�����q�� �<�c��ZZ���Q����S^[%�^����)[v^b�Ʀ�mٕXv�`�1<�/Lp_X��ڨ�������X趧k�%{��J�J4���V��:��Gc����
��@�'��w:��H��T����9KL
�{ݜ�{�8$�؃�U�x�INX���K�?��P
9b����oe�<*�hΓ�8�f�8@lP��Q<�.x'�ҷ<�ٓ��4G�ʘ?nj�,e+�U�����hi�V�}~z5��}�%9�����2�&rOK�[i�V^�^��<�	w��]S�Y�V#�}9��,fkE�r���,�� mg����K��#vg3څR���͉g9{��ī�yVԤf�Pʬ]l�U��uV<i�v��el`�4ϣ�������1��� b��/7O�����?g�b�Z�򜽨���x^ �a��W����ō `����J���b=
W߈_�������F"^:��zx� �p��Hgԡ�/��Evc�e�X��W�'�4=�(AQ�Wm`;�.��%{Sڈ�wtHuA+���5{s_�~�/#��#;�	���O$A�̄�H�+^�l��p�u�-��ʬ%B��2�pKqE�;�ΔCY�M����]V3�_b��,���7���e�����UĶ���!�X��W1�t���@�x���k�BW����T^e7ʸ�ȉ�O�T�� ���h��Uɶ�0�\b77E����jܪf;�C��I�:b���B��TǿI��������b��:�1���_�J�ݸ���U��2١��Q����6J<�-�Ѻ$�F���jf&�CRԚ��a�b��Aa�G�zT��J�1�<�v��0a��& nTO��_��]��x�18�>�'�b�09���h�yP��@0+'��A�-���9�W{�z����h"���0;[��v1^�7M����J�n��to�kr�4�5\J�Ç�q���R�     