#imports
import sys
import fnmatch
import os
import xml.etree.ElementTree as ET
import requests
import json
from datetime import date
from atlassian import Confluence
#functions
def main_function(dir,a):
	url_d6="https://osbprod.erste.hu/"
	out = open("getProxyEndpoints_" + date.today().strftime("%Y%m%d") + ".csv", "w")
	out.write('PROVIDER;SERVICE;URL;BINDING')
	out.write('\n')
	#dir='c:/WORK/OSB/osbprojects'
	excludes = [".archive", "DM", "DMAN", "HF_BB", "ESL_REST", "Infrastructure", "ORACLE_SR", "PlayGround"]
	for dirRoot, dirs, files in os.walk(dir):
		dirs[:] = [d for d in dirs if d not in excludes]
		for file in files:
			
			if fnmatch.fnmatch(file, '*.ProxyService') and '.archive' not in dirRoot:
				print("s")
				fileName = dirRoot + "\\" + file
				tree = ET.parse(fileName)
				root = tree.getroot()
				try:
					"""
					serviceName = root. \
						find("{http://www.bea.com/wli/sb/services}coreEntry"). \
						find("{http://www.bea.com/wli/sb/services}binding"). \
						find("{http://www.bea.com/wli/sb/services/bindings/config}binding"). \
						find("{http://www.bea.com/wli/sb/services/bindings/config}name").text
					"""
					serviceUri = root. \
						find("{http://www.bea.com/wli/sb/services}endpointConfig"). \
						find("{http://www.bea.com/wli/sb/transports}URI"). \
						find("{http://www.bea.com/wli/config/env}value").text
					
					binding = root. \
						find("{http://www.bea.com/wli/sb/services}coreEntry"). \
						find("{http://www.bea.com/wli/sb/services}binding").get('type')
					provider=dirRoot[len(dir)-1:]
					url=url_d6 + serviceUri
					print(provider, url, binding)
					out.write(dirRoot[dirRoot.find('\\'):].split('\\')[0] + ";" + file[0:file.find('.')] + ";" + url + ";" + binding)
					a +=('<tr><td>'+dirRoot[dirRoot.find('\\'):].split('\\')[0] + "</td><td>" + file[0:file.find('.')] + "</td><td>" + url + "</td><td>" + binding+'</td></tr>')
					out.write("\n")
				except(AttributeError):
					pass
	out.close()
	#confluence.append_page('82151689','OSB-D6-Services','<table style="width:100%"><tr><th>PROVIDER</th><th>SERVICE</th><th>URL</th><th>BINDING</th></tr>'+a+'</table>')

#if called as the main program
if __name__ == "__main__":
	#confluence = Confluence(url='http://confluence.erste.hu:8090/',username=sys.argv[2],password=sys.argv[3])
	print("Usage: python getProxyEndpoints.py <osbprojects_folder>")
	tablazat=''
	print("osbprojects: " + sys.argv[1])
	main_function(sys.argv[1],tablazat)
	print("Done")
	


