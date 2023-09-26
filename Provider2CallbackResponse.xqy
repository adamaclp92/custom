
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://erste.hu/common_v1";
(:: import schema at "../../../Infrastructure/CDM/WSDLs/MessageContext_V1.xsd" ::)
declare namespace ser1="http://v1.service.szk.dslloan.erste.hu/SearchAggregatedTransactionHistoryV1";
(:: import schema at "../../SearchAggregatedTransactionHistoryRequest/WSDLs/SearchAggregatedTransactionHistoryV1.xsd" ::)
declare namespace ns3="http://s-itsolutions.at/KrimiAPSClientInterface/ReplyHeader";
(:: import schema at "../../_common/WSDLs/KrimiClientInterfaceReplyHeader.xsd" ::)
declare namespace soapenv="http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns4="http://s-itsolutions.at/KrimiAPSClientInterface/ClientDetailReply";
(:: import schema at "../../_common/WSDLs/ClientDetailReply.xsd" ::)
declare namespace ns5="http://s-itsolutions.at/KrimiAPS/KRIMIAPSStructureTypeDefinitions";
(:: import schema at "../../_common/WSDLs/KRIMIAPSStructureTypeDefinitions.xsd" ::)
declare namespace functx = "http://www.functx.com";

declare variable $ns1:msgctx as element() (:: schema-element(ns1:MessageContext) ::) external;
declare variable $ser1:resp as element() (:: schema-element(ser1:searchAggregatedTransactionHistoryV1Response) ::) external;

declare variable $correlVars := fn:tokenize(fn:data($ns1:msgctx/ns1:correlid),":");

declare function functx:has-empty-content
  ( $element as element() )  as xs:boolean {
   not($element/node())
 } ;
 
declare function functx:format-boolean
  ( $element as xs:string )  as xs:boolean {
   if(fn:compare(fn:upper-case($element), "Y") = 0) then fn:true()
   else if(fn:compare(fn:upper-case($element), "N") = 0) then fn:false()
   else (fn:false())
 } ;
 
declare function functx:date-from-dateTime ( $dt as element() )  as xs:date{
  if(fn:contains((xs:string($dt)), "T")) then
    xs:date(fn:substring-before(xs:string($dt), "T"))
  else()
} ; 

declare function local:func($ns1:msgctx as element() (:: schema-element(ns1:MessageContext) ::),
                           $ser1:resp as element() (:: schema-element(ser1:searchAggregatedTransactionHistoryV1Response) ::))
                            as element() (:: schema-element(ns3:KrimiAPSClientReply) ::) {        
    <ns3:KrimiAPSClientReply>
      <ns3:Header>        
        <ns3:RequestType>{fn:data($ns1:msgctx/ns1:src-module)}</ns3:RequestType>
        <ns3:RequestReplyID>{fn:data($ns1:msgctx/ns1:rrid)}</ns3:RequestReplyID>
        <ns3:UserID>{fn:data($ns1:msgctx/ns1:userid)}</ns3:UserID>
        <ns3:MandantNumber>{$correlVars[2]}</ns3:MandantNumber>
        <ns3:CallingSystemName>{fn:data($ns1:msgctx/ns1:source)}</ns3:CallingSystemName>
        <ns3:VersionNumber>{$correlVars[4]}</ns3:VersionNumber>
        <ns3:DateTimeRequest>{fn:current-dateTime()}</ns3:DateTimeRequest>
        <ns3:DateTimeReceived>{fn:current-dateTime()}</ns3:DateTimeReceived>
        <ns3:DateTimeReply>{fn:current-dateTime()}</ns3:DateTimeReply>
        <ns3:RequestLanguage>{$correlVars[3]}</ns3:RequestLanguage> 
      </ns3:Header>
      <ns3:OverallExecutionStatus>Ok</ns3:OverallExecutionStatus>       
      <ns3:ServiceReply>
        <ns4:ReplyData>
          <ns4:Clients>
            <ns4:ClientData>          
            <ns5:BaseData>
             <ns5:ClientIdentifier IdBase="extClientLegacy">{$correlVars[1]}</ns5:ClientIdentifier>
              <ns5:XFields>
                    {if ($ser1:resp/ser1:data/ser1:ebhTurnovers) then
                 (
               <ns5:EbhTurnovers>
               {
              for $turnOvers in $ser1:resp/ser1:data/ser1:ebhTurnovers
              return                
               (<ns5:EbhTurnover>
                  <ns5:datToEbhTurnoverFrom>{fn:data($turnOvers/ser1:ebhTurnoverFrom)}</ns5:datToEbhTurnoverFrom>
                  <ns5:datToEbhTurnoverTo>{fn:data($turnOvers/ser1:ebhTurnoverTo)}</ns5:datToEbhTurnoverTo>
                  <ns5:amtToEbhTurnoverAmount>{fn:data($turnOvers/ser1:ebhTurnoverAmount)}</ns5:amtToEbhTurnoverAmount>
               </ns5:EbhTurnover>)
               }
              </ns5:EbhTurnovers>
               )
                 else (<ns5:EbhTurnovers/>) } 
              </ns5:XFields>
            </ns5:BaseData>
            </ns4:ClientData>
          </ns4:Clients>
        </ns4:ReplyData>
      </ns3:ServiceReply>              
    </ns3:KrimiAPSClientReply>
};

local:func($ns1:msgctx, $ser1:resp)