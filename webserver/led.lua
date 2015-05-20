-- See http://lua-users.org/wiki/ObjectOrientationTutorial
require("constants");

function led_description(dev_id,mygpio)
  return "Led "..dev_id.." on GPIO"..mygpio;
end

function led_to_html(dev_id,mygpio)
  return "<p>"..led_description(dev_id,mygpio).."<a href=\"?dev=led"..dev_id.."&cmd=ON\"><button>ON</button></a>&nbsp;<a href=\"?dev=led"..dev_id.."&cmd=OFF\"><button>OFF</button></a></p>";
end

function led_cmd(mygpio,cmd)
  print("Led "..mygpio.." CMD "..cmd)
  if(cmd == "ON")then
    gpio.write(gpioid[mygpio], gpio.LOW);
  end;
  if(cmd == "OFF")then
    gpio.write(gpioid[mygpio], gpio.HIGH);
  end;
end

function leds_initialization()
  for i, led in ipairs(leds) do
    print("Init LED "..i.." on GPIO"..led)
    gpio.mode(gpioid[led],gpio.OUTPUT);
  end;
end
