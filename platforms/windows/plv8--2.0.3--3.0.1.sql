  CREATE OR REPLACE FUNCTION plv8_version ( )
  RETURNS TEXT AS
  $$
  	return "3.0.1";
  $$ LANGUAGE plv8;
  CREATE OR REPLACE FUNCTION plv8_call_handler() RETURNS language_handler
    AS 'MODULE_PATHNAME' LANGUAGE C;
  CREATE OR REPLACE FUNCTION plv8_inline_handler(internal) RETURNS void
    AS 'MODULE_PATHNAME' LANGUAGE C;
  CREATE OR REPLACE FUNCTION plv8_call_validator(oid) RETURNS void
    AS 'MODULE_PATHNAME' LANGUAGE C;
