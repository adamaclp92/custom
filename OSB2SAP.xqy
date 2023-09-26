declare namespace functx = "http://www.functx.com";
declare namespace soap = "http://www.w3.org/2003/05/soap-envelope";

declare variable $nodes as node() external;
declare variable $newns as xs:string external;
declare variable $prefix as xs:string external;
 
declare function functx:change-element-ns
  ( $elements as element()* ,
    $newns as xs:string ,
    $prefix as xs:string )  as element()? {

   for $element in $elements
   return
   element {QName ($newns,
                      concat($prefix,
                                if ($prefix = '')
                                then ''
                                else ':',
                                local-name($element)))}
           {$element/@*, $element/node()}
 } ; 

declare function functx:change-element-ns-deep( 
  $nodes as node()* ,
  $newns as xs:string ,
  $prefix as xs:string )  as node()* {

  for $node in $nodes
  return 
    if ($node instance of element()) then
    (
        element
          {QName ($newns,
            concat($prefix,
              if ($prefix = '') then 
                ''
              else 
                ':',
              if(contains(local-name($node), "-")) then
                replace(local-name($node), "-", "_")
              else
                local-name($node)))}
          {$node/@*, 
            functx:change-element-ns-deep($node/node(), $newns, $prefix)}
          )  
      else if ($node instance of document-node()) then 
        functx:change-element-ns-deep($node/node(), $newns, $prefix)
      else
        $node
};

declare function functx:change-element-ns-deep-x( 
  $nodes as node()* ,
  $newns as xs:string ,
  $prefix as xs:string )  as node()* {
 
  let $stripped as node()* := functx:change-element-ns-deep($nodes, "", "")
  let $stripped_with_first as node()* := functx:change-element-ns($stripped, $newns, $prefix)  

  return $stripped_with_first

};

functx:change-element-ns-deep-x($nodes, $newns, $prefix)