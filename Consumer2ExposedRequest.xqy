xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://s-itsolutions.at/KrimiAPSClientInterface/RequestHeader";
(:: import schema at "../../_common/WSDLs/KrimiClientInterfaceRequestHeader.xsd" ::)
declare namespace ns2="http://s-itsolutions.at/KrimiAPSClientInterface/ClientDetailRequest";
(:: import schema at "../../_common/WSDLs/ClientDetailRequest.xsd" ::)
declare namespace ns4="http://s-itsolutions.at/KrimiAPS/KRIMIAPSStructureTypeDefinitions";
(:: import schema at "../../_common/WSDLs/KRIMIAPSStructureTypeDefinitions.xsd" ::)
declare namespace sear="http://v1.service.szk.dslloan.erste.hu/SearchAggregatedTransactionHistoryV1";
(:: import schema at "../WSDLs/SearchAggregatedTransactionHistoryV1.xsd" ::)


declare variable $ns1:krimireq as element() (:: schema-element(ns1:KrimiAPSClientRequest) ::) external;

declare function local:func($ns1:krimireq as element() (:: schema-element(ns1:KrimiAPSClientRequest) ::)) as element() (:: schema-element(sear:searchAggregatedTransactionHistoryV1) ::) {
<sear:searchAggregatedTransactionHistoryV1>
  <sear:clientIdentifier>{fn:data($ns1:krimireq/ns1:ServiceRequest/ns2:RequestData/ns2:XFields/ns4:txtTaxNumberParam)}</sear:clientIdentifier>
</sear:searchAggregatedTransactionHistoryV1>
};

local:func($ns1:krimireq)
