@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Carrried ID'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZWS_I_CarrierVH as select from /dmo/carrier
{
      @UI.lineItem: [{position: 10 }]
  key carrier_id as CarrierID,
      @UI.lineItem: [{position: 20 }]
      name       as Name
        
}
