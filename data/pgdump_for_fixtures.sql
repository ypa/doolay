--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.8
-- Dumped by pg_dump version 9.6.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO vagrant;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO vagrant;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO vagrant;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO vagrant;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO vagrant;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO vagrant;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO vagrant;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO vagrant;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO vagrant;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO vagrant;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO vagrant;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO vagrant;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: blog_blogindexpage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.blog_blogindexpage (
    page_ptr_id integer NOT NULL
);


ALTER TABLE public.blog_blogindexpage OWNER TO vagrant;

--
-- Name: blog_blogpage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.blog_blogpage (
    page_ptr_id integer NOT NULL,
    date date NOT NULL,
    intro character varying(250) NOT NULL,
    body text NOT NULL,
    image_id integer
);


ALTER TABLE public.blog_blogpage OWNER TO vagrant;

--
-- Name: bookings_booking; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.bookings_booking (
    experience_page_id integer NOT NULL
);


ALTER TABLE public.bookings_booking OWNER TO vagrant;

--
-- Name: bookings_bookingslot; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.bookings_bookingslot (
    id integer NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone,
    repeat text NOT NULL,
    repeat_until date,
    booking_id integer NOT NULL,
    notes text
);


ALTER TABLE public.bookings_bookingslot OWNER TO vagrant;

--
-- Name: bookings_bookingslot_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.bookings_bookingslot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_bookingslot_id_seq OWNER TO vagrant;

--
-- Name: bookings_bookingslot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.bookings_bookingslot_id_seq OWNED BY public.bookings_bookingslot.id;


--
-- Name: bookings_bookingslotrequest; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.bookings_bookingslotrequest (
    id integer NOT NULL,
    request_date timestamp with time zone NOT NULL,
    first_name character varying(254) NOT NULL,
    last_name character varying(254) NOT NULL,
    email_address character varying(254) NOT NULL,
    group_size integer NOT NULL,
    message text,
    slot_id integer,
    CONSTRAINT bookings_bookingslotrequest_group_size_check CHECK ((group_size >= 0))
);


ALTER TABLE public.bookings_bookingslotrequest OWNER TO vagrant;

--
-- Name: bookings_bookingslotrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.bookings_bookingslotrequest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_bookingslotrequest_id_seq OWNER TO vagrant;

--
-- Name: bookings_bookingslotrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.bookings_bookingslotrequest_id_seq OWNED BY public.bookings_bookingslotrequest.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO vagrant;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO vagrant;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO vagrant;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO vagrant;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO vagrant;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO vagrant;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO vagrant;

--
-- Name: experiences_experienceindexpage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.experiences_experienceindexpage (
    page_ptr_id integer NOT NULL,
    introduction text NOT NULL,
    image_id integer
);


ALTER TABLE public.experiences_experienceindexpage OWNER TO vagrant;

--
-- Name: experiences_experiencepage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.experiences_experiencepage (
    page_ptr_id integer NOT NULL,
    body text NOT NULL,
    image_id integer,
    duration interval NOT NULL,
    host_id integer,
    place_id integer NOT NULL
);


ALTER TABLE public.experiences_experiencepage OWNER TO vagrant;

--
-- Name: home_homepage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.home_homepage (
    page_ptr_id integer NOT NULL,
    organisation_name character varying(254) NOT NULL,
    strapline character varying(254) NOT NULL,
    copyright_notice character varying(526),
    featured_page_1_id integer,
    featured_page_2_id integer,
    featured_page_3_id integer
);


ALTER TABLE public.home_homepage OWNER TO vagrant;

--
-- Name: hosts_hostindexpage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.hosts_hostindexpage (
    page_ptr_id integer NOT NULL,
    introduction text NOT NULL,
    image_id integer
);


ALTER TABLE public.hosts_hostindexpage OWNER TO vagrant;

--
-- Name: hosts_hostlanguage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.hosts_hostlanguage (
    id integer NOT NULL,
    title character varying(254) NOT NULL
);


ALTER TABLE public.hosts_hostlanguage OWNER TO vagrant;

--
-- Name: hosts_hostlanguage_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.hosts_hostlanguage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hosts_hostlanguage_id_seq OWNER TO vagrant;

--
-- Name: hosts_hostlanguage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.hosts_hostlanguage_id_seq OWNED BY public.hosts_hostlanguage.id;


--
-- Name: hosts_hostlanguagerelationship; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.hosts_hostlanguagerelationship (
    id integer NOT NULL,
    host_languages_id integer NOT NULL,
    host_page_id integer NOT NULL
);


ALTER TABLE public.hosts_hostlanguagerelationship OWNER TO vagrant;

--
-- Name: hosts_hostlanguagerelationship_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.hosts_hostlanguagerelationship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hosts_hostlanguagerelationship_id_seq OWNER TO vagrant;

--
-- Name: hosts_hostlanguagerelationship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.hosts_hostlanguagerelationship_id_seq OWNED BY public.hosts_hostlanguagerelationship.id;


--
-- Name: hosts_hostpage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.hosts_hostpage (
    page_ptr_id integer NOT NULL,
    body text NOT NULL,
    image_id integer,
    email_address character varying(254) NOT NULL
);


ALTER TABLE public.hosts_hostpage OWNER TO vagrant;

--
-- Name: places_placeindexpage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.places_placeindexpage (
    page_ptr_id integer NOT NULL,
    introduction text NOT NULL,
    image_id integer
);


ALTER TABLE public.places_placeindexpage OWNER TO vagrant;

--
-- Name: places_placepage; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.places_placepage (
    page_ptr_id integer NOT NULL,
    body text NOT NULL,
    image_id integer
);


ALTER TABLE public.places_placepage OWNER TO vagrant;

--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.taggit_tag OWNER TO vagrant;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.taggit_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO vagrant;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.taggit_tag_id_seq OWNED BY public.taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.taggit_taggeditem OWNER TO vagrant;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.taggit_taggeditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO vagrant;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.taggit_taggeditem_id_seq OWNED BY public.taggit_taggeditem.id;


--
-- Name: wagtailcore_collection; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_collection (
    id integer NOT NULL,
    path character varying(255) COLLATE pg_catalog."C" NOT NULL,
    depth integer NOT NULL,
    numchild integer NOT NULL,
    name character varying(255) NOT NULL,
    CONSTRAINT wagtailcore_collection_depth_check CHECK ((depth >= 0)),
    CONSTRAINT wagtailcore_collection_numchild_check CHECK ((numchild >= 0))
);


ALTER TABLE public.wagtailcore_collection OWNER TO vagrant;

--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collection_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_collection_id_seq OWNED BY public.wagtailcore_collection.id;


