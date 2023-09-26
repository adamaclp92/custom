xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "http://erste.hu/amtr/card/schema";
(:: import schema at "../SLCARD_CARD_MGMT_PostRequestNewPinV1/WSDLs/ebti_transaction_batch.xsd" ::)

declare namespace pos="http://v1.service.card_mgmt.slcard.erste.hu/PostRequestNewPin";
(:: import schema at "../SLCARD_CARD_MGMT_PostRequestNewPinV1/WSDLs/PostRequestNewPinV1_schema1.xsd" ::)

declare namespace pos1="http://v1.dto.service.card_mgmt.slcard.erste.hu/PostRequestNewPinRequest";

declare  variable $req as element() (:: schema-element(ebti_transaction_batch_request) ::) external;

declare function local:func($req as element() (:: schema-element(ebti_transaction_batch_request) ::)) as element() (:: schema-element(pos:postRequestNewPin) ::) {
    
     <pos:postRequestNewPin>
         <pos:PostRequestNewPinRequest>
            <pos1:dummyCardNumber>{fn:data($req/transaction_items/transaction_item/modify_card_pin/card_identifier)}</pos1:dummyCardNumber>
            <pos1:cardOwnerSymId>{fn:data($req/transaction_items/transaction_item/client_no)}</pos1:cardOwnerSymId>
         </pos:PostRequestNewPinRequest>
      </pos:postRequestNewPin>

};

local:func($req)
