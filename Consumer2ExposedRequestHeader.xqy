xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://erste.hu/common_v1";
(:: import schema at "../../../Infrastructure/CDM/WSDLs/MessageContext_V1.xsd" ::)
declare namespace ns1="http://s-itsolutions.at/KrimiAPSClientInterface/RequestHeader";
(:: import schema at "../WSDLs/KrimiClientInterfaceRequestHeader.xsd" ::)
declare namespace ns3="http://s-itsolutions.at/KrimiAPSClientInterface/ClientDetailRequest";
(:: import schema at "../WSDLs/ClientDetailRequest.xsd" ::)

declare variable $ns1:krimireq as element() (:: schema-element(ns1:KrimiAPSClientRequest) ::) external;

declare function local:func($ns1:krimireq as element() (:: schema-element(ns1:KrimiAPSClientRequest) ::)) as element() (:: schema-element(ns2:MessageContext) ::) {
    <ns2:MessageContext>
        <ns2:source>{fn:data($ns1:krimireq/ns1:Header/ns1:CallingSystemName)}</ns2:source>
        <ns2:src-module>{fn:data($ns1:krimireq/ns1:Header/ns1:RequestType)}</ns2:src-module>
        <ns2:id>DUMMY:0123456789</ns2:id>
        <ns2:rrid>{fn:data($ns1:krimireq/ns1:Header/ns1:RequestReplyID)}</ns2:rrid>
        <ns2:correlid>
            {fn:concat(fn:data($ns1:krimireq/ns1:ServiceRequest/ns3:RequestData/ns3:ClientIdentifier),
            ":", fn:data($ns1:krimireq/ns1:Header/ns1:MandantNumber),
            ":", fn:data($ns1:krimireq/ns1:Header/ns1:RequestLanguage),
            ":", fn:data($ns1:krimireq/ns1:Header/ns1:VersionNumber))}
        </ns2:correlid>
        <ns2:userid>{fn:data($ns1:krimireq/ns1:Header/ns1:UserID)}</ns2:userid>        
    </ns2:MessageContext>
};

local:func($ns1:krimireq)