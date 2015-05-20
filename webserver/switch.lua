require("constants");

function switch_initialize(thegpio)
  gpio.mode(gpioid[thegpio],gpio.INPUT,gpio.PULLUP);
end

function switches_initialization()
  for i, switch in ipairs(switches) do
    print("Init SW "..i.." on GPIO"..switch)
    switch_initialize(switch);
  end;
end

function switch_state(thegpio)
  return gpio.read(gpioid[thegpio]);
end

function switch_to_html(i,thegpio)
  if(switch_state(thegpio) == 1)then
    s = "OFF";
  else
    s = "ON";
  end;
  return "<p>Switch "..i.." on GPIO"..thegpio..": "..s.."</p>";
end
