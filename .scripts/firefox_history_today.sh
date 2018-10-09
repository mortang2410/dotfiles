db=$(find "${HOME}/.mozilla/firefox/" -name "places.sqlite")
query="select p.url,p.title from moz_historyvisits as h, moz_places as p where substr(h.visit_date, 0, 11) >= strftime('%s', date('now')) and p.id == h.place_id order by h.visit_date;"
todays_urls=$(sqlite3 "${db}" "${query}")
echo "${todays_urls}" 
