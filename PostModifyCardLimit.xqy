xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "http://erste.hu/amtr/card/schema";
(:: import schema at "../SLCARD_CARD_MGMT_PostModifyCardLimitV1/WSDLs/ebti_transaction_batch.xsd" ::)

declare namespace pos="http://v1.service.card_mgmt.slcard.erste.hu/PostModifyCardLimit";
(:: import schema at "../SLCARD_CARD_MGMT_PostModifyCardLimitV1/WSDLs/PostModifyCardLimitV1_schema1.xsd" ::)

declare namespace pos1="http://v1.dto.service.card_mgmt.slcard.erste.hu/PostModifyCardLimitRequest";

declare  variable $req as element() (:: schema-element(ebti_transaction_batch_request) ::) external;

declare function local:func($req as element() (:: schema-element(ebti_transaction_batch_request) ::)) as element() (:: schema-element(pos:postModifyCardLimit) ::) {
    
     <pos:postModifyCardLimit>
         <pos:PostModifyCardLimitRequest>
            <pos1:dummyCardNumber>{fn:data($req/transaction_items/transaction_item/modify_card_limit/card_identifier)}</pos1:dummyCardNumber>
            <pos1:withdrawalLimit>{fn:data($req/transaction_items/transaction_item/modify_card_limit/card_limits/withdrawal_limit)}</pos1:withdrawalLimit>
            <pos1:purchaseLimit>{fn:data($req/transaction_items/transaction_item/modify_card_limit/card_limits/purchase_limit)}</pos1:purchaseLimit>
            <pos1:cardOwnerSymId>{fn:data($req/transaction_items/transaction_item/client_no)}</pos1:cardOwnerSymId>
         </pos:PostModifyCardLimitRequest>
      </pos:postModifyCardLimit>

};

local:func($req)
