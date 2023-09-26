#imports
import sys
import fnmatch
import os
import xml.etree.ElementTree as ET
from datetime import date

#functions
def main_function(xacml_export):
  fileName=xacml_export
  out = open(xacml_export + ".out", "w")
  tree = ET.parse(fileName)
  root = tree.getroot()
  users_dict={}
  services_dict={}
  for child in root:
    try:
      if(child.tag=="{urn:oasis:names:tc:xacml:2.0:policy:schema:os}Policy" and child.get("PolicyId").find("alsb-proxy-service")!=-1):
        #print(child.tag)
        #print(child.attrib)
        #print(child.text)
        users = child.find("{urn:oasis:names:tc:xacml:2.0:policy:schema:os}Description").text.split("|")
        if("Usr(_soapui_osb_ws)" in users):
          users.remove("Usr(_soapui_osb_ws)")
        if("Usr(_OSB_osb_ws)" in users):
          users.remove("Usr(_OSB_osb_ws)")
        uri = child.find("{urn:oasis:names:tc:xacml:2.0:policy:schema:os}Target"). \
          find("{urn:oasis:names:tc:xacml:2.0:policy:schema:os}Resources"). \
          find("{urn:oasis:names:tc:xacml:2.0:policy:schema:os}Resource"). \
          find("{urn:oasis:names:tc:xacml:2.0:policy:schema:os}ResourceMatch"). \
          find("{urn:oasis:names:tc:xacml:2.0:policy:schema:os}AttributeValue").text
        #print(uri)
        path=uri.split(",")[1]
        proxy=uri.split(",")[2]
        service=path[6:] + "/" + proxy[7:]
        #print(service)
        #print(usrs)

        services_dict[service]=users
        

        for user in users:
          #print(users_dict[user])
          if(user not in users_dict):
            users_dict[user] = service
          
          else: 
            existing_service = users_dict[user] 
            users_dict[user] = existing_service + "|" + service
        
    except:
      pass
  #print(users_dict)
  #for users in sorted(users_dict.keys()):
  #  print(users, users_dict[users].split("|"))
  
  
  for services in sorted(services_dict.keys()):
    for actualUser in sorted(set(services_dict[services])):
      out.write(services + ": " + str(actualUser) + "\n")
    #print(services, sorted(services_dict[services]))
   
  out.close()
#end


#if called as the main program
if __name__ == "__main__":
    print("Usage: python getXacmlAuthorization.py <xacml_export>")
    print("xacml_export: " + sys.argv[1])
    main_function(sys.argv[1])
    print("xacml_export.out: " + sys.argv[1]+".out")
    print("Done")
    