--
-- Name: wagtailcore_collectionviewrestriction; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_collectionviewrestriction (
    id integer NOT NULL,
    restriction_type character varying(20) NOT NULL,
    password character varying(255) NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_collectionviewrestriction OWNER TO vagrant;

--
-- Name: wagtailcore_collectionviewrestriction_groups; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_collectionviewrestriction_groups (
    id integer NOT NULL,
    collectionviewrestriction_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_collectionviewrestriction_groups OWNER TO vagrant;

--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_collectionviewrestriction_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collectionviewrestriction_groups_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_collectionviewrestriction_groups_id_seq OWNED BY public.wagtailcore_collectionviewrestriction_groups.id;


--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_collectionviewrestriction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collectionviewrestriction_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_collectionviewrestriction_id_seq OWNED BY public.wagtailcore_collectionviewrestriction.id;


--
-- Name: wagtailcore_groupcollectionpermission; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_groupcollectionpermission (
    id integer NOT NULL,
    collection_id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_groupcollectionpermission OWNER TO vagrant;

--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_groupcollectionpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_groupcollectionpermission_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_groupcollectionpermission_id_seq OWNED BY public.wagtailcore_groupcollectionpermission.id;


--
-- Name: wagtailcore_grouppagepermission; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_grouppagepermission (
    id integer NOT NULL,
    permission_type character varying(20) NOT NULL,
    group_id integer NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_grouppagepermission OWNER TO vagrant;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_grouppagepermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_grouppagepermission_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_grouppagepermission_id_seq OWNED BY public.wagtailcore_grouppagepermission.id;


--
-- Name: wagtailcore_page; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_page (
    id integer NOT NULL,
    path character varying(255) COLLATE pg_catalog."C" NOT NULL,
    depth integer NOT NULL,
    numchild integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    live boolean NOT NULL,
    has_unpublished_changes boolean NOT NULL,
    url_path text NOT NULL,
    seo_title character varying(255) NOT NULL,
    show_in_menus boolean NOT NULL,
    search_description text NOT NULL,
    go_live_at timestamp with time zone,
    expire_at timestamp with time zone,
    expired boolean NOT NULL,
    content_type_id integer NOT NULL,
    owner_id integer,
    locked boolean NOT NULL,
    latest_revision_created_at timestamp with time zone,
    first_published_at timestamp with time zone,
    live_revision_id integer,
    last_published_at timestamp with time zone,
    draft_title character varying(255) NOT NULL,
    CONSTRAINT wagtailcore_page_depth_check CHECK ((depth >= 0)),
    CONSTRAINT wagtailcore_page_numchild_check CHECK ((numchild >= 0))
);


ALTER TABLE public.wagtailcore_page OWNER TO vagrant;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_page_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_page_id_seq OWNED BY public.wagtailcore_page.id;


--
-- Name: wagtailcore_pagerevision; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_pagerevision (
    id integer NOT NULL,
    submitted_for_moderation boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    content_json text NOT NULL,
    approved_go_live_at timestamp with time zone,
    page_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.wagtailcore_pagerevision OWNER TO vagrant;

--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_pagerevision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagerevision_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_pagerevision_id_seq OWNED BY public.wagtailcore_pagerevision.id;


--
-- Name: wagtailcore_pageviewrestriction; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_pageviewrestriction (
    id integer NOT NULL,
    password character varying(255) NOT NULL,
    page_id integer NOT NULL,
    restriction_type character varying(20) NOT NULL
);


ALTER TABLE public.wagtailcore_pageviewrestriction OWNER TO vagrant;

--
-- Name: wagtailcore_pageviewrestriction_groups; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_pageviewrestriction_groups (
    id integer NOT NULL,
    pageviewrestriction_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_pageviewrestriction_groups OWNER TO vagrant;

--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_pageviewrestriction_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_groups_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_pageviewrestriction_groups_id_seq OWNED BY public.wagtailcore_pageviewrestriction_groups.id;


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_pageviewrestriction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_pageviewrestriction_id_seq OWNED BY public.wagtailcore_pageviewrestriction.id;


--
-- Name: wagtailcore_site; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailcore_site (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    port integer NOT NULL,
    is_default_site boolean NOT NULL,
    root_page_id integer NOT NULL,
    site_name character varying(255)
);


ALTER TABLE public.wagtailcore_site OWNER TO vagrant;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailcore_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_site_id_seq OWNER TO vagrant;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailcore_site_id_seq OWNED BY public.wagtailcore_site.id;


--
-- Name: wagtaildocs_document; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtaildocs_document (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    uploaded_by_user_id integer,
    collection_id integer NOT NULL
);


ALTER TABLE public.wagtaildocs_document OWNER TO vagrant;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtaildocs_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtaildocs_document_id_seq OWNER TO vagrant;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtaildocs_document_id_seq OWNED BY public.wagtaildocs_document.id;


--
-- Name: wagtailembeds_embed; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailembeds_embed (
    id integer NOT NULL,
    url character varying(200) NOT NULL,
    max_width smallint,
    type character varying(10) NOT NULL,
    html text NOT NULL,
    title text NOT NULL,
    author_name text NOT NULL,
    provider_name text NOT NULL,
    thumbnail_url character varying(200),
    width integer,
    height integer,
    last_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.wagtailembeds_embed OWNER TO vagrant;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailembeds_embed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailembeds_embed_id_seq OWNER TO vagrant;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailembeds_embed_id_seq OWNED BY public.wagtailembeds_embed.id;


--
-- Name: wagtailforms_formsubmission; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailforms_formsubmission (
    id integer NOT NULL,
    form_data text NOT NULL,
    submit_time timestamp with time zone NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailforms_formsubmission OWNER TO vagrant;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailforms_formsubmission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailforms_formsubmission_id_seq OWNER TO vagrant;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailforms_formsubmission_id_seq OWNED BY public.wagtailforms_formsubmission.id;


--
-- Name: wagtailimages_image; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailimages_image (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    focal_point_x integer,
    focal_point_y integer,
    focal_point_width integer,
    focal_point_height integer,
    uploaded_by_user_id integer,
    file_size integer,
    collection_id integer NOT NULL,
    CONSTRAINT wagtailimages_image_file_size_check CHECK ((file_size >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_height_check CHECK ((focal_point_height >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_width_check CHECK ((focal_point_width >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_x_check CHECK ((focal_point_x >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_y_check CHECK ((focal_point_y >= 0))
);


ALTER TABLE public.wagtailimages_image OWNER TO vagrant;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailimages_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_image_id_seq OWNER TO vagrant;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailimages_image_id_seq OWNED BY public.wagtailimages_image.id;


--
-- Name: wagtailimages_rendition; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailimages_rendition (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    focal_point_key character varying(16) NOT NULL,
    image_id integer NOT NULL,
    filter_spec character varying(255) NOT NULL
);


ALTER TABLE public.wagtailimages_rendition OWNER TO vagrant;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailimages_rendition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_rendition_id_seq OWNER TO vagrant;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailimages_rendition_id_seq OWNED BY public.wagtailimages_rendition.id;


--
-- Name: wagtailredirects_redirect; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailredirects_redirect (
    id integer NOT NULL,
    old_path character varying(255) NOT NULL,
    is_permanent boolean NOT NULL,
    redirect_link character varying(200) NOT NULL,
    redirect_page_id integer,
    site_id integer
);


ALTER TABLE public.wagtailredirects_redirect OWNER TO vagrant;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailredirects_redirect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailredirects_redirect_id_seq OWNER TO vagrant;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailredirects_redirect_id_seq OWNED BY public.wagtailredirects_redirect.id;


--
-- Name: wagtailsearchpromotions_searchpromotion; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailsearchpromotions_searchpromotion (
    id integer NOT NULL,
    sort_order integer,
    description text NOT NULL,
    page_id integer NOT NULL,
    query_id integer NOT NULL
);


ALTER TABLE public.wagtailsearchpromotions_searchpromotion OWNER TO vagrant;

--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailsearch_editorspick_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_editorspick_id_seq OWNER TO vagrant;

--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailsearch_editorspick_id_seq OWNED BY public.wagtailsearchpromotions_searchpromotion.id;


--
-- Name: wagtailsearch_query; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailsearch_query (
    id integer NOT NULL,
    query_string character varying(255) NOT NULL
);


ALTER TABLE public.wagtailsearch_query OWNER TO vagrant;

--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailsearch_query_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_query_id_seq OWNER TO vagrant;

--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailsearch_query_id_seq OWNED BY public.wagtailsearch_query.id;


--
-- Name: wagtailsearch_querydailyhits; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailsearch_querydailyhits (
    id integer NOT NULL,
    date date NOT NULL,
    hits integer NOT NULL,
    query_id integer NOT NULL
);


ALTER TABLE public.wagtailsearch_querydailyhits OWNER TO vagrant;

--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailsearch_querydailyhits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_querydailyhits_id_seq OWNER TO vagrant;

--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailsearch_querydailyhits_id_seq OWNED BY public.wagtailsearch_querydailyhits.id;


--
-- Name: wagtailusers_userprofile; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE public.wagtailusers_userprofile (
    id integer NOT NULL,
    submitted_notifications boolean NOT NULL,
    approved_notifications boolean NOT NULL,
    rejected_notifications boolean NOT NULL,
    user_id integer NOT NULL,
    preferred_language character varying(10) NOT NULL
);


ALTER TABLE public.wagtailusers_userprofile OWNER TO vagrant;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE public.wagtailusers_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailusers_userprofile_id_seq OWNER TO vagrant;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE public.wagtailusers_userprofile_id_seq OWNED BY public.wagtailusers_userprofile.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: bookings_bookingslot id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_bookingslot ALTER COLUMN id SET DEFAULT nextval('public.bookings_bookingslot_id_seq'::regclass);


--
-- Name: bookings_bookingslotrequest id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_bookingslotrequest ALTER COLUMN id SET DEFAULT nextval('public.bookings_bookingslotrequest_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: hosts_hostlanguage id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostlanguage ALTER COLUMN id SET DEFAULT nextval('public.hosts_hostlanguage_id_seq'::regclass);


--
-- Name: hosts_hostlanguagerelationship id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostlanguagerelationship ALTER COLUMN id SET DEFAULT nextval('public.hosts_hostlanguagerelationship_id_seq'::regclass);


--
-- Name: taggit_tag id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_tag ALTER COLUMN id SET DEFAULT nextval('public.taggit_tag_id_seq'::regclass);


--
-- Name: taggit_taggeditem id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.taggit_taggeditem_id_seq'::regclass);


--
-- Name: wagtailcore_collection id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collection ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collection_id_seq'::regclass);


--
-- Name: wagtailcore_collectionviewrestriction id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collectionviewrestriction_id_seq'::regclass);


--
-- Name: wagtailcore_collectionviewrestriction_groups id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collectionviewrestriction_groups_id_seq'::regclass);


--
-- Name: wagtailcore_groupcollectionpermission id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_groupcollectionpermission_id_seq'::regclass);


--
-- Name: wagtailcore_grouppagepermission id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_grouppagepermission_id_seq'::regclass);


--
-- Name: wagtailcore_page id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_page ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_page_id_seq'::regclass);


--
-- Name: wagtailcore_pagerevision id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pagerevision ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pagerevision_id_seq'::regclass);


--
-- Name: wagtailcore_pageviewrestriction id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pageviewrestriction_id_seq'::regclass);


--
-- Name: wagtailcore_pageviewrestriction_groups id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pageviewrestriction_groups_id_seq'::regclass);


--
-- Name: wagtailcore_site id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_site ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_site_id_seq'::regclass);


--
-- Name: wagtaildocs_document id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtaildocs_document ALTER COLUMN id SET DEFAULT nextval('public.wagtaildocs_document_id_seq'::regclass);


--
-- Name: wagtailembeds_embed id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailembeds_embed ALTER COLUMN id SET DEFAULT nextval('public.wagtailembeds_embed_id_seq'::regclass);


--
-- Name: wagtailforms_formsubmission id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailforms_formsubmission ALTER COLUMN id SET DEFAULT nextval('public.wagtailforms_formsubmission_id_seq'::regclass);


--
-- Name: wagtailimages_image id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_image ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_image_id_seq'::regclass);


--
-- Name: wagtailimages_rendition id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_rendition ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_rendition_id_seq'::regclass);


--
-- Name: wagtailredirects_redirect id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailredirects_redirect ALTER COLUMN id SET DEFAULT nextval('public.wagtailredirects_redirect_id_seq'::regclass);


--
-- Name: wagtailsearch_query id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_query ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_query_id_seq'::regclass);


--
-- Name: wagtailsearch_querydailyhits id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_querydailyhits_id_seq'::regclass);


--
-- Name: wagtailsearchpromotions_searchpromotion id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearchpromotions_searchpromotion ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_editorspick_id_seq'::regclass);


--
-- Name: wagtailusers_userprofile id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailusers_userprofile ALTER COLUMN id SET DEFAULT nextval('public.wagtailusers_userprofile_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.auth_group (id, name) FROM stdin;
1	Moderators
2	Editors
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	1
5	2	2
6	2	3
7	1	4
8	2	4
9	1	5
10	1	6
11	1	7
12	2	5
13	2	6
14	2	7
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 14, true);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add image	2	add_image
2	Can change image	2	change_image
3	Can delete image	2	delete_image
4	Can access Wagtail admin	3	access_admin
5	Can add document	4	add_document
6	Can change document	4	change_document
7	Can delete document	4	delete_document
8	Can add home page	5	add_homepage
9	Can change home page	5	change_homepage
10	Can delete home page	5	delete_homepage
11	Can add place index page	6	add_placeindexpage
12	Can change place index page	6	change_placeindexpage
13	Can delete place index page	6	delete_placeindexpage
14	Can add place page	7	add_placepage
15	Can change place page	7	change_placepage
16	Can delete place page	7	delete_placepage
17	Can add host index page	8	add_hostindexpage
18	Can change host index page	8	change_hostindexpage
19	Can delete host index page	8	delete_hostindexpage
20	Can add host page	9	add_hostpage
21	Can change host page	9	change_hostpage
22	Can delete host page	9	delete_hostpage
23	Can add Language	10	add_hostlanguage
24	Can change Language	10	change_hostlanguage
25	Can delete Language	10	delete_hostlanguage
26	Can add host language relationship	11	add_hostlanguagerelationship
27	Can change host language relationship	11	change_hostlanguagerelationship
28	Can delete host language relationship	11	delete_hostlanguagerelationship
29	Can add experience index page	12	add_experienceindexpage
30	Can change experience index page	12	change_experienceindexpage
31	Can delete experience index page	12	delete_experienceindexpage
32	Can add experience page	13	add_experiencepage
33	Can change experience page	13	change_experiencepage
34	Can delete experience page	13	delete_experiencepage
35	Can add blog page	14	add_blogpage
36	Can change blog page	14	change_blogpage
37	Can delete blog page	14	delete_blogpage
38	Can add blog index page	15	add_blogindexpage
39	Can change blog index page	15	change_blogindexpage
40	Can delete blog index page	15	delete_blogindexpage
41	Can add booking	16	add_booking
42	Can change booking	16	change_booking
43	Can delete booking	16	delete_booking
44	Can add booking slot	17	add_bookingslot
45	Can change booking slot	17	change_bookingslot
46	Can delete booking slot	17	delete_bookingslot
47	Can add booking slot request	18	add_bookingslotrequest
48	Can change booking slot request	18	change_bookingslotrequest
49	Can delete booking slot request	18	delete_bookingslotrequest
50	Can add search promotion	19	add_searchpromotion
51	Can change search promotion	19	change_searchpromotion
52	Can delete search promotion	19	delete_searchpromotion
53	Can add form submission	20	add_formsubmission
54	Can change form submission	20	change_formsubmission
55	Can delete form submission	20	delete_formsubmission
56	Can add redirect	21	add_redirect
57	Can change redirect	21	change_redirect
58	Can delete redirect	21	delete_redirect
59	Can add embed	22	add_embed
60	Can change embed	22	change_embed
61	Can delete embed	22	delete_embed
62	Can add user profile	23	add_userprofile
63	Can change user profile	23	change_userprofile
64	Can delete user profile	23	delete_userprofile
65	Can add rendition	24	add_rendition
66	Can change rendition	24	change_rendition
67	Can delete rendition	24	delete_rendition
68	Can add query	25	add_query
69	Can change query	25	change_query
70	Can delete query	25	delete_query
71	Can add Query Daily Hits	26	add_querydailyhits
72	Can change Query Daily Hits	26	change_querydailyhits
73	Can delete Query Daily Hits	26	delete_querydailyhits
74	Can add page	1	add_page
75	Can change page	1	change_page
76	Can delete page	1	delete_page
77	Can add group page permission	27	add_grouppagepermission
78	Can change group page permission	27	change_grouppagepermission
79	Can delete group page permission	27	delete_grouppagepermission
80	Can add page revision	28	add_pagerevision
81	Can change page revision	28	change_pagerevision
82	Can delete page revision	28	delete_pagerevision
83	Can add page view restriction	29	add_pageviewrestriction
84	Can change page view restriction	29	change_pageviewrestriction
85	Can delete page view restriction	29	delete_pageviewrestriction
86	Can add site	30	add_site
87	Can change site	30	change_site
88	Can delete site	30	delete_site
89	Can add collection	31	add_collection
90	Can change collection	31	change_collection
91	Can delete collection	31	delete_collection
92	Can add group collection permission	32	add_groupcollectionpermission
93	Can change group collection permission	32	change_groupcollectionpermission
94	Can delete group collection permission	32	delete_groupcollectionpermission
95	Can add collection view restriction	33	add_collectionviewrestriction
96	Can change collection view restriction	33	change_collectionviewrestriction
97	Can delete collection view restriction	33	delete_collectionviewrestriction
98	Can add Tag	34	add_tag
99	Can change Tag	34	change_tag
100	Can delete Tag	34	delete_tag
101	Can add Tagged Item	35	add_taggeditem
102	Can change Tagged Item	35	change_taggeditem
103	Can delete Tagged Item	35	delete_taggeditem
104	Can add log entry	36	add_logentry
105	Can change log entry	36	change_logentry
106	Can delete log entry	36	delete_logentry
107	Can add permission	37	add_permission
108	Can change permission	37	change_permission
109	Can delete permission	37	delete_permission
110	Can add group	38	add_group
111	Can change group	38	change_group
112	Can delete group	38	delete_group
113	Can add user	39	add_user
114	Can change user	39	change_user
115	Can delete user	39	delete_user
116	Can add content type	40	add_contenttype
117	Can change content type	40	change_contenttype
118	Can delete content type	40	delete_contenttype
119	Can add session	41	add_session
120	Can change session	41	change_session
121	Can delete session	41	delete_session
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 121, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$ANCCFiWHJ0A5$AndX6lE9x142R6F9IFS0HrmqIGHZBInlJJmcRMdt3Qc=	2018-08-18 03:54:00.896865+00	t	test			test@example.com	t	t	2018-08-18 03:30:47.66452+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: blog_blogindexpage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.blog_blogindexpage (page_ptr_id) FROM stdin;
\.


--
-- Data for Name: blog_blogpage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.blog_blogpage (page_ptr_id, date, intro, body, image_id) FROM stdin;
\.


--
-- Data for Name: bookings_booking; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.bookings_booking (experience_page_id) FROM stdin;
9
\.


--
-- Data for Name: bookings_bookingslot; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.bookings_bookingslot (id, start, "end", repeat, repeat_until, booking_id, notes) FROM stdin;
\.


--
-- Name: bookings_bookingslot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.bookings_bookingslot_id_seq', 1, false);


--
-- Data for Name: bookings_bookingslotrequest; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.bookings_bookingslotrequest (id, request_date, first_name, last_name, email_address, group_size, message, slot_id) FROM stdin;
\.


--
-- Name: bookings_bookingslotrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.bookings_bookingslotrequest_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	wagtailcore	page
2	wagtailimages	image
3	wagtailadmin	admin
4	wagtaildocs	document
5	home	homepage
6	places	placeindexpage
7	places	placepage
8	hosts	hostindexpage
9	hosts	hostpage
10	hosts	hostlanguage
11	hosts	hostlanguagerelationship
12	experiences	experienceindexpage
13	experiences	experiencepage
14	blog	blogpage
15	blog	blogindexpage
16	bookings	booking
17	bookings	bookingslot
18	bookings	bookingslotrequest
19	wagtailsearchpromotions	searchpromotion
20	wagtailforms	formsubmission
21	wagtailredirects	redirect
22	wagtailembeds	embed
23	wagtailusers	userprofile
24	wagtailimages	rendition
25	wagtailsearch	query
26	wagtailsearch	querydailyhits
27	wagtailcore	grouppagepermission
28	wagtailcore	pagerevision
29	wagtailcore	pageviewrestriction
30	wagtailcore	site
31	wagtailcore	collection
32	wagtailcore	groupcollectionpermission
33	wagtailcore	collectionviewrestriction
34	taggit	tag
35	taggit	taggeditem
36	admin	logentry
37	auth	permission
38	auth	group
39	auth	user
40	contenttypes	contenttype
41	sessions	session
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 41, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-08-18 03:30:07.368359+00
2	auth	0001_initial	2018-08-18 03:30:07.524312+00
3	admin	0001_initial	2018-08-18 03:30:07.575111+00
4	admin	0002_logentry_remove_auto_add	2018-08-18 03:30:07.598404+00
5	contenttypes	0002_remove_content_type_name	2018-08-18 03:30:07.631386+00
6	auth	0002_alter_permission_name_max_length	2018-08-18 03:30:07.643973+00
7	auth	0003_alter_user_email_max_length	2018-08-18 03:30:07.6652+00
8	auth	0004_alter_user_username_opts	2018-08-18 03:30:07.690386+00
9	auth	0005_alter_user_last_login_null	2018-08-18 03:30:07.715984+00
10	auth	0006_require_contenttypes_0002	2018-08-18 03:30:07.721226+00
11	auth	0007_alter_validators_add_error_messages	2018-08-18 03:30:07.775707+00
12	auth	0008_alter_user_username_max_length	2018-08-18 03:30:07.802099+00
13	wagtailcore	0001_initial	2018-08-18 03:30:08.154488+00
14	wagtailcore	0002_initial_data	2018-08-18 03:30:08.158596+00
15	wagtailcore	0003_add_uniqueness_constraint_on_group_page_permission	2018-08-18 03:30:08.163555+00
16	wagtailcore	0004_page_locked	2018-08-18 03:30:08.167677+00
17	wagtailcore	0005_add_page_lock_permission_to_moderators	2018-08-18 03:30:08.171675+00
18	wagtailcore	0006_add_lock_page_permission	2018-08-18 03:30:08.175588+00
19	wagtailcore	0007_page_latest_revision_created_at	2018-08-18 03:30:08.179404+00
20	wagtailcore	0008_populate_latest_revision_created_at	2018-08-18 03:30:08.183205+00
21	wagtailcore	0009_remove_auto_now_add_from_pagerevision_created_at	2018-08-18 03:30:08.18797+00
22	wagtailcore	0010_change_page_owner_to_null_on_delete	2018-08-18 03:30:08.191778+00
23	wagtailcore	0011_page_first_published_at	2018-08-18 03:30:08.19554+00
24	wagtailcore	0012_extend_page_slug_field	2018-08-18 03:30:08.199847+00
25	wagtailcore	0013_update_golive_expire_help_text	2018-08-18 03:30:08.203453+00
26	wagtailcore	0014_add_verbose_name	2018-08-18 03:30:08.20687+00
27	wagtailcore	0015_add_more_verbose_names	2018-08-18 03:30:08.210822+00
28	wagtailcore	0016_change_page_url_path_to_text_field	2018-08-18 03:30:08.214578+00
29	wagtailcore	0017_change_edit_page_permission_description	2018-08-18 03:30:08.238795+00
30	wagtailcore	0018_pagerevision_submitted_for_moderation_index	2018-08-18 03:30:08.269439+00
31	wagtailcore	0019_verbose_names_cleanup	2018-08-18 03:30:08.345597+00
32	wagtailcore	0020_add_index_on_page_first_published_at	2018-08-18 03:30:08.378581+00
33	wagtailcore	0021_capitalizeverbose	2018-08-18 03:30:08.94842+00
34	wagtailcore	0022_add_site_name	2018-08-18 03:30:08.986757+00
35	wagtailcore	0023_alter_page_revision_on_delete_behaviour	2018-08-18 03:30:09.08137+00
36	wagtailcore	0024_collection	2018-08-18 03:30:09.11489+00
37	wagtailcore	0025_collection_initial_data	2018-08-18 03:30:09.147691+00
38	wagtailcore	0026_group_collection_permission	2018-08-18 03:30:09.224412+00
39	wagtailcore	0027_fix_collection_path_collation	2018-08-18 03:30:09.261787+00
40	wagtailcore	0024_alter_page_content_type_on_delete_behaviour	2018-08-18 03:30:09.300572+00
41	wagtailcore	0028_merge	2018-08-18 03:30:09.305509+00
42	wagtailcore	0029_unicode_slugfield_dj19	2018-08-18 03:30:09.327811+00
43	wagtailcore	0030_index_on_pagerevision_created_at	2018-08-18 03:30:09.355143+00
44	wagtailcore	0031_add_page_view_restriction_types	2018-08-18 03:30:09.462568+00
45	wagtailcore	0032_add_bulk_delete_page_permission	2018-08-18 03:30:09.486518+00
46	taggit	0001_initial	2018-08-18 03:30:09.564604+00
47	wagtailimages	0001_initial	2018-08-18 03:30:09.695133+00
48	wagtailimages	0002_initial_data	2018-08-18 03:30:09.758011+00
49	wagtailimages	0003_fix_focal_point_fields	2018-08-18 03:30:09.820539+00
50	wagtailimages	0004_make_focal_point_key_not_nullable	2018-08-18 03:30:09.878719+00
51	wagtailimages	0005_make_filter_spec_unique	2018-08-18 03:30:09.915742+00
52	wagtailimages	0006_add_verbose_names	2018-08-18 03:30:10.006575+00
53	wagtailimages	0007_image_file_size	2018-08-18 03:30:10.034936+00
54	wagtailimages	0008_image_created_at_index	2018-08-18 03:30:10.07127+00
55	wagtailimages	0009_capitalizeverbose	2018-08-18 03:30:10.212059+00
56	wagtailimages	0010_change_on_delete_behaviour	2018-08-18 03:30:10.249811+00
57	wagtailimages	0011_image_collection	2018-08-18 03:30:10.320371+00
58	wagtailimages	0012_copy_image_permissions_to_collections	2018-08-18 03:30:10.368922+00
59	wagtailimages	0013_make_rendition_upload_callable	2018-08-18 03:30:10.388378+00
60	wagtailimages	0014_add_filter_spec_field	2018-08-18 03:30:10.479994+00
61	wagtailimages	0015_fill_filter_spec_field	2018-08-18 03:30:10.515857+00
62	wagtailimages	0016_deprecate_rendition_filter_relation	2018-08-18 03:30:10.674871+00
63	blog	0001_initial	2018-08-18 03:30:10.728195+00
64	blog	0002_blogindexpage	2018-08-18 03:30:10.775692+00
65	places	0001_initial	2018-08-18 03:30:10.886898+00
66	hosts	0001_initial	2018-08-18 03:30:11.062723+00
67	experiences	0001_initial	2018-08-18 03:30:11.17607+00
68	hosts	0002_auto_20170415_0410	2018-08-18 03:30:11.453788+00
69	hosts	0003_auto_20170427_0443	2018-08-18 03:30:11.655439+00
70	hosts	0004_auto_20170509_0449	2018-08-18 03:30:11.77145+00
71	experiences	0002_experiencepage_duration	2018-08-18 03:30:11.833164+00
72	experiences	0003_experiencepage_host	2018-08-18 03:30:11.968543+00
73	experiences	0004_experiencepage_place	2018-08-18 03:30:12.037252+00
74	experiences	0005_auto_20170615_0435	2018-08-18 03:30:12.075297+00
75	bookings	0001_initial	2018-08-18 03:30:12.186171+00
76	bookings	0002_bookingslot_notes	2018-08-18 03:30:12.203479+00
77	bookings	0003_add_booking_slot_request	2018-08-18 03:30:12.378654+00
78	home	0001_initial	2018-08-18 03:30:12.452406+00
79	hosts	0005_remove_hostplace_relationship	2018-08-18 03:30:12.572549+00
80	hosts	0006_auto_20170615_0435	2018-08-18 03:30:12.613926+00
81	hosts	0007_hostpage_email_address	2018-08-18 03:30:12.666839+00
82	places	0002_auto_20170615_0435	2018-08-18 03:30:12.70503+00
83	sessions	0001_initial	2018-08-18 03:30:12.727668+00
84	taggit	0002_auto_20150616_2121	2018-08-18 03:30:12.748918+00
85	wagtailadmin	0001_create_admin_access_permissions	2018-08-18 03:30:12.809329+00
86	wagtailcore	0033_remove_golive_expiry_help_text	2018-08-18 03:30:12.849952+00
87	wagtailcore	0034_page_live_revision	2018-08-18 03:30:12.881394+00
88	wagtailcore	0035_page_last_published_at	2018-08-18 03:30:12.904994+00
89	wagtailcore	0036_populate_page_last_published_at	2018-08-18 03:30:12.954646+00
90	wagtailcore	0037_set_page_owner_editable	2018-08-18 03:30:12.988268+00
91	wagtailcore	0038_make_first_published_at_editable	2018-08-18 03:30:13.01759+00
92	wagtailcore	0039_collectionviewrestriction	2018-08-18 03:30:13.145631+00
93	wagtailcore	0040_page_draft_title	2018-08-18 03:30:13.357981+00
94	wagtaildocs	0001_initial	2018-08-18 03:30:13.426836+00
95	wagtaildocs	0002_initial_data	2018-08-18 03:30:13.504801+00
96	wagtaildocs	0003_add_verbose_names	2018-08-18 03:30:13.583494+00
97	wagtaildocs	0004_capitalizeverbose	2018-08-18 03:30:13.718167+00
98	wagtaildocs	0005_document_collection	2018-08-18 03:30:13.77402+00
99	wagtaildocs	0006_copy_document_permissions_to_collections	2018-08-18 03:30:13.842737+00
100	wagtaildocs	0005_alter_uploaded_by_user_on_delete_action	2018-08-18 03:30:13.885719+00
101	wagtaildocs	0007_merge	2018-08-18 03:30:13.890484+00
102	wagtailembeds	0001_initial	2018-08-18 03:30:13.927233+00
103	wagtailembeds	0002_add_verbose_names	2018-08-18 03:30:13.937096+00
104	wagtailembeds	0003_capitalizeverbose	2018-08-18 03:30:13.947191+00
105	wagtailforms	0001_initial	2018-08-18 03:30:13.999506+00
106	wagtailforms	0002_add_verbose_names	2018-08-18 03:30:14.036383+00
107	wagtailforms	0003_capitalizeverbose	2018-08-18 03:30:14.073486+00
108	wagtailimages	0017_reduce_focal_point_key_max_length	2018-08-18 03:30:14.11959+00
109	wagtailimages	0018_remove_rendition_filter	2018-08-18 03:30:14.166627+00
110	wagtailimages	0019_delete_filter	2018-08-18 03:30:14.179639+00
111	wagtailredirects	0001_initial	2018-08-18 03:30:14.258224+00
112	wagtailredirects	0002_add_verbose_names	2018-08-18 03:30:14.352643+00
113	wagtailredirects	0003_make_site_field_editable	2018-08-18 03:30:14.413753+00
114	wagtailredirects	0004_set_unique_on_path_and_site	2018-08-18 03:30:14.499734+00
115	wagtailredirects	0005_capitalizeverbose	2018-08-18 03:30:14.788984+00
116	wagtailsearch	0001_initial	2018-08-18 03:30:14.968472+00
117	wagtailsearch	0002_add_verbose_names	2018-08-18 03:30:15.098773+00
118	wagtailsearch	0003_remove_editors_pick	2018-08-18 03:30:15.163651+00
119	wagtailsearchpromotions	0001_initial	2018-08-18 03:30:15.360086+00
120	wagtailsearchpromotions	0002_capitalizeverbose	2018-08-18 03:30:15.506089+00
121	wagtailusers	0001_initial	2018-08-18 03:30:15.677452+00
122	wagtailusers	0002_add_verbose_name_on_userprofile	2018-08-18 03:30:15.74925+00
123	wagtailusers	0003_add_verbose_names	2018-08-18 03:30:15.776805+00
124	wagtailusers	0004_capitalizeverbose	2018-08-18 03:30:15.865888+00
125	wagtailusers	0005_make_related_name_wagtail_specific	2018-08-18 03:30:15.915353+00
126	wagtailusers	0006_userprofile_prefered_language	2018-08-18 03:30:15.959611+00
127	wagtailcore	0001_squashed_0016_change_page_url_path_to_text_field	2018-08-18 03:30:15.967548+00
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 127, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
4f71wf7vewskxwzjaeafs80itx7ezq1c	YzQ1ODAyM2FiZWE5ZDM0NzBjZWQyMTIyMWIxZDJmMmE0NjVhZDM2ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODEwNTJhMDkxYzUxZDhjOWI4MWRmMGE5OWQwNmNkMTZjZGMyNGU5Iiwid2FndGFpbC1wcmV2aWV3LTMiOlsiY3NyZm1pZGRsZXdhcmV0b2tlbj1KbFNvQkQ1dGdqbWFOc3RGZjRxT3d6R0ZBb3dLRjZubXVYaG00eDhKQTVyVkxQMk9ndjZNUTZDQzMzbzlESzR5Jm5leHQ9JnRpdGxlPUhvbWUmb3JnYW5pc2F0aW9uX25hbWU9ZG9vbGF5JnN0cmFwbGluZT1kb29sYXkmZmVhdHVyZWRfcGFnZV8xPSZmZWF0dXJlZF9wYWdlXzI9JmZlYXR1cmVkX3BhZ2VfMz0mY29weXJpZ2h0X25vdGljZT0mc2x1Zz1ob21lJnNlb190aXRsZT0mc2VhcmNoX2Rlc2NyaXB0aW9uPSZnb19saXZlX2F0PSZleHBpcmVfYXQ9IiwxNTM0NTYzMTgzLjQ1MDI1MTNdfQ==	2018-09-01 03:33:03.463237+00
wj6jm02yn6apu75djyzcnd1xs0564whp	YWVjODc5ODdlODMzMzkzMDljMDI2OTY4MDY3YjRhZDE3ZWUwNDEyNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODEwNTJhMDkxYzUxZDhjOWI4MWRmMGE5OWQwNmNkMTZjZGMyNGU5In0=	2018-09-01 03:54:00.902232+00
\.


--
-- Data for Name: experiences_experienceindexpage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.experiences_experienceindexpage (page_ptr_id, introduction, image_id) FROM stdin;
4	This is experiences page	\N
\.


--
-- Data for Name: experiences_experiencepage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.experiences_experiencepage (page_ptr_id, body, image_id, duration, host_id, place_id) FROM stdin;
9	[{"type": "paragraph", "value": "<p>Unforgettable Yangon experience.</p>", "id": "70c78c1d-3e21-4ee7-9510-793931f4baa0"}]	\N	00:45:00	8	7
\.


--
-- Data for Name: home_homepage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.home_homepage (page_ptr_id, organisation_name, strapline, copyright_notice, featured_page_1_id, featured_page_2_id, featured_page_3_id) FROM stdin;
3	doolay	doolay	Please contact us for these experiences	6	5	4
\.


--
-- Data for Name: hosts_hostindexpage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.hosts_hostindexpage (page_ptr_id, introduction, image_id) FROM stdin;
5	This is hosts	\N
\.


--
-- Data for Name: hosts_hostlanguage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.hosts_hostlanguage (id, title) FROM stdin;
1	English
2	Burmese
\.


--
-- Name: hosts_hostlanguage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.hosts_hostlanguage_id_seq', 2, true);


--
-- Data for Name: hosts_hostlanguagerelationship; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.hosts_hostlanguagerelationship (id, host_languages_id, host_page_id) FROM stdin;
1	2	8
2	1	8
\.


--
-- Name: hosts_hostlanguagerelationship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.hosts_hostlanguagerelationship_id_seq', 2, true);


--
-- Data for Name: hosts_hostpage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.hosts_hostpage (page_ptr_id, body, image_id, email_address) FROM stdin;
8	[{"type": "paragraph", "value": "<p>Hi, this is Yan.</p>", "id": "01592121-e7e6-48e7-a507-cfe16f70051d"}]	\N	test@example.com
\.


--
-- Data for Name: places_placeindexpage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.places_placeindexpage (page_ptr_id, introduction, image_id) FROM stdin;
6	This is places	\N
\.


--
-- Data for Name: places_placepage; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.places_placepage (page_ptr_id, body, image_id) FROM stdin;
7	[{"type": "paragraph", "value": "<p>Yangon is my home town!</p>", "id": "3373807c-c36b-46eb-baae-e04a32f756bf"}]	\N
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.taggit_tag_id_seq', 1, false);


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.taggit_taggeditem_id_seq', 1, false);


--
-- Data for Name: wagtailcore_collection; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_collection (id, path, depth, numchild, name) FROM stdin;
1	0001	1	0	Root
\.


--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_collection_id_seq', 1, true);


--
-- Data for Name: wagtailcore_collectionviewrestriction; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_collectionviewrestriction (id, restriction_type, password, collection_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_collectionviewrestriction_groups; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_collectionviewrestriction_groups (id, collectionviewrestriction_id, group_id) FROM stdin;
\.


--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_collectionviewrestriction_groups_id_seq', 1, false);


--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_collectionviewrestriction_id_seq', 1, false);


--
-- Data for Name: wagtailcore_groupcollectionpermission; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_groupcollectionpermission (id, collection_id, group_id, permission_id) FROM stdin;
1	1	1	1
2	1	2	1
3	1	1	2
4	1	2	2
5	1	1	5
6	1	2	5
7	1	1	6
8	1	2	6
\.


--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_groupcollectionpermission_id_seq', 8, true);


--
-- Data for Name: wagtailcore_grouppagepermission; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_grouppagepermission (id, permission_type, group_id, page_id) FROM stdin;
1	add	1	1
2	edit	1	1
3	publish	1	1
4	add	2	1
5	edit	2	1
6	lock	1	1
\.


--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_grouppagepermission_id_seq', 6, true);


--
-- Data for Name: wagtailcore_page; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_page (id, path, depth, numchild, title, slug, live, has_unpublished_changes, url_path, seo_title, show_in_menus, search_description, go_live_at, expire_at, expired, content_type_id, owner_id, locked, latest_revision_created_at, first_published_at, live_revision_id, last_published_at, draft_title) FROM stdin;
1	0001	1	1	Root	root	t	f	/		f		\N	\N	f	1	\N	f	\N	\N	\N	\N	Root
6	000100010003	3	1	Places	places	t	f	/home/places/		f		\N	\N	f	6	1	f	2018-08-18 03:34:40.130016+00	2018-08-18 03:34:40.198022+00	4	2018-08-18 03:34:40.198022+00	Places
7	0001000100030001	4	0	Yangon	yangon	t	f	/home/places/yangon/		f		\N	\N	f	7	1	f	2018-08-18 03:36:09.681603+00	2018-08-18 03:36:09.733449+00	5	2018-08-18 03:36:09.733449+00	Yangon
5	000100010002	3	1	Hosts	hosts	t	f	/home/hosts/		f		\N	\N	f	8	1	f	2018-08-18 03:34:22.42895+00	2018-08-18 03:34:22.481732+00	3	2018-08-18 03:34:22.481732+00	Hosts
8	0001000100020001	4	0	ypa	ypa	t	f	/home/hosts/ypa/		f		\N	\N	f	9	1	f	2018-08-18 03:37:11.681712+00	2018-08-18 03:37:11.741627+00	6	2018-08-18 03:37:11.741627+00	ypa
4	000100010001	3	1	Experiences	experiences	t	f	/home/experiences/		f		\N	\N	f	12	1	f	2018-08-18 03:34:00.618325+00	2018-08-18 03:34:00.668369+00	2	2018-08-18 03:34:00.668369+00	Experiences
9	0001000100010001	4	0	Beautiful Yangon	beautiful-yangon	t	f	/home/experiences/beautiful-yangon/		f		\N	\N	f	13	1	f	2018-08-18 03:38:12.823285+00	2018-08-18 03:38:12.88095+00	7	2018-08-18 03:38:12.88095+00	Beautiful Yangon
3	00010001	2	3	Home	home	t	f	/home/		f		\N	\N	f	5	1	f	2018-08-18 03:40:02.351025+00	2018-08-18 03:32:39.916544+00	8	2018-08-18 03:40:02.428768+00	Home
\.


--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_page_id_seq', 9, true);


--
-- Data for Name: wagtailcore_pagerevision; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_pagerevision (id, submitted_for_moderation, created_at, content_json, approved_go_live_at, page_id, user_id) FROM stdin;
1	f	2018-08-18 03:32:39.82511+00	{"pk": 3, "path": "00010001", "depth": 2, "numchild": 0, "title": "Home", "draft_title": "Home", "slug": "home", "content_type": 5, "live": true, "has_unpublished_changes": false, "url_path": "/home/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "organisation_name": "doolay", "strapline": "doolay", "featured_page_1": null, "featured_page_2": null, "featured_page_3": null, "copyright_notice": null}	\N	3	1
2	f	2018-08-18 03:34:00.618325+00	{"pk": 4, "path": "000100010001", "depth": 3, "numchild": 0, "title": "Experiences", "draft_title": "Experiences", "slug": "experiences", "content_type": 12, "live": true, "has_unpublished_changes": false, "url_path": "/home/experiences/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "image": null, "introduction": "This is experiences page"}	\N	4	1
5	f	2018-08-18 03:36:09.681603+00	{"pk": 7, "path": "0001000100030001", "depth": 4, "numchild": 0, "title": "Yangon", "draft_title": "Yangon", "slug": "yangon", "content_type": 7, "live": true, "has_unpublished_changes": false, "url_path": "/home/places/yangon/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "image": null, "body": "[{\\"type\\": \\"paragraph\\", \\"value\\": \\"<p>Yangon is my home town!</p>\\", \\"id\\": \\"3373807c-c36b-46eb-baae-e04a32f756bf\\"}]"}	\N	7	1
3	f	2018-08-18 03:34:22.42895+00	{"pk": 5, "path": "000100010002", "depth": 3, "numchild": 0, "title": "Hosts", "draft_title": "Hosts", "slug": "hosts", "content_type": 8, "live": true, "has_unpublished_changes": false, "url_path": "/home/hosts/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "image": null, "introduction": "This is hosts"}	\N	5	1
4	f	2018-08-18 03:34:40.130016+00	{"pk": 6, "path": "000100010003", "depth": 3, "numchild": 0, "title": "Places", "draft_title": "Places", "slug": "places", "content_type": 6, "live": true, "has_unpublished_changes": false, "url_path": "/home/places/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "image": null, "introduction": "This is places"}	\N	6	1
7	f	2018-08-18 03:38:12.823285+00	{"pk": 9, "path": "0001000100010001", "depth": 4, "numchild": 0, "title": "Beautiful Yangon", "draft_title": "Beautiful Yangon", "slug": "beautiful-yangon", "content_type": 13, "live": true, "has_unpublished_changes": false, "url_path": "/home/experiences/beautiful-yangon/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "image": null, "host": 8, "place": 7, "duration": "00:45:00", "body": "[{\\"type\\": \\"paragraph\\", \\"value\\": \\"<p>Unforgettable Yangon experience.</p>\\", \\"id\\": \\"70c78c1d-3e21-4ee7-9510-793931f4baa0\\"}]"}	\N	9	1
6	f	2018-08-18 03:37:11.681712+00	{"pk": 8, "path": "0001000100020001", "depth": 4, "numchild": 0, "title": "ypa", "draft_title": "ypa", "slug": "ypa", "content_type": 9, "live": true, "has_unpublished_changes": false, "url_path": "/home/hosts/ypa/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "image": null, "email_address": "test@example.com", "body": "[{\\"type\\": \\"paragraph\\", \\"value\\": \\"<p>Hi, this is Yan.</p>\\", \\"id\\": \\"01592121-e7e6-48e7-a507-cfe16f70051d\\"}]", "host_language_relationship": [{"pk": 1, "host_page": 8, "host_languages": 2}, {"pk": 2, "host_page": 8, "host_languages": 1}]}	\N	8	1
8	f	2018-08-18 03:40:02.351025+00	{"pk": 3, "path": "00010001", "depth": 2, "numchild": 3, "title": "Home", "draft_title": "Home", "slug": "home", "content_type": 5, "live": true, "has_unpublished_changes": false, "url_path": "/home/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "first_published_at": "2018-08-18T03:32:39.916Z", "last_published_at": "2018-08-18T03:32:39.916Z", "latest_revision_created_at": "2018-08-18T03:32:39.825Z", "live_revision": 1, "organisation_name": "doolay", "strapline": "doolay", "featured_page_1": 6, "featured_page_2": 5, "featured_page_3": 4, "copyright_notice": "Please contact us for these experiences"}	\N	3	1
\.


--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_pagerevision_id_seq', 8, true);


--
-- Data for Name: wagtailcore_pageviewrestriction; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_pageviewrestriction (id, password, page_id, restriction_type) FROM stdin;
\.


--
-- Data for Name: wagtailcore_pageviewrestriction_groups; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_pageviewrestriction_groups (id, pageviewrestriction_id, group_id) FROM stdin;
\.


--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_pageviewrestriction_groups_id_seq', 1, false);


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_pageviewrestriction_id_seq', 1, false);


--
-- Data for Name: wagtailcore_site; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailcore_site (id, hostname, port, is_default_site, root_page_id, site_name) FROM stdin;
2	localhost	8000	t	3	\N
\.


--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailcore_site_id_seq', 2, true);


--
-- Data for Name: wagtaildocs_document; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtaildocs_document (id, title, file, created_at, uploaded_by_user_id, collection_id) FROM stdin;
\.


--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtaildocs_document_id_seq', 1, false);


--
-- Data for Name: wagtailembeds_embed; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailembeds_embed (id, url, max_width, type, html, title, author_name, provider_name, thumbnail_url, width, height, last_updated) FROM stdin;
\.


--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailembeds_embed_id_seq', 1, false);


--
-- Data for Name: wagtailforms_formsubmission; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailforms_formsubmission (id, form_data, submit_time, page_id) FROM stdin;
\.


--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailforms_formsubmission_id_seq', 1, false);


--
-- Data for Name: wagtailimages_image; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailimages_image (id, title, file, width, height, created_at, focal_point_x, focal_point_y, focal_point_width, focal_point_height, uploaded_by_user_id, file_size, collection_id) FROM stdin;
\.


--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailimages_image_id_seq', 1, false);


--
-- Data for Name: wagtailimages_rendition; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailimages_rendition (id, file, width, height, focal_point_key, image_id, filter_spec) FROM stdin;
\.


--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailimages_rendition_id_seq', 1, false);


--
-- Data for Name: wagtailredirects_redirect; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailredirects_redirect (id, old_path, is_permanent, redirect_link, redirect_page_id, site_id) FROM stdin;
\.


--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailredirects_redirect_id_seq', 1, false);


--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailsearch_editorspick_id_seq', 1, false);


--
-- Data for Name: wagtailsearch_query; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailsearch_query (id, query_string) FROM stdin;
\.


--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailsearch_query_id_seq', 1, false);


--
-- Data for Name: wagtailsearch_querydailyhits; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailsearch_querydailyhits (id, date, hits, query_id) FROM stdin;
\.


--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailsearch_querydailyhits_id_seq', 1, false);


--
-- Data for Name: wagtailsearchpromotions_searchpromotion; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailsearchpromotions_searchpromotion (id, sort_order, description, page_id, query_id) FROM stdin;
\.


--
-- Data for Name: wagtailusers_userprofile; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY public.wagtailusers_userprofile (id, submitted_notifications, approved_notifications, rejected_notifications, user_id, preferred_language) FROM stdin;
\.


--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('public.wagtailusers_userprofile_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: blog_blogindexpage blog_blogindexpage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.blog_blogindexpage
    ADD CONSTRAINT blog_blogindexpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: blog_blogpage blog_blogpage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.blog_blogpage
    ADD CONSTRAINT blog_blogpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: bookings_booking bookings_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_booking
    ADD CONSTRAINT bookings_booking_pkey PRIMARY KEY (experience_page_id);


--
-- Name: bookings_bookingslot bookings_bookingslot_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_bookingslot
    ADD CONSTRAINT bookings_bookingslot_pkey PRIMARY KEY (id);


--
-- Name: bookings_bookingslotrequest bookings_bookingslotrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_bookingslotrequest
    ADD CONSTRAINT bookings_bookingslotrequest_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: experiences_experienceindexpage experiences_experienceindexpage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experienceindexpage
    ADD CONSTRAINT experiences_experienceindexpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: experiences_experiencepage experiences_experiencepage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experiencepage
    ADD CONSTRAINT experiences_experiencepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: home_homepage home_homepage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.home_homepage
    ADD CONSTRAINT home_homepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: hosts_hostindexpage hosts_hostindexpage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostindexpage
    ADD CONSTRAINT hosts_hostindexpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: hosts_hostlanguage hosts_hostlanguage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostlanguage
    ADD CONSTRAINT hosts_hostlanguage_pkey PRIMARY KEY (id);


--
-- Name: hosts_hostlanguagerelationship hosts_hostlanguagerelationship_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostlanguagerelationship
    ADD CONSTRAINT hosts_hostlanguagerelationship_pkey PRIMARY KEY (id);


--
-- Name: hosts_hostpage hosts_hostpage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostpage
    ADD CONSTRAINT hosts_hostpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: places_placeindexpage places_placeindexpage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.places_placeindexpage
    ADD CONSTRAINT places_placeindexpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: places_placepage places_placepage_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.places_placepage
    ADD CONSTRAINT places_placepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: taggit_tag taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collection wagtailcore_collection_path_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collection
    ADD CONSTRAINT wagtailcore_collection_path_key UNIQUE (path);


--
-- Name: wagtailcore_collection wagtailcore_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collection
    ADD CONSTRAINT wagtailcore_collection_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collectionvi_collectionviewrestrictio_988995ae_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collectionvi_collectionviewrestrictio_988995ae_uniq UNIQUE (collectionviewrestriction_id, group_id);


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collectionviewrestriction_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collectionviewrestriction_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collectionviewrestriction wagtailcore_collectionviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction
    ADD CONSTRAINT wagtailcore_collectionviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollect_group_id_collection_id_p_a21cefe9_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollect_group_id_collection_id_p_a21cefe9_uniq UNIQUE (group_id, collection_id, permission_id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollectionpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollectionpermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppageper_group_id_page_id_permiss_0898bdf8_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppageper_group_id_page_id_permiss_0898bdf8_uniq UNIQUE (group_id, page_id, permission_type);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppagepermission_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_page wagtailcore_page_path_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_path_key UNIQUE (path);


--
-- Name: wagtailcore_page wagtailcore_page_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pagerevision wagtailcore_pagerevision_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevision_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageviewrest_pageviewrestriction_id_g_d23f80bb_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageviewrest_pageviewrestriction_id_g_d23f80bb_uniq UNIQUE (pageviewrestriction_id, group_id);


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageviewrestriction_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageviewrestriction_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction wagtailcore_pageviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pageviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_site wagtailcore_site_hostname_port_2c626d70_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_hostname_port_2c626d70_uniq UNIQUE (hostname, port);


--
-- Name: wagtailcore_site wagtailcore_site_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_pkey PRIMARY KEY (id);


--
-- Name: wagtaildocs_document wagtaildocs_document_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_pkey PRIMARY KEY (id);


--
-- Name: wagtailembeds_embed wagtailembeds_embed_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailembeds_embed
    ADD CONSTRAINT wagtailembeds_embed_pkey PRIMARY KEY (id);


--
-- Name: wagtailembeds_embed wagtailembeds_embed_url_max_width_8a2922d8_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailembeds_embed
    ADD CONSTRAINT wagtailembeds_embed_url_max_width_8a2922d8_uniq UNIQUE (url, max_width);


--
-- Name: wagtailforms_formsubmission wagtailforms_formsubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_formsubmission_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_image wagtailimages_image_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_rendition wagtailimages_rendition_image_id_filter_spec_foc_323c8fe0_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_image_id_filter_spec_foc_323c8fe0_uniq UNIQUE (image_id, filter_spec, focal_point_key);


--
-- Name: wagtailimages_rendition wagtailimages_rendition_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_pkey PRIMARY KEY (id);


--
-- Name: wagtailredirects_redirect wagtailredirects_redirect_old_path_site_id_783622d7_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_old_path_site_id_783622d7_uniq UNIQUE (old_path, site_id);


--
-- Name: wagtailredirects_redirect wagtailredirects_redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearchpromotions_searchpromotion wagtailsearch_editorspick_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearchpromotions_searchpromotion
    ADD CONSTRAINT wagtailsearch_editorspick_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_query wagtailsearch_query_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_query
    ADD CONSTRAINT wagtailsearch_query_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_query wagtailsearch_query_query_string_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_query
    ADD CONSTRAINT wagtailsearch_query_query_string_key UNIQUE (query_string);


--
-- Name: wagtailsearch_querydailyhits wagtailsearch_querydailyhits_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_querydailyhits_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_querydailyhits wagtailsearch_querydailyhits_query_id_date_1dd232e6_uniq; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_querydailyhits_query_id_date_1dd232e6_uniq UNIQUE (query_id, date);


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_pkey PRIMARY KEY (id);


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: blog_blogpage_image_id_a60e2e91; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX blog_blogpage_image_id_a60e2e91 ON public.blog_blogpage USING btree (image_id);


--
-- Name: bookings_bookingslot_booking_id_f1d5b81d; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX bookings_bookingslot_booking_id_f1d5b81d ON public.bookings_bookingslot USING btree (booking_id);


--
-- Name: bookings_bookingslot_end_2ca7ab69; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX bookings_bookingslot_end_2ca7ab69 ON public.bookings_bookingslot USING btree ("end");


--
-- Name: bookings_bookingslot_start_c918ddfb; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX bookings_bookingslot_start_c918ddfb ON public.bookings_bookingslot USING btree (start);


--
-- Name: bookings_bookingslotrequest_request_date_09575924; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX bookings_bookingslotrequest_request_date_09575924 ON public.bookings_bookingslotrequest USING btree (request_date);


--
-- Name: bookings_bookingslotrequest_slot_id_6308ae1f; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX bookings_bookingslotrequest_slot_id_6308ae1f ON public.bookings_bookingslotrequest USING btree (slot_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: experiences_experienceindexpage_image_id_4e2c0d40; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX experiences_experienceindexpage_image_id_4e2c0d40 ON public.experiences_experienceindexpage USING btree (image_id);


--
-- Name: experiences_experiencepage_host_id_ad3e0880; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX experiences_experiencepage_host_id_ad3e0880 ON public.experiences_experiencepage USING btree (host_id);


--
-- Name: experiences_experiencepage_image_id_f1ecddc1; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX experiences_experiencepage_image_id_f1ecddc1 ON public.experiences_experiencepage USING btree (image_id);


--
-- Name: experiences_experiencepage_place_id_7493e9f5; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX experiences_experiencepage_place_id_7493e9f5 ON public.experiences_experiencepage USING btree (place_id);


--
-- Name: home_homepage_featured_page_1_id_74aee3ad; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX home_homepage_featured_page_1_id_74aee3ad ON public.home_homepage USING btree (featured_page_1_id);


--
-- Name: home_homepage_featured_page_2_id_0565a3ea; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX home_homepage_featured_page_2_id_0565a3ea ON public.home_homepage USING btree (featured_page_2_id);


--
-- Name: home_homepage_featured_page_3_id_12384f7d; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX home_homepage_featured_page_3_id_12384f7d ON public.home_homepage USING btree (featured_page_3_id);


--
-- Name: hosts_hostindexpage_image_id_13505f4a; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX hosts_hostindexpage_image_id_13505f4a ON public.hosts_hostindexpage USING btree (image_id);


--
-- Name: hosts_hostlanguagerelationship_host_languages_id_4be56b83; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX hosts_hostlanguagerelationship_host_languages_id_4be56b83 ON public.hosts_hostlanguagerelationship USING btree (host_languages_id);


--
-- Name: hosts_hostlanguagerelationship_host_page_id_d602f6e0; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX hosts_hostlanguagerelationship_host_page_id_d602f6e0 ON public.hosts_hostlanguagerelationship USING btree (host_page_id);


--
-- Name: hosts_hostpage_image_id_7fe4bb8b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX hosts_hostpage_image_id_7fe4bb8b ON public.hosts_hostpage USING btree (image_id);


--
-- Name: places_placeindexpage_image_id_7d8b10dc; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX places_placeindexpage_image_id_7d8b10dc ON public.places_placeindexpage USING btree (image_id);


--
-- Name: places_placepage_image_id_c0cc44d5; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX places_placepage_image_id_c0cc44d5 ON public.places_placepage USING btree (image_id);


--
-- Name: taggit_tag_name_58eb2ed9_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX taggit_tag_name_58eb2ed9_like ON public.taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_6be58b2c_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX taggit_tag_slug_6be58b2c_like ON public.taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_content_type_id_9957a03c; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX taggit_taggeditem_content_type_id_9957a03c ON public.taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_content_type_id_object_id_196cc965_idx; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX taggit_taggeditem_content_type_id_object_id_196cc965_idx ON public.taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: taggit_taggeditem_object_id_e2d7d1df; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX taggit_taggeditem_object_id_e2d7d1df ON public.taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_tag_id_f4f5b767; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX taggit_taggeditem_tag_id_f4f5b767 ON public.taggit_taggeditem USING btree (tag_id);


--
-- Name: wagtailcore_collection_path_d848dc19_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_collection_path_d848dc19_like ON public.wagtailcore_collection USING btree (path varchar_pattern_ops);


--
-- Name: wagtailcore_collectionview_collectionviewrestriction__47320efd; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_collectionview_collectionviewrestriction__47320efd ON public.wagtailcore_collectionviewrestriction_groups USING btree (collectionviewrestriction_id);


--
-- Name: wagtailcore_collectionviewrestriction_collection_id_761908ec; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_collectionviewrestriction_collection_id_761908ec ON public.wagtailcore_collectionviewrestriction USING btree (collection_id);


--
-- Name: wagtailcore_collectionviewrestriction_groups_group_id_1823f2a3; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_collectionviewrestriction_groups_group_id_1823f2a3 ON public.wagtailcore_collectionviewrestriction_groups USING btree (group_id);


--
-- Name: wagtailcore_groupcollectionpermission_collection_id_5423575a; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_groupcollectionpermission_collection_id_5423575a ON public.wagtailcore_groupcollectionpermission USING btree (collection_id);


--
-- Name: wagtailcore_groupcollectionpermission_group_id_05d61460; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_groupcollectionpermission_group_id_05d61460 ON public.wagtailcore_groupcollectionpermission USING btree (group_id);


--
-- Name: wagtailcore_groupcollectionpermission_permission_id_1b626275; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_groupcollectionpermission_permission_id_1b626275 ON public.wagtailcore_groupcollectionpermission USING btree (permission_id);


--
-- Name: wagtailcore_grouppagepermission_group_id_fc07e671; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_grouppagepermission_group_id_fc07e671 ON public.wagtailcore_grouppagepermission USING btree (group_id);


--
-- Name: wagtailcore_grouppagepermission_page_id_710b114a; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_grouppagepermission_page_id_710b114a ON public.wagtailcore_grouppagepermission USING btree (page_id);


--
-- Name: wagtailcore_page_content_type_id_c28424df; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_content_type_id_c28424df ON public.wagtailcore_page USING btree (content_type_id);


--
-- Name: wagtailcore_page_first_published_at_2b5dd637; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_first_published_at_2b5dd637 ON public.wagtailcore_page USING btree (first_published_at);


--
-- Name: wagtailcore_page_live_revision_id_930bd822; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_live_revision_id_930bd822 ON public.wagtailcore_page USING btree (live_revision_id);


--
-- Name: wagtailcore_page_owner_id_fbf7c332; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_owner_id_fbf7c332 ON public.wagtailcore_page USING btree (owner_id);


--
-- Name: wagtailcore_page_path_98eba2c8_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_path_98eba2c8_like ON public.wagtailcore_page USING btree (path varchar_pattern_ops);


--
-- Name: wagtailcore_page_slug_e7c11b8f; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_slug_e7c11b8f ON public.wagtailcore_page USING btree (slug);


--
-- Name: wagtailcore_page_slug_e7c11b8f_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_page_slug_e7c11b8f_like ON public.wagtailcore_page USING btree (slug varchar_pattern_ops);


--
-- Name: wagtailcore_pagerevision_created_at_66954e3b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pagerevision_created_at_66954e3b ON public.wagtailcore_pagerevision USING btree (created_at);


--
-- Name: wagtailcore_pagerevision_page_id_d421cc1d; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pagerevision_page_id_d421cc1d ON public.wagtailcore_pagerevision USING btree (page_id);


--
-- Name: wagtailcore_pagerevision_submitted_for_moderation_c682e44c; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pagerevision_submitted_for_moderation_c682e44c ON public.wagtailcore_pagerevision USING btree (submitted_for_moderation);


--
-- Name: wagtailcore_pagerevision_user_id_2409d2f4; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pagerevision_user_id_2409d2f4 ON public.wagtailcore_pagerevision USING btree (user_id);


--
-- Name: wagtailcore_pageviewrestri_pageviewrestriction_id_f147a99a; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pageviewrestri_pageviewrestriction_id_f147a99a ON public.wagtailcore_pageviewrestriction_groups USING btree (pageviewrestriction_id);


--
-- Name: wagtailcore_pageviewrestriction_groups_group_id_6460f223; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pageviewrestriction_groups_group_id_6460f223 ON public.wagtailcore_pageviewrestriction_groups USING btree (group_id);


--
-- Name: wagtailcore_pageviewrestriction_page_id_15a8bea6; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_pageviewrestriction_page_id_15a8bea6 ON public.wagtailcore_pageviewrestriction USING btree (page_id);


--
-- Name: wagtailcore_site_hostname_96b20b46; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_site_hostname_96b20b46 ON public.wagtailcore_site USING btree (hostname);


--
-- Name: wagtailcore_site_hostname_96b20b46_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_site_hostname_96b20b46_like ON public.wagtailcore_site USING btree (hostname varchar_pattern_ops);


--
-- Name: wagtailcore_site_root_page_id_e02fb95c; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailcore_site_root_page_id_e02fb95c ON public.wagtailcore_site USING btree (root_page_id);


--
-- Name: wagtaildocs_document_collection_id_23881625; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtaildocs_document_collection_id_23881625 ON public.wagtaildocs_document USING btree (collection_id);


--
-- Name: wagtaildocs_document_uploaded_by_user_id_17258b41; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtaildocs_document_uploaded_by_user_id_17258b41 ON public.wagtaildocs_document USING btree (uploaded_by_user_id);


--
-- Name: wagtailforms_formsubmission_page_id_e48e93e7; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailforms_formsubmission_page_id_e48e93e7 ON public.wagtailforms_formsubmission USING btree (page_id);


--
-- Name: wagtailimages_image_collection_id_c2f8af7e; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailimages_image_collection_id_c2f8af7e ON public.wagtailimages_image USING btree (collection_id);


--
-- Name: wagtailimages_image_created_at_86fa6cd4; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailimages_image_created_at_86fa6cd4 ON public.wagtailimages_image USING btree (created_at);


--
-- Name: wagtailimages_image_uploaded_by_user_id_5d73dc75; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailimages_image_uploaded_by_user_id_5d73dc75 ON public.wagtailimages_image USING btree (uploaded_by_user_id);


--
-- Name: wagtailimages_rendition_filter_spec_1cba3201; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailimages_rendition_filter_spec_1cba3201 ON public.wagtailimages_rendition USING btree (filter_spec);


--
-- Name: wagtailimages_rendition_filter_spec_1cba3201_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailimages_rendition_filter_spec_1cba3201_like ON public.wagtailimages_rendition USING btree (filter_spec varchar_pattern_ops);


--
-- Name: wagtailimages_rendition_image_id_3e1fd774; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailimages_rendition_image_id_3e1fd774 ON public.wagtailimages_rendition USING btree (image_id);


--
-- Name: wagtailredirects_redirect_old_path_bb35247b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailredirects_redirect_old_path_bb35247b ON public.wagtailredirects_redirect USING btree (old_path);


--
-- Name: wagtailredirects_redirect_old_path_bb35247b_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailredirects_redirect_old_path_bb35247b_like ON public.wagtailredirects_redirect USING btree (old_path varchar_pattern_ops);


--
-- Name: wagtailredirects_redirect_redirect_page_id_b5728a8f; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailredirects_redirect_redirect_page_id_b5728a8f ON public.wagtailredirects_redirect USING btree (redirect_page_id);


--
-- Name: wagtailredirects_redirect_site_id_780a0e1e; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailredirects_redirect_site_id_780a0e1e ON public.wagtailredirects_redirect USING btree (site_id);


--
-- Name: wagtailsearch_editorspick_page_id_28cbc274; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailsearch_editorspick_page_id_28cbc274 ON public.wagtailsearchpromotions_searchpromotion USING btree (page_id);


--
-- Name: wagtailsearch_editorspick_query_id_c6eee4a0; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailsearch_editorspick_query_id_c6eee4a0 ON public.wagtailsearchpromotions_searchpromotion USING btree (query_id);


--
-- Name: wagtailsearch_query_query_string_e785ea07_like; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailsearch_query_query_string_e785ea07_like ON public.wagtailsearch_query USING btree (query_string varchar_pattern_ops);


--
-- Name: wagtailsearch_querydailyhits_query_id_2185994b; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX wagtailsearch_querydailyhits_query_id_2185994b ON public.wagtailsearch_querydailyhits USING btree (query_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogindexpage blog_blogindexpage_page_ptr_id_d87c3ac2_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.blog_blogindexpage
    ADD CONSTRAINT blog_blogindexpage_page_ptr_id_d87c3ac2_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogpage blog_blogpage_image_id_a60e2e91_fk_wagtailimages_image_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.blog_blogpage
    ADD CONSTRAINT blog_blogpage_image_id_a60e2e91_fk_wagtailimages_image_id FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogpage blog_blogpage_page_ptr_id_1d78e2b7_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.blog_blogpage
    ADD CONSTRAINT blog_blogpage_page_ptr_id_1d78e2b7_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bookings_booking bookings_booking_experience_page_id_65e26815_fk_experienc; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_booking
    ADD CONSTRAINT bookings_booking_experience_page_id_65e26815_fk_experienc FOREIGN KEY (experience_page_id) REFERENCES public.experiences_experiencepage(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bookings_bookingslot bookings_bookingslot_booking_id_f1d5b81d_fk_bookings_; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_bookingslot
    ADD CONSTRAINT bookings_bookingslot_booking_id_f1d5b81d_fk_bookings_ FOREIGN KEY (booking_id) REFERENCES public.bookings_booking(experience_page_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bookings_bookingslotrequest bookings_bookingslot_slot_id_6308ae1f_fk_bookings_; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.bookings_bookingslotrequest
    ADD CONSTRAINT bookings_bookingslot_slot_id_6308ae1f_fk_bookings_ FOREIGN KEY (slot_id) REFERENCES public.bookings_bookingslot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: experiences_experiencepage experiences_experien_host_id_ad3e0880_fk_hosts_hos; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experiencepage
    ADD CONSTRAINT experiences_experien_host_id_ad3e0880_fk_hosts_hos FOREIGN KEY (host_id) REFERENCES public.hosts_hostpage(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: experiences_experienceindexpage experiences_experien_image_id_4e2c0d40_fk_wagtailim; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experienceindexpage
    ADD CONSTRAINT experiences_experien_image_id_4e2c0d40_fk_wagtailim FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: experiences_experiencepage experiences_experien_image_id_f1ecddc1_fk_wagtailim; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experiencepage
    ADD CONSTRAINT experiences_experien_image_id_f1ecddc1_fk_wagtailim FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: experiences_experiencepage experiences_experien_page_ptr_id_2c3b7c8d_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experiencepage
    ADD CONSTRAINT experiences_experien_page_ptr_id_2c3b7c8d_fk_wagtailco FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: experiences_experienceindexpage experiences_experien_page_ptr_id_fe931403_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experienceindexpage
    ADD CONSTRAINT experiences_experien_page_ptr_id_fe931403_fk_wagtailco FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: experiences_experiencepage experiences_experien_place_id_7493e9f5_fk_places_pl; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.experiences_experiencepage
    ADD CONSTRAINT experiences_experien_place_id_7493e9f5_fk_places_pl FOREIGN KEY (place_id) REFERENCES public.places_placepage(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_homepage home_homepage_featured_page_1_id_74aee3ad_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.home_homepage
    ADD CONSTRAINT home_homepage_featured_page_1_id_74aee3ad_fk_wagtailco FOREIGN KEY (featured_page_1_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_homepage home_homepage_featured_page_2_id_0565a3ea_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.home_homepage
    ADD CONSTRAINT home_homepage_featured_page_2_id_0565a3ea_fk_wagtailco FOREIGN KEY (featured_page_2_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_homepage home_homepage_featured_page_3_id_12384f7d_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.home_homepage
    ADD CONSTRAINT home_homepage_featured_page_3_id_12384f7d_fk_wagtailco FOREIGN KEY (featured_page_3_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_homepage home_homepage_page_ptr_id_e5b77cf7_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.home_homepage
    ADD CONSTRAINT home_homepage_page_ptr_id_e5b77cf7_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hosts_hostindexpage hosts_hostindexpage_image_id_13505f4a_fk_wagtailimages_image_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostindexpage
    ADD CONSTRAINT hosts_hostindexpage_image_id_13505f4a_fk_wagtailimages_image_id FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hosts_hostindexpage hosts_hostindexpage_page_ptr_id_88ce4e59_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostindexpage
    ADD CONSTRAINT hosts_hostindexpage_page_ptr_id_88ce4e59_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hosts_hostlanguagerelationship hosts_hostlanguagere_host_languages_id_4be56b83_fk_hosts_hos; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostlanguagerelationship
    ADD CONSTRAINT hosts_hostlanguagere_host_languages_id_4be56b83_fk_hosts_hos FOREIGN KEY (host_languages_id) REFERENCES public.hosts_hostlanguage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hosts_hostlanguagerelationship hosts_hostlanguagere_host_page_id_d602f6e0_fk_hosts_hos; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostlanguagerelationship
    ADD CONSTRAINT hosts_hostlanguagere_host_page_id_d602f6e0_fk_hosts_hos FOREIGN KEY (host_page_id) REFERENCES public.hosts_hostpage(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hosts_hostpage hosts_hostpage_image_id_7fe4bb8b_fk_wagtailimages_image_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostpage
    ADD CONSTRAINT hosts_hostpage_image_id_7fe4bb8b_fk_wagtailimages_image_id FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: hosts_hostpage hosts_hostpage_page_ptr_id_fc2906a1_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.hosts_hostpage
    ADD CONSTRAINT hosts_hostpage_page_ptr_id_fc2906a1_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: places_placeindexpage places_placeindexpag_image_id_7d8b10dc_fk_wagtailim; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.places_placeindexpage
    ADD CONSTRAINT places_placeindexpag_image_id_7d8b10dc_fk_wagtailim FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: places_placeindexpage places_placeindexpag_page_ptr_id_08fc8b3e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.places_placeindexpage
    ADD CONSTRAINT places_placeindexpag_page_ptr_id_08fc8b3e_fk_wagtailco FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: places_placepage places_placepage_image_id_c0cc44d5_fk_wagtailimages_image_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.places_placepage
    ADD CONSTRAINT places_placepage_image_id_c0cc44d5_fk_wagtailimages_image_id FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: places_placepage places_placepage_page_ptr_id_8525258f_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.places_placepage
    ADD CONSTRAINT places_placepage_page_ptr_id_8525258f_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_9957a03c_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_9957a03c_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_collectionviewrestriction wagtailcore_collecti_collection_id_761908ec_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction
    ADD CONSTRAINT wagtailcore_collecti_collection_id_761908ec_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collecti_collectionviewrestri_47320efd_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collecti_collectionviewrestri_47320efd_fk_wagtailco FOREIGN KEY (collectionviewrestriction_id) REFERENCES public.wagtailcore_collectionviewrestriction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collecti_group_id_1823f2a3_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collecti_group_id_1823f2a3_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcol_collection_id_5423575a_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcol_collection_id_5423575a_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcol_group_id_05d61460_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcol_group_id_05d61460_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcol_permission_id_1b626275_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcol_permission_id_1b626275_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppag_group_id_fc07e671_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppag_group_id_fc07e671_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppag_page_id_710b114a_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppag_page_id_710b114a_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_content_type_id_c28424df_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_content_type_id_c28424df_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_live_revision_id_930bd822_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_live_revision_id_930bd822_fk_wagtailco FOREIGN KEY (live_revision_id) REFERENCES public.wagtailcore_pagerevision(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_owner_id_fbf7c332_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_owner_id_fbf7c332_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagerevision wagtailcore_pagerevi_page_id_d421cc1d_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevi_page_id_d421cc1d_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagerevision wagtailcore_pagerevision_user_id_2409d2f4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevision_user_id_2409d2f4_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageview_group_id_6460f223_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageview_group_id_6460f223_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pageviewrestriction wagtailcore_pageview_page_id_15a8bea6_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pageview_page_id_15a8bea6_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageview_pageviewrestriction__f147a99a_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageview_pageviewrestriction__f147a99a_fk_wagtailco FOREIGN KEY (pageviewrestriction_id) REFERENCES public.wagtailcore_pageviewrestriction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_site wagtailcore_site_root_page_id_e02fb95c_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_root_page_id_e02fb95c_fk_wagtailcore_page_id FOREIGN KEY (root_page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtaildocs_document wagtaildocs_document_collection_id_23881625_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_collection_id_23881625_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtaildocs_document wagtaildocs_document_uploaded_by_user_id_17258b41_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_uploaded_by_user_id_17258b41_fk_auth_user FOREIGN KEY (uploaded_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailforms_formsubmission wagtailforms_formsub_page_id_e48e93e7_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_formsub_page_id_e48e93e7_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_image wagtailimages_image_collection_id_c2f8af7e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_collection_id_c2f8af7e_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_image wagtailimages_image_uploaded_by_user_id_5d73dc75_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_uploaded_by_user_id_5d73dc75_fk_auth_user FOREIGN KEY (uploaded_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_rendition wagtailimages_rendit_image_id_3e1fd774_fk_wagtailim; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendit_image_id_3e1fd774_fk_wagtailim FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailredirects_redirect wagtailredirects_red_redirect_page_id_b5728a8f_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_red_redirect_page_id_b5728a8f_fk_wagtailco FOREIGN KEY (redirect_page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailredirects_redirect wagtailredirects_red_site_id_780a0e1e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_red_site_id_780a0e1e_fk_wagtailco FOREIGN KEY (site_id) REFERENCES public.wagtailcore_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearchpromotions_searchpromotion wagtailsearch_editor_query_id_c6eee4a0_fk_wagtailse; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearchpromotions_searchpromotion
    ADD CONSTRAINT wagtailsearch_editor_query_id_c6eee4a0_fk_wagtailse FOREIGN KEY (query_id) REFERENCES public.wagtailsearch_query(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearch_querydailyhits wagtailsearch_queryd_query_id_2185994b_fk_wagtailse; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_queryd_query_id_2185994b_fk_wagtailse FOREIGN KEY (query_id) REFERENCES public.wagtailsearch_query(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearchpromotions_searchpromotion wagtailsearchpromoti_page_id_71920f17_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailsearchpromotions_searchpromotion
    ADD CONSTRAINT wagtailsearchpromoti_page_id_71920f17_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_user_id_59c92331_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_user_id_59c92331_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: vagrant
--

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

