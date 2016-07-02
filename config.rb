#/usr/bin/ruby
#coding:utf-8
require 'json'
$cfg = "./config.json"
def initConfig()
  if !File.exist?($cfg)
    f = File.new($cfg,"w+")
    config='{
"nasip":"61.146.26.191",
"mac":"",
"clientip":"",
"username":"",
"password":""
}'
    f.puts config
    f.close
  end
  json = File.read($cfg)
  return JSON.parse(json)
end
def writeConfig(config)
  if !File.exist?($cfg)
    f = File.new($cfg,"w+")
    f.puts(config.to_json)
    f.close
  end
  f=File.open($cfg,"w+")
  f.puts(config.to_json)
  f.close
end
