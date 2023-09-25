*"* use this source file for your ABAP unit test classes
*"* use this source file for your ABAP unit test classes
CLASS ltcl_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_success FOR TESTING RAISING cx_static_check,
      test_exception FOR TESTING .
ENDCLASS.


CLASS ltcl_ IMPLEMENTATION.


  METHOD test_success .

****Code to test************
    SELECT SINGLE
    FROM /dmo/carrier
    FIELDS carrier_id
    INTO @DATA(result).

    IF sy-subrc <> 0.
      "No data found
      cl_abap_unit_assert=>fail( 'Implement your first test here' ).

    ENDIF.

  ENDMETHOD .

  METHOD test_exception.

  ENDMETHOD.

ENDCLASS.
