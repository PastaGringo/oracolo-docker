#!/bin/sh
echo
echo "Starting oracolo..."
echo
echo "Oracolo dtonon's repo: https://github.com/dtonon/oracolo"
src_index_html="/app/index.html"
echo
echo "╭────────────────────────────╮"
echo "│ Docker Compose Env Vars ⤵️  │"
echo "╰────────────────────────────╯"
echo
printf "%-15s : %s\n" "NPUB" "$NPUB"
printf "%-15s : %s\n" "RELAYS" "$RELAYS"
printf "%-15s : %s\n" "TOP_NOTES_NB" "$TOP_NOTES_NB"
echo
echo "╭───────────────────────────╮"
echo "│ Configuring Oracolo... ⤵️  │"
echo "╰───────────────────────────╯"
echo
echo -n "> Updating npub key with $NPUB... "
sed -i "s/replace_with_your_npub/$NPUB/" $src_index_html
echo "✅"
echo -n "> Updating nostr relays with $RELAYS... "
old_relays="wss://nos.lol, wss://relay.damus.io, wss://nostr.wine"
RELAYS=$(echo $RELAYS | sed 's/^"//' | sed 's/"$//')
sed -i "s|$old_relays|$RELAYS|g" $src_index_html
echo "✅"
echo -n "> Updating TOP_NOTE with value $TOP_NOTES_NB... "
old_TOP_NOTES='name="top-notes" value="0"'
TOP_NOTES="name=\"top-notes\" value=\"$TOP_NOTES_NB\""
sed -i "s|$old_TOP_NOTES|$TOP_NOTES|g" $src_index_html
echo "✅"
echo
echo "╭───────────────────────╮"
echo "│ Installing Oracolo ⤵️  │"
echo "╰───────────────────────╯"
npm install
echo
echo ">>> done ✅"
echo
echo "╭─────────────────────╮"
echo "│ Building Oracolo ⤵️  │"
echo "╰─────────────────────╯"
npm run build
echo
echo ">>> done ✅"
echo
echo -n "> Copying Oracolo built index.html to nginx usr/share/nginx/html... "
mkdir /usr/share/nginx/html
cp /app/dist/index.html /usr/share/nginx/html
echo "✅"
echo
echo "╭────────────────────────╮"
echo "│ Configuring Nginx... ⤵️ │"
echo "╰────────────────────────╯"
echo
echo -n "> Copying default nginx.conf file... "
cp /app/nginx.conf /etc/nginx/http.d/oracolo.conf
echo "✅"
echo
echo "╭──────────────────────╮"
echo "│ Starting Nginx... 🚀 │"
echo "╰──────────────────────╯"
echo
exec "$@"
