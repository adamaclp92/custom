import userextractnagyada
import servicextractnagyada
import sys
from atlassian.confluence import Confluence
import userservicenagyada
import userextractnagyada
from datetime import date
import sys
import xml.etree.ElementTree as ET
from datetime import date
from atlassian import Confluence

def ServiceUserMatrixToConfluence(userextract,servicextract,user, password):
   confluence = Confluence(url='https://atlassian.ebh.erste.hu/Confl',username=user,password=password,verify_ssl=False)
   a=""
   for (key,value) in servicextract.res.items():
      if key in userextract.res.keys():
         a+=('<tr><td>'+ key+'</td>') 
         ertek=""
         for v in value:
            if str(v) not in ertek:
               ertek+=str(v)+"; " 
         a+=('<td>')
         a+=ertek
         a+=('</td>')  
         rme=""
         prid=""
         user=""
         for k in userextract.res[key]:
            for t,s in k.items():
               if t == "RME":
                  rme+='<tr><td>'+str(s)+'</td></tr>'         
            for t,s in k.items():
               if t == "PR-ID":
                  prid+='<tr><td>'+str(s)+'</td></tr>'        
            for t,s in k.items():
               if t == "USER":
                  user+='<tr><td>'+str(s)+'</td></tr>'
         a+='<td><table>'+rme+'</table></td><td><table>'+prid+'</table></td><td><table>'+user+'</table></td>'
         a+=('</tr>')
         print(key + str(value))
   confluence.update_page('93847680','OSB-Service-User-Matrix','<table style="width:100%"><tr><th>SERVICE</th><th>Bekötés_RME</th><th>Jogosztás_RME</th><th>PR-Id</th><th>User</th></tr>'+a+'</table>')
   print("Service User Matrix Update")
   #print(a)

def UserToConfluence(userextract,user, password):
    confluence = Confluence(url='https://atlassian.ebh.erste.hu/Confl',username=user,password=password,verify_ssl=False)
    a=""
    for item in userextract.w_list:
         #print (item[0])
         #a +=('<tr><td>'+ (str)(key)+'</td><td>' + values[0].values() + '</td><td>' + values[1].values()+ '</td><td>' + values[2].values() + '</td></tr>')
         a +=('<tr><td>'+ (str)(item[0])+'</td><td>' + (str)(item[1]) + '</td><td>' + (str)(item[2]) + '</td><td>' + (str)(item[3]) + '</td></tr>')
               
    confluence.update_page('91526432','OSB-USER-RME','<table style="width:100%"><tr><th>RME</th><th>SAMU PR-ID</th><th>SERVICE</th><th>User</th></tr>'+a+'</table>')
    print("User Update")

def ServiceToConfluence(servicextract,user, password):
    confluence = Confluence(url='https://atlassian.ebh.erste.hu/Confl',username=user,password=password,verify_ssl=False)
    a=""
    for key,values in servicextract.res.items():
        #print(item)
        a +=('<tr><td>'+ (str)(values)+'</td><td>' + (str)(key)+ '</td></tr>')
    confluence.update_page('91525960','OSB-RME-Services','<table style="width:100%"><tr><th>RME</th><th>SERVICE</th></tr>'+a+'</table>')
    print("Service Update")

    

if __name__ == "__main__":
   
   #Jogosztó csv-be
   userextract = userextractnagyada.UserExtract()
   outPolicy = open("getUserService_" + date.today().strftime("%Y%m%d") + ".csv", "w")
   outPolicy.write('RME' + ';' + 'SAMU PR-ID' + ';' + 'SERVICE' + ';' + 'User')
   outPolicy.write('\n')
   for item in userextract.w_list:
      outPolicy.write(str([item[0] + ';' +  item[1] + ';' + item[2] + ';' + item[3]]))
      outPolicy.write('\n')
   outPolicy.close()
   
   #Service RME csv-be
   servicextract = servicextractnagyada.ServiceExtract()
   outRmeServices = open("getRmeService_" + date.today().strftime("%Y%m%d") + ".csv", "w")
   outRmeServices.write('SERVICE' + ';' + 'RME')
   outRmeServices.write('\n')
   for item in servicextract.res:
      #print('Service: ' + str(item) + ' Rme: ' + str(servicextract.res[item]))
      outRmeServices.write(str(item) + ';' + str(servicextract.res[item]))
      outRmeServices.write('\n')
   outRmeServices.close()
   
   
   #ServiceUserMatrixToConfluence(userextract,servicextract,sys.argv[1],sys.argv[2])
   #UserToConfluence(userextract,sys.argv[1],sys.argv[2])
   #ServiceToConfluence(servicextract,sys.argv[1],sys.argv[2])

   
   print("Done")