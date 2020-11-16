function fish_greeting
if type -q pfetch
    pfetch
else
    uptime
end
end
