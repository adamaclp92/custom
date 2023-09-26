xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace com="http://erste.hu/common_v1";
(:: import schema at "../SLCARD_CARD_MGMT_PostModifyCardLimitV1/WSDLs/MessageContext_V1.xsd" ::)

declare default element namespace "http://erste.hu/amtr/card/schema";
(:: import schema at "../SLCARD_CARD_MGMT_PostModifyCardLimitV1/WSDLs/ebti_transaction_batch.xsd" ::)

declare  variable $ctx as element() (:: schema-element(ebti_transaction_batch_request) ::) external;

declare function local:func($ctx as element() (:: schema-element(ebti_transaction_batch_request) ::)) 
  as element() (:: schema-element(com:MessageContext) ::){
  
<com:MessageContext xmlns:com="http://erste.hu/common_v1" xmlns:sap="http://sap.erste.hu/common_v1">
	<com:source>{fn:data($ctx/batch_info/sender_app_id)}</com:source>
	<com:src-module>{fn:data($ctx/batch_info/channel_code)}</com:src-module>
	<com:id>{fn-bea:uuid()}</com:id>	
	<!-- <com:id>{fn:data($ctx/batch_info/batch_id)}</com:id>	 -->
	<com:correlid>ELE:{fn:data($ctx/batch_info/batch_id)}</com:correlid>
	<com:userid>_ELE_osb_ws</com:userid>
</com:MessageContext>
};

local:func($ctx)
