
files=(".bashrc.devoted" ".bash_profile")
for f in ${files[@]}; do
	if [ -f "${HOME}/$f" ]; then
		source "${HOME}/$f"
	fi
done

# below mostly cribbed from other folks, with minor changes

# Auto-complete for love, allows e.g. "love backend/claims"
if alias love >& /dev/null; then
	unalias love
fi
function _love_comp() {
  local j k
  for j in $( compgen -d -- "$CORE/$2" ); do
    COMPREPLY[k++]=${j#"$CORE/"}
  done
  return 0
}
function love() {
  cd "$CORE/$1"
}

complete -o filenames -o nospace -o bashdefault -F _love_comp love
function _o_comp() {
	local targets
	targets=`perl -lne 'print $1 if /^([\w\d]+):/' $CORE/Makefile.new`
	COMPREPLY=($(compgen -W "$targets" "${COMP_WORDS[${COMP_CWORD}]}"))
}
complete -F _o_comp o

# Relace $CORE directory with Unicode heart character in path
function _love_pwd() {
  if [[ ${PWD:0:${#CORE}} == $CORE ]]; then
    echo -e "\\\$CORE${PWD:${#CORE}}"
  else
    echo $PWD
  fi
}

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

# Alias for logging into redshift as dbadmin
alias md='make -C $CORE/analytics deps'
alias mt='make -C $CORE/analytics test'
alias ml='make -C $CORE/analytics lint'
alias mpy='make -C $CORE/analytics pydvtd'
alias wrp='with-role analyst@prod --'
alias wrr='with-role analyst@redshift --'
alias ma='make -C $CORE/analytics'
alias gcm='git checkout master'
alias gp='git pull'
alias gcb='git checkout -b'
alias j='jobs'
alias stagepsql='psql -h redshift.staging.devoted.com -U dbadmin staging'
alias prodpsql='psql -h redshift.devoted.com -U dbadmin prod'
alias prp='PIPENV_PIPFILE=$CORE/analytics/Pipfile pipenv run python'
export VAULT_TOKEN=$(cat /srv/durable/akravetz/.vault-token-prod)
eval "$(direnv hook bash)"
direnv allow $CORE/analytics

newbranch() {
  git checkout master
  git pull
  git checkout -b $1
  git push --set-upstream origin $1
}
