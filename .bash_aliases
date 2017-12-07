alias damnit='sudo "$BASH" -c "$(history -p !!)"'
alias ls='ls -G'
alias ll='ls -la'
alias la='ls -la|lolcat'

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

#send command to everyone
hive() {
	python ~/.dotfiles/send_notify.py $@
}

# notify done
nd() {
	# Trap command line
	command="$@";
	# exectute command
	$@
	# record exit status
	status=failed
    if [ $? -eq 0 ]; then
        status=completed
    fi
	( (result=$(terminal-notifier -message "$status: $command" -json -actions done -timeout 8 |python -c "import sys, json; print json.load(sys.stdin)['activationType']")
	  if [ $result == "timeout" ]; then
		  safeCommand=${command//\"/}
		  safeCommand=${safeCommand//\'/}
		  hive --message "$status - $safeCommand"
	      say "Task $status"
	  fi) &)
}


# cookiecut a quickstack container project
alias quickstack="cookiecutter https://gitlab.com/LISTERINE/quickstack.git"
