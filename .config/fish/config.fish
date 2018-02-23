setenv EDITOR nvim
setenv VISUAL nvim
set -gx PATH "$HOME/.gem/ruby/2.4.0/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/dotfiles/bin" $PATH
set -gx PATH "$HOME/go/bin" $PATH
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx SXHKD_SHELL /usr/bin/bash
set -gx GTK_THEME "Arc Darker:dark"
set -gx TERMINAL /usr/bin/urxvt
wal -r &

if [ -z "$DISPLAY" ]; and [ -n "$XDG_VTNR" ]; and [ "$XDG_VTNR" -eq 1 ]
  exec startx
end

setenv SSH_ENV $HOME/.ssh/environment

function start_agent                                                                                                                                                                    
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV 
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities                                                                                                                                                                
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ] 
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end  
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end  
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else 
        start_agent
    end  
end
