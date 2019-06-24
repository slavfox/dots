# Defined in - @ line 1
function cloc --description 'alias cloc cloc --exclude-list-file=$HOME/dots/.clocignore'
	command cloc --exclude-list-file=$HOME/dots/.clocignore $argv;
end
