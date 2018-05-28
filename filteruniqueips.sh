##########################################################################################################################################################
# Get Unique IPv4 addresses from file(s)
# Status: Active
##########################################################################################################################################################
cat $1 | tr '(' '\n' | tr ')' '\n' | tr '_' '\n' | tr '-' '\n' | tr " " "\n" | tr "\t" "\n" | grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | sort | uniq | sort -g 
