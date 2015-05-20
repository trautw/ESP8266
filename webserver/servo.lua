-- servo.lua
-- See http://www.roboremo.com/esp8266-servo.html
function servos_initialization()
servo = {}
servo.gpio = 2
servo.pin = gpioid[servo.gpio];
servo.value = 1500
servo.name = "Main Servo on GPIO"..servo.gpio

gpio.mode(servo.pin,gpio.OUTPUT)
gpio.write(servo.pin,gpio.LOW)

tmr.alarm(0,20,1,function() -- 50Hz 
    if servo.value then -- generate pulse
        gpio.write(servo.pin, gpio.HIGH)
        tmr.delay(servo.value)
        gpio.write(servo.pin, gpio.LOW)
    end
end)
end
