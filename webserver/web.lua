function preparations()
  switches_initialization()
  leds_initialization()
  servos_initialization()

  buf = "";
  buf = buf.."<h1>"..greeting.."</h1>";
  for i, led in ipairs(leds) do
     buf = buf..led_to_html(i,led)
  end
  print("in web.lua 5 "..node.heap())

  buf = buf.."<p>"..servo.name.."<a href=\"?dev=servo&cmd=500\"><button>500</button></a>&nbsp;<a href=\"?dev=servo&cmd=1800\"><button>1800</button></a></p>";
  buf = buf.."<p>Node <a href=\"?cmd=REBOOT\"><button>Reboot</button></a>";
  buf = buf.."<p>Web server<a href=\"?cmd=CLOSE\"><button>Close</button></a>";
end

function Webserver()
  print("in web.lua "..node.heap())
  -- See http://randomnerdtutorials.com/esp8266-web-server/
  
  print("Vor createServer "..node.heap())
  srv=net.createServer(net.TCP)
  srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end

        print("in web.lua 6 "..node.heap())
        
        -- find device
        for i, led in ipairs(leds) do
          if ("led"..i == _GET.dev) then
            led_cmd(led,_GET.cmd)
          end
        end

        if(_GET.dev == "servo")then
          print("Servo to ".._GET.cmd);
              servo.value = tonumber(_GET.cmd);
        end

        if(_GET.cmd == "REBOOT")then
              node.restart();
        end
        
        if(_GET.cmd == "CLOSE")then
              srv:close();
              wifi.sta.disconnect();
        end
        client:send(buf);
        print("in web.lua 8 "..node.heap())
        
        -- read sensors
        for i, switch in ipairs(switches) do
          client:send(switch_to_html(i,switch));
        end;
        client:send("<p>ADC: "..adc.read(0).."</p>");
        client:close();
        collectgarbage();
        print("in web.lua 10 "..node.heap())
    end)
  end)
end
