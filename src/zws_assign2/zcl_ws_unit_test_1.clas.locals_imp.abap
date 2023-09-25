*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_data DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS get_carrier
    IMPORTING
        i_carrier_id TYPE /dmo/carrier_id
    RETURNING VALUE(lv_result) TYPE /dmo/carrier_id.
ENDCLASS.

CLASS lcl_data IMPLEMENTATION.
  METHOD get_carrier.
    SELECT *
    FROM /dmo/carrier
    WHERE carrier_id = @i_carrier_id
    INTO TABLE @DATA(result).
  ENDMETHOD.
ENDCLASS.
