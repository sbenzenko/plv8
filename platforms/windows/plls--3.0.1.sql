#include "pg_config.h"
#if PG_VERSION_NUM < 90100
-- adjust this setting to control where the objects get created.
SET search_path = public;

BEGIN;
#endif

CREATE FUNCTION plls_call_handler() RETURNS language_handler
	AS 'MODULE_PATHNAME' LANGUAGE C;

#if PG_VERSION_NUM >= 90000
CREATE FUNCTION plls_inline_handler(internal) RETURNS void
	AS 'MODULE_PATHNAME' LANGUAGE C;
#endif

CREATE FUNCTION plls_call_validator(oid) RETURNS void
	AS 'MODULE_PATHNAME' LANGUAGE C;

CREATE TRUSTED LANGUAGE plls
	HANDLER plls_call_handler
#if PG_VERSION_NUM >= 90000
	INLINE plls_inline_handler
#endif
	VALIDATOR plls_call_validator;

#ifdef LANG_plv8
CREATE DOMAIN plv8_int2array AS int2[];
CREATE DOMAIN plv8_int4array AS int4[];
CREATE DOMAIN plv8_float4array AS float4[];
CREATE DOMAIN plv8_float8array AS float8[];
CREATE DOMAIN plv8_int8array AS int8[];

CREATE OR REPLACE FUNCTION plv8_version ( )
RETURNS TEXT AS
$$
	return "3.0.1";
$$ LANGUAGE plv8;

CREATE FUNCTION plv8_reset() RETURNS void
	AS 'MODULE_PATHNAME' LANGUAGE C;

CREATE FUNCTION plv8_info() RETURNS JSON
	AS 'MODULE_PATHNAME' LANGUAGE C;
REVOKE ALL ON FUNCTION plv8_info() FROM PUBLIC;

#endif


#if PG_VERSION_NUM < 90100
COMMIT;
#endif
