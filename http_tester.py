import requests

headers = {'content-type': 'application/x-www-form-urlencoded'}
payload = {"username":"pburd2","password":"burdpass"}

print "About to hit server"
r = requests.post("http://localhost:9000/login", data=payload)
print "Checking response"

print r
print str(r.cookies)

cookies = r.cookies
headers = {'content-type': 'text/xml'}
xml_test = "<test>This is a test</test>"

print "posting to conversation response"
r = requests.post("http://localhost:9000/conversation/response/1", headers=headers, data=xml_test, cookies=cookies)
print "I am the response of this response"
print r
print r.ok
print r.text
print r.content
print dir(r)



