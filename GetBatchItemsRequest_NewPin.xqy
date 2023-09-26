xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "http://erste.hu/ebti/schema";
(:: import schema at "../SLCARD_CARD_MGMT_GetRequestNewPinStatusV1/WSDLs/ebti_qry.xsd" ::)

declare namespace pos="http://v1.service.card_mgmt.slcard.erste.hu/GetRequestNewPinStatus";
(:: import schema at "../SLCARD_CARD_MGMT_GetRequestNewPinStatusV1/WSDLs/GetRequestNewPinStatusV1_schema1.xsd" ::)

declare namespace pos1="http://v1.dto.service.card_mgmt.slcard.erste.hu/GetRequestNewPinStatusV1Request";

declare  variable $req as element() (:: schema-element(ebti_get_batch_items_request) ::) external;

declare function local:func($req as element() (:: schema-element(ebti_get_batch_items_request) ::)) as element() (:: schema-element(pos:getRequestNewPinStatus) ::) {
    
<pos:getRequestNewPinStatus>
	<pos:GetRequestNewPinStatusV1Request>
		<pos1:messageId>ELE:{fn:data($req/batch_info/batch_id)}</pos1:messageId>
	</pos:GetRequestNewPinStatusV1Request>
</pos:getRequestNewPinStatus>

};

local:func($req)
