function readjson --description 'alias readjson python -m json.tool | highlight -Oansi --syntax json'
	python -m json.tool | highlight -Oansi --syntax json $argv;
end
