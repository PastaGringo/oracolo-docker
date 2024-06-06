#!/bin/sh
echo
echo "  ___   ____    ____    __   ___   _       ___  ";
echo " /   \ |    \  /    |  /  ] /   \ | |     /   \ ";
echo "|     ||  D  )|  o  | /  / |     || |    |     |";
echo "|  O  ||    / |     |/  /  |  O  || |___ |  O  |";
echo "|     ||    \ |  _  /   \_ |     ||     ||     |";
echo "|     ||  .  \|  |  \     ||     ||     ||     |";
echo " \___/ |__|\_||__|__|\____| \___/ |_____| \___/ ";
echo "                                                ";
echo "Oracolo dtonon's repo: https://github.com/dtonon/oracolo"
echo "Docker image repo: https://github.com/PastaGringo/oracolo-docker"
echo
echo "╭───────────────────────╮"
echo "│ Docker Env Vars... ⤵️  │"
echo "╰───────────────────────╯"
echo
echo "> NPUB                : $NPUB"
echo "> RELAYS              : $RELAYS"
echo "> TOP_NOTES           : $TOP_NOTES_NB"
echo "> SHORT_CHARS         : $SHORT_CHARS_NB"
echo "> TOPICS              : $TOPICS"
echo "> COMMENTS_ENABLED    : $COMMENTS_ENABLED"
echo
echo "╭───────────────────────────╮"
echo "│ Configuring Oracolo... ⏳ │"
echo "╰───────────────────────────╯"
src_index_html="/usr/share/nginx/html/index.html"
echo
echo -n "> Updating author npub key...  "
sed -i "s/replace_with_your_npub/$NPUB/" $src_index_html
echo "✅"
echo -n "> Updating nostr relays...     "
old_relays="wss://nos.lol, wss://relay.damus.io, wss://nostr.wine"
RELAYS=$(echo $RELAYS | sed 's/^"//' | sed 's/"$//')
sed -i "s|$old_relays|$RELAYS|g" $src_index_html
echo "✅"
echo -n "> Updating top-notes...        "
old_TOP_NOTES='name="top-notes" value="0"'
TOP_NOTES="name=\"top-notes\" value=\"$TOP_NOTES_NB\""
sed -i "s|$old_TOP_NOTES|$TOP_NOTES|g" $src_index_html
echo "✅"
echo -n "> Updating short-chars...      "
old_SHORT_CHARS='name="short-chars" value="0"'
SHORT_CHARS="name=\"short-chars\" value=\"$SHORT_CHARS_NB\""
sed -i "s|$old_SHORT_CHARS|$SHORT_CHARS|g" $src_index_html
echo "✅"
echo -n "> Updating topics...           "
old_TOPICS='name="topics" value=""'
TOPICS="name=\"topics\" value=\"$TOPICS\""
sed -i "s|$old_TOPICS|$TOPICS|g" $src_index_html
echo "✅"
echo -n "> Updating comments...         "
old_COMMENTS='name="comments" value="yes"'
COMMENTS_ENABLED="name=\"comments\" value=\"$COMMENTS_ENABLED\""
sed -i "s|$old_COMMENTS|$COMMENTS_ENABLED|g" $src_index_html
echo "✅"
echo
echo "╭──────────────────────╮"
echo "│ Starting Nginx... 🚀 │"
echo "╰──────────────────────╯"
echo
exec "$@"