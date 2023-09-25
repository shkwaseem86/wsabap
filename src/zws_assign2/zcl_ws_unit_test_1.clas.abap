CLASS zcl_ws_unit_test_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

protected section.
private section.
ENDCLASS.



CLASS zcl_ws_unit_test_1 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
    TRY.
        DATA(carrier) = lcl_data=>get_carrier( i_carrier_id = c_carrier_id ).

        out->write( carrier ).

    CATCH cx_abap_invalid_value.
        out->write( | Carrier { c_carrier_id } does not exists. | ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
