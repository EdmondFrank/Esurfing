#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'shoes'
require './post'
require './config'

iswifi = '1050'
#host = 'enet.10000.gd.cn'
nasip = ''
mac = ''
clientip= ''
username = ''
password = ''

Shoes.app :title => "Esurfing for Linux-by Edmond",
:height => 400,:width =>360,:resizable => false do
  stack do
    config = initConfig
    flow :margin => 40 do
        flow { caption "帐号:",:width => 80
        @user = edit_line
        @user.text = config['username']}

        flow {caption "密码:",:width => 80
        @pass = edit_line
        @pass.text = config['password']}
        @pass.secret = true

        flow { caption "MAC:",:width => 80
        @mac = edit_line
        @mac.text = config['mac']}

        flow {caption "动态IP:",:width => 80
        @clientip = edit_line
        @clientip.text = config['clientip']}

      flow {@isRouter = check; para "路由器登陆"}
        @isRouter.checked = true
        @isRouter.click do
          if @isRouter.checked?
            @mac.hidden = false
            @clientip.hidden = false
            else
            @mac.hidden = true
            @clientip.hidden = true
          end
        end
      flow {@isSave = check; para "记住密码"}
      @isSave.checked = true
      
      flow {@btn = button "登录",:left => 120,:width => 80}
    end
    @btn.click do
      username = @user.text
      password = @pass.text
      if @isRouter.checked?
        mac = @mac.text
        clientip = @clientip.text
      else
        mac = getmac
        clientip = getlocalip
      end
      
      if @isSave.checked?
        config['username'] = username
        config['password'] = password
        config['mac'] = mac
        config['clientip'] = clientip
        writeConfig(config)
      end

      if mac != ""||clientip !=""
        if vaildmac?(mac)
          if vaildip?(clientip)
            #puts getTimestamp
            #puts getmd5(getTimestamp)
            active(username,clientip,nasip,mac)
            rescode = challenge(username,clientip,nasip,mac)
            if rescode != nil
            alert login(username,password,clientip,nasip,mac,rescode,iswifi)
            end
            alert "active 失败! "
            else
            alert "动态IP地址格式错误,请重新输入!"
            end
          else
           alert "MAC地址格式错误,请重新输入!"
         end
        else
        alert "MAC地址或动态IP不能为空,请重新输入!"
      end
    end
    end
end
