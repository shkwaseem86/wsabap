CLASS zcl_ws_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ws_expr IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* CONSTANTS c_number TYPE i VALUE 1234.
*
*    SELECT FROM /dmo/carrier
*         FIELDS 'Hello'    AS Character,    " Type c
*                 1         AS Integer1,     " Type i
*                -1         AS Integer2,     " Type i
*
*                @c_number  AS constant      " Type i  (same as constant)
*
*          INTO TABLE @DATA(result).
*
*    out->write(
*      EXPORTING
*        data   = result
*        name   = 'RESULT'
*    ).




    SELECT FROM /dmo/carrier
         FIELDS '19891109'                           AS char_8,
                CAST( '19891109' AS CHAR( 4 ) )      AS char_4,
                CAST( '19891109' AS NUMC( 8  ) )     AS numc_8,

                CAST( '19891109' AS INT4 )          AS integer,
                CAST( '19891109' AS DEC( 10, 2 ) )  AS dec_10_2,
                CAST( '19891109' AS FLTP )          AS fltp,

                CAST( '19891109' AS DATS )          AS date

           INTO TABLE @DATA(result).

    out->write(
      EXPORTING
        data   = result
        name   = 'RESULT'
    ).




  ENDMETHOD.
ENDCLASS.
