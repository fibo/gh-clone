gh-clone() {
	if [ -z "$1" ]
	then
		cat <<-EOF
		# GitHub clone repo util
		##
		# Installation instructions, source and license available here:
		# https://github.com/fibo/gh-clone#gh-clone
		##
		USAGE: gh-clone [user/]repo
		EOF
		return 0
	fi
	GITHUB_DIR=${GITHUB_DIR:-~/github.com}
	MY_GITHUB_USER=$(git config --global github.user)
	if [ -z "$MY_GITHUB_USER" ]
	then
		read -p "Enter your github.user: " MY_GITHUB_USER
		git config --global github.user $MY_GITHUB_USER
	fi
	GITHUB_USER=$(echo $1 | cut -d / -f1)
	REPO_NAME=$(echo $1 | cut -d / -f2)
	if [ "$REPO_NAME" == "$GITHUB_USER" ]
	then
		GITHUB_USER=$MY_GITHUB_USER
	fi
	TARGET_DIR=$GITHUB_DIR/$GITHUB_USER
	mkdir -p $TARGET_DIR
	cd $TARGET_DIR
	REPO_URL=git@github.com:$GITHUB_USER/${REPO_NAME}.git
	git clone $REPO_URL && cd $REPO_NAME
	if [ -e package.json ]
	then
		NPM=$(which npm 2> /dev/null)
		if [ ! -z "$NPM" ]
		then
			$NPM install
		fi
	fi
	if [ -e bower.json ]
	then
		BOWER=$(which bower 2> /dev/null)
		if [ ! -z "$BOWER" ]
		then
			$BOWER install
		fi
	fi
	unset BOWER
	unset GITHUB_DIR
	unset GITHUB_USER
	unset MY_GITHUB_USER
	unset NPM
	unset REPO_NAME
	unset REPO_URL
	unset TARGET_DIR
}
