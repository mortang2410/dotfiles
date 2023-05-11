function mant --wraps man --description 'alias mant=man -t then opens in skim'
    man -t $argv | open -fa Skim
end