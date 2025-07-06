gh-clone() {
	if [ -z "$1" ]
	then
		cat <<-EOF
		# GitHub clone repo util
		##
		# Installation instructions, source and license available here:
		# https://github.com/fibo/gh-clone
		##
		USAGE: gh-clone [user/]repo
		EOF
		return 0
	fi
	GITHUB_DIR=${GITHUB_DIR:-$HOME/github.com}
	MY_GITHUB_USER=$(git config --global github.user)
	if [ -z "$MY_GITHUB_USER" ]
	then
		cat <<-EOF
			git config --global github.user <MY_GITHUB_USER>
		EOF
		return 0
	fi
	GITHUB_USER=$(echo "$1" | cut -d / -f1)
	REPO_NAME=$(echo "$1" | cut -d / -f2)
	if [ "$REPO_NAME" = "$GITHUB_USER" ]
	then
		GITHUB_USER=$MY_GITHUB_USER
	fi
	mkdir -p "$GITHUB_DIR/$GITHUB_USER"
	cd "$GITHUB_DIR/$GITHUB_USER"
	if [ -d "$REPO_NAME" ]
	then
	  echo "Repo directory $GITHUB_USER/$REPO_NAME already exists"
	else
	  git clone --recursive git@github.com:$GITHUB_USER/$REPO_NAME.git
	fi
	  cd $REPO_NAME
	unset GITHUB_DIR
	unset GITHUB_USER
	unset MY_GITHUB_USER
	unset REPO_NAME
}
