function sudo --wraps='sudo -v; sudo' --description 'alias sudo sudo -v; sudo'
 command sudo -v; command sudo $argv;
end
