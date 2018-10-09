#!/bin/zsh
array_of_lines=("${(f)$(find "${HOME}/.mozilla/firefox/" -name "places.sqlite")}")
db=$array_of_lines[1]
query="select p.url,p.title from moz_historyvisits as h, moz_places as p where date(substr(h.visit_date,0,11),'unixepoch') >= date('now','-1 day') and p.id == h.place_id order by h.visit_date;"
the_urls=$( sqlite3 "${db}" "${query}" )
echo "${the_urls}" 
