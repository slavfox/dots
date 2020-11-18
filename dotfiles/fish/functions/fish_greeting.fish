function fish_greeting
if type -q pfetch
    pfetch
else
    sensors
    uptime
end
end
