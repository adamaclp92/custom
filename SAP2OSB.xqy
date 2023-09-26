declare namespace functx = "http://www.functx.com";
declare namespace soap = "http://www.w3.org/2003/05/soap-envelope";

declare variable $nodes as node() external;
declare variable $newns as xs:string external;
declare variable $prefix as xs:string external;

declare function functx:is-ancestor ( 
  $node1 as node() ,
  $node2 as node() )  as xs:boolean {
  exists($node1 intersect $node2/ancestor::node())
} ;

declare function functx:is-descendant( 
  $node1 as node() ,
  $node2 as node() )  as xs:boolean {
  boolean($node2 intersect $node1/ancestor::node())
 } ;
 
 declare function functx:first-node
  ( $nodes as node()* )  as node()? {
   ($nodes/.)[1]
 } ;

declare function functx:change-element-ns-deep( 
  $nodes as node()* ,
  $newns as xs:string ,
  $prefix as xs:string )  as node()* {

  for $node in $nodes
  return if ($node instance of element())
         then (element
               {QName ($newns,
                          concat($prefix,
                                    if ($prefix = '')
                                    then ''
                                    else ':',
                                    local-name($node)))}
               {$node/@*,
                functx:change-element-ns-deep($node/node(),
                                           $newns, $prefix)})
         else if ($node instance of document-node())
         then functx:change-element-ns-deep($node/node(),
                                           $newns, $prefix)
         else $node
};

functx:change-element-ns-deep($nodes, $newns, $prefix)