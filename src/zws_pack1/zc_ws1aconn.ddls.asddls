@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_WS1ACONN'
define root view entity ZC_WS1ACONN
  provider contract transactional_query
  as projection on ZR_WS1ACONN
{
  key UUID,
  CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  AirportToID,
  CityTo,
  CountryTo,
  LocalLastChangedAt
  
   
}
