#!/usr/bin/ruby
#coding:utf-8
require 'json'
require 'mechanize'
require 'digest/md5'
def getTimestamp()
  return Time.now.to_i.to_s+'520'
end
def getmac()
  return `(ifconfig $i|grep "eth"|awk '{print$5}'|sed 's/:/-/g'|tr '[a-z]' '[A-Z]')`.strip
end
def vaildmac?(mac)
   return mac=~/^(([\d|a-fA-F]{2}-){5}[\d|a-fA-F]{2})$/ ? true : false
end
def vaildip?(ip)
  return ip =~/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/ ? true : false
end
#mac=1a-2b-3c-4d-5e-33; if echo $mac | grep -qiP "^([\dA-F]{2}-){5}[\dA-F]{2}$"; then echo $mac yes; else echo $mac no; fi
def getlocalip()
  ip=`(ifconfig $i | grep "inet " | awk -F: '{print $2}' | awk '{print $1}')`
  return ip.gsub("127.0.0.1","").strip
end
def getmd5(str)
  return  Digest::MD5.hexdigest(str+'Eshore!@#').upcase
end


def active(username,clientip,nasip,mac)
  timestamp = getTimestamp
  authenticator= getmd5(clientip+nasip+mac+timestamp)
  url="http://enet.10000.gd.cn:8001/hbservice/client/active?username=#{username}&clientip=#{clientip}&nasip=#{nasip}&mac=#{mac}&timestamp=#{timestamp}&authenticator=#{authenticator}"

  agent = Mechanize.new
  page = agent.get(url)
  puts page.body
end

def login(username,password,clientip,nasip,mac,code,iswifi)
  url = "http://enet.10000.gd.cn:10001/client/login"
  timestamp = getTimestamp
  authenticator=getmd5(clientip+nasip+mac+timestamp+code)
  postdata={}
  postdata['username']=username
  postdata['password']=password
  postdata['clientip']=clientip
  postdata['nasip']=nasip
  postdata['mac']=mac
  postdata['timestamp']=timestamp
  postdata['authenticator']=authenticator
  postdata['iswifi']=iswifi
  data=postdata.to_json

  agent = Mechanize.new
  resp = agent.post(url,data)
  status = JSON.parse(resp.body)['resinfo']
  return  "登陆信息回馈:"+status
end


def challenge(username,clientip,nasip,mac)
  url = 'http://enet.10000.gd.cn:10001/client/challenge'

  timestamp = getTimestamp
  authenticator= getmd5(clientip+nasip+mac+timestamp)
  postdata={}
  postdata['username']=username
  postdata['clientip']=clientip
  postdata['nasip']=nasip
  postdata['mac']=mac
  postdata['timestamp']=timestamp
  postdata['authenticator']=authenticator
  data=postdata.to_json
  headers = {'X-Forwarded_For' => clientip}

  agent = Mechanize.new
  resp = agent.post(url,data,headers)
  result = JSON.parse(resp.body)
  puts result
  return result['challenge']
end
