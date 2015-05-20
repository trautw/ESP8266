-- main.lua
require("constants");
require("web")
require("servo");
require("led");
require("switch");

function web_main()

wifi.setmode(wifi.STATION)

--here SSID and PassWord should be modified according your wireless router
wifi.sta.config(wlan_id,wlan_pwd) 
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
        print("IP unavaiable, Waiting...") 
    else 
        tmr.stop(1)
        print("Config done, IP is "..wifi.sta.getip())
        Webserver()
    end 
end)
end

preparations()
collectgarbage();
web_main()
