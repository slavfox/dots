function fish_greeting
if type -q pfetch
    pfetch
else
    if type -q sensors
        sensors
    end
    uptime
end
end
