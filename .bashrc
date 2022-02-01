PROMPT_COMMAND='PS1="$(add_venv_info)${debian_chroot:+($debian_chroot)}\[\033[01;34m\]$(_love_pwd)\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "'
tmux source-file ~/.tmux.conf

setaws () {
	if [ -z "$AWS_PROFILE" ]; then
		# Use home2 for aws credentials and analyst role by default
		export AWS_SHARED_CREDENTIALS_FILE='/srv/durable/akravetz/.aws/credentials'
		export AWS_CONFIG_FILE='/srv/durable/akravetz/.aws/config'
		export AWS_PROFILE='analyst@prod'
		echo "aws variables set"
	else
		unset AWS_SHARED_CREDENTIALS_FILE AWS_CONFIG_FILE AWS_PROFILE
		echo "aws variables unset"
	fi
}

export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

alias gcm='git checkout master'
alias gp='git pull'
alias gcb='git checkout -b'
alias j='jobs'
eval "$(direnv hook bash)"
