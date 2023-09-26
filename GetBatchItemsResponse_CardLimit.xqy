xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "http://erste.hu/ebti/schema";
(:: import schema at "../SLCARD_CARD_MGMT_GetModifyCardLimitStatusV1/WSDLs/ebti_qry.xsd" ::)

declare namespace get="http://v1.service.card_mgmt.slcard.erste.hu/GetModifyCardLimitStatus";
(:: import schema at "../SLCARD_CARD_MGMT_GetModifyCardLimitStatusV1/WSDLs/GetModifyCardLimitStatusV1_schema1.xsd" ::)

declare namespace get1="http://v1.dto.service.card_mgmt.slcard.erste.hu/GetModifyCardLimitStatusV1Response";
(:: import schema at "../SLCARD_CARD_MGMT_GetModifyCardLimitStatusV1/WSDLs/GetModifyCardLimitStatusV1_schema2.xsd" ::)

declare namespace pub="http://v1.dto.card_mgmt.slcard.erste.hu/PublishModifyCardLimitStatusRequest";
(:: import schema at "../SLCARD_CARD_MGMT_GetModifyCardLimitStatusV1/WSDLs/GetModifyCardLimitStatusV1_schema4.xsd" ::)

declare namespace com="http://erste.hu/common_v1";
(:: import schema at "../SLCARD_CARD_MGMT_GetModifyCardLimitStatusV1/WSDLs/GetModifyCardLimitStatusV1_schema6.xsd" ::)


declare  variable $req as element() (:: schema-element(get:getModifyCardLimitStatusResponse) ::) external;
declare  variable $ctx as element() (:: schema-element(com:MessageContext) ::) external;

declare function local:func($req as element() (:: schema-element(get:getModifyCardLimitStatusResponse) ::), $ctx as element() (:: schema-element(com:MessageContext) ::)) as element() (:: schema-element(ebti_get_batch_items_response) ::)
{
<ebti_get_batch_items_response xmlns="http://erste.hu/ebti/schema">
	<batch_info>
		<sender_app_id>{fn:data($ctx/com:source)}</sender_app_id>
		<batch_id>{fn:substring-after(fn:data($req/get:GetModifyCardLimitStatusV1Response/get1:publishModifyCardLimitStatusRequest/pub:orderId), ':')}</batch_id>
		<target_plugin>CARD_UP</target_plugin>
                {if(fn:data($req/get:GetModifyCardLimitStatusV1Response/get1:publishModifyCardLimitStatusRequest/pub:status) = "WAITING")
                then (
                 <batch_state>PARSED_OK</batch_state>
                )
                else if(fn:data($req/get:GetModifyCardLimitStatusV1Response/get1:publishModifyCardLimitStatusRequest/pub:status) = "REJECTED")
                then(
                  <batch_state>PARSED_OK</batch_state>
                )
                else(
                  <batch_state>{fn:data($req/get:GetModifyCardLimitStatusV1Response/get1:publishModifyCardLimitStatusRequest/pub:status)}</batch_state>
                )}
	</batch_info>
	<tra_item_states>
		<tra_item_state>
			<transaction_id>1</transaction_id>
                        {if(fn:data($req/get:GetModifyCardLimitStatusV1Response/get1:publishModifyCardLimitStatusRequest/pub:status) = "WAITING")
                        then (
                          <transaction_state>BEING_PROCESSED</transaction_state>
                        )
                        else(
                          <transaction_state>{fn:data($req/get:GetModifyCardLimitStatusV1Response/get1:publishModifyCardLimitStatusRequest/pub:status)}</transaction_state>
                          )}
		</tra_item_state>
	</tra_item_states>
</ebti_get_batch_items_response>

};

local:func($req,$ctx)
