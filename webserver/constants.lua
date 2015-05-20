greeting = "CT ESP8266 Web Server"

wlan_id = "guestnet"
wlan_pwd = "next wifi"

leds = {5,4}
switches = {13,12,14,0};
servos = {2};

-- http://esp8266.co.uk/tutorials/introduction-to-the-gpio-api/
-- See https://github.com/nodemcu/nodemcu-firmware/wiki/nodemcu_api_en#new_gpio_map
gpioid = {[0]=3,[1]=10,[2]=4,[3]=9,[4]=1,[5]=2,[10]=12,[12]=6,[13]=7,[14]=5,[15]=8,[16]=0}
