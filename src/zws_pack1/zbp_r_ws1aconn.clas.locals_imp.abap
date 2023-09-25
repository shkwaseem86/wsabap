CLASS lhc_zr_ws1aconn DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR zr_ws1aconn
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR zr_ws1aconn~CheckSemanticKey,
      GetCities FOR DETERMINE ON SAVE
        IMPORTING keys FOR Connection1~GetCities.
ENDCLASS.

CLASS lhc_zr_ws1aconn IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD CheckSemanticKey.
    READ ENTITIES OF zr_ws1aconn IN LOCAL MODE
    ENTITY Connection1
    FIELDS ( CarrierID ConnectionID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).
      SELECT FROM zws1aconn
             FIELDS uuid
              WHERE carrier_id     = @connection-CarrierID
              AND connection_id = @connection-ConnectionID
                AND uuid          <> @connection-uuid
        UNION
        SELECT FROM zws1aconn_d
             FIELDS uuid
              WHERE carrierid      = @connection-CarrierID
              AND connectionid =  @connection-ConnectionID
                AND uuid          <> @connection-uuid

         INTO TABLE @DATA(check_result).


      IF check_result IS NOT INITIAL.

        DATA(message) = me->new_message(
                          id       = 'ZS4D400'
                          number   = '001'
                          severity = ms-error
                          v1       = connection-CarrierID
                          v2       = connection-ConnectionID
                        ).



        DATA reported_record LIKE LINE OF reported-connection1.

        reported_record-%tky =  connection-%tky.
        reported_record-%msg = message.
        reported_record-%element-AirportFromID = if_abap_behv=>mk-on.
        reported_record-%element-AirportToID   = if_abap_behv=>mk-on.

        APPEND reported_record TO reported-connection1.

        DATA failed_record LIKE LINE OF failed-Connection1.

        failed_record-%tky = connection-%tky.
        APPEND failed_record TO failed-Connection1.

      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD GetCities.

    READ ENTITIES OF zr_ws1aconn IN LOCAL MODE
    ENTITY connection1
    FIELDS ( AirportFromID AirportToID )
  WITH CORRESPONDING #( keys )
             RESULT DATA(connections).


    LOOP AT connections INTO DATA(connection).

      SELECT SINGLE
        FROM /DMO/I_Airport
      FIELDS city, CountryCode
       WHERE AirportID = @connection-AirportFromID
        INTO ( @connection-CityFrom, @connection-CountryTo ).

      SELECT SINGLE
        FROM /DMO/I_Airport
      FIELDS city, CountryCode
       WHERE AirportID = @connection-AirportToID
        INTO ( @connection-CityTo, @connection-CountryTo ).

      MODIFY connections FROM connection.



      DATA connections_upd TYPE TABLE FOR UPDATE zr_ws1aconn.

      connections_upd = CORRESPONDING #( connections ).


      MODIFY ENTITIES OF zr_ws1aconn IN LOCAL MODE
               ENTITY Connection1
               UPDATE
               FIELDS ( CityFrom CountryFrom CityTo CountryTo )
                 WITH connections_upd
             REPORTED DATA(reported_records).

      reported-connection1 = CORRESPONDING #( reported_records-connection1 ).


    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
