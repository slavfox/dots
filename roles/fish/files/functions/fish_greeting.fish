
function fish_greeting -d "Greeting message on shell session start up"

    set_color red
    echo -en "Space freighter "
    set_color cyan
    echo -en (hostname) 
    set_color  red
    echo -en " reporting in!\n"
    set_color green
    echo -en "  All systems online.\n"
    echo -en "                 "
    set_color normal
    echo ""
    echo -en "                  "
    echo -en (welcome_message) "\n"
    echo -en "                  "
    set_color cyan
    echo -en "  We are currently docked at:\n"
    echo -en "                   " (show_net_info)
    echo ""
    set_color red
    echo -en "        |        \n"
    echo -en "       / \          "
    set_color normal
    echo -en (show_date_info) "\n"
    set_color red
    echo -en "      / _ \         " 
    set_color normal
    echo -en (show_uptime_info) "\n"
    echo -en "     |.o '.|      \n"
    echo -en "     |'._.'|      Onboard computer:\n"
    echo -en "     |     |       " (show_os_info) "\n"
    set_color red
    echo -en "   ,'"
    set_color normal
    echo -en "|  "
    set_color red
    echo -en "|  "
    set_color normal
    echo -en "|"
    set_color red
    echo -en "`.      "
    set_color normal
    echo -en (show_cpu_info) "\n"
    set_color red
    echo -en "  /  "
    set_color normal
    echo -en "|  "
    set_color red
    echo -en "|  "
    set_color normal
    echo -en "|"
    set_color red
    echo -en "  \     "
    set_color normal 
    echo -en (show_mem_info) "\n"
    set_color red
    echo -en "  |,-"
    set_color normal
    echo -en "'--"
    set_color red
    echo -en "|"
    set_color normal
    echo -en "--'"
    set_color red
    echo -en "-.|     "
    set_color normal
    echo ""
    fortune -asen256
    echo ""
    set_color green
    echo "Have a good flight, captain!"
    set_color normal
end

function welcome_message -d "Say welcome to user"

    echo -en "Welcome aboard, captain "
    set_color -o brwhite
    echo -en (whoami)"!"
    set_color normal
end

function show_date_info -d "Prints information about date"
    echo -en "Today is "
    set_color cyan
    echo -en (date +%d.%m.%Y)
    set_color normal
    echo -en "."
end

function show_uptime_info -d "Prints uptime info"
    set --local up_time (uptime |sed 's/^ *//g' |cut -d " " -f4,5 |tr -d ",")
    echo -en "We are up and running for "
    set_color cyan
    echo -en (uptime -p | cut -d " " -f2-) 
    set_color normal
    echo -en "!"
end

function show_os_info -d "Prints operating system info"

    set_color yellow
    echo -en "Kernel: "
    set_color brgreen  # green
    uname -orm
    set_color normal
end


function show_cpu_info -d "Prints information about cpu"

    set --local cpu_usage (mpstat | grep -A 5 "%idle" | tail -n 1 | awk -F " " '{print 100 -  $ 12}'a)
    set cpu_info (nproc --all) "cores, $cpu_usage% in use."

    set_color yellow
    echo -en "CPU: "
    set_color brgreen  # green
    echo -en $cpu_info
    set_color normal
end


function show_mem_info -d "Prints memory information"

    set --local os_type (uname -s)
    set --local total_memory ""

    set total_memory (free -h | awk '{if(NR==2){print $3 "/" $2 " in use"}}')

    set_color yellow
    echo -en "Memory: "
    set_color brgreen  # green
    echo -en $total_memory
    set_color normal
end

function show_net_info -d "Prints information about network"

    set --local os_type (uname -s)
    set --local ip ""
    set --local gw ""

    set ip (ip addr show | grep -v "127.0.0.1" | grep "inet "| sed 's/^ *//g' | cut -d " " -f2)
    set gw (ip route show | cut -d " " -f3 | head -n1)

    set_color yellow
    echo -en "$ip, default gateway $gw"
    set_color normal
end

