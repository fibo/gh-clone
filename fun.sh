gh-clone() {
tif [ -z "$1" ]
tthen
t	cat <<-EOF
t	# GitHub clone repo util
t	##
t	# Installation instructions, source and license available here:
t	# https://github.com/fibo/gh-clone#gh-clone
t	##
t	USAGE: gh-clone [user/]repo
t	EOF
t	return 0
tfi
tGITHUB_DIR=${GITHUB_DIR:-~/github.com}
tMY_GITHUB_USER=$(git config --global github.user)
tif [ -z "$MY_GITHUB_USER" ]
tthen
t	read -p "Enter your github.user: " MY_GITHUB_USER
t	git config --global github.user $MY_GITHUB_USER
tfi
tGITHUB_USER=$(echo $1 | cut -d / -f1)
tREPO_NAME=$(echo $1 | cut -d / -f2)
tif [ "$REPO_NAME" == "$GITHUB_USER" ]
tthen
t	GITHUB_USER=$MY_GITHUB_USER
tfi
tTARGET_DIR=$GITHUB_DIR/$GITHUB_USER
tmkdir -p $TARGET_DIR
tcd $TARGET_DIR
tREPO_URL=git@github.com:$GITHUB_USER/${REPO_NAME}.git
tgit clone --recursive $REPO_URL && cd $REPO_NAME
tif [ -e package.json ]
tthen
t	NPM=$(which npm 2> /dev/null)
t	if [ ! -z "$NPM" ]
t	then
t		$NPM install
t	fi
tfi
tif [ -e bower.json ]
tthen
t	BOWER=$(which bower 2> /dev/null)
t	if [ ! -z "$BOWER" ]
t	then
t		$BOWER install
t	fi
tfi
tunset BOWER
tunset GITHUB_DIR
tunset GITHUB_USER
tunset MY_GITHUB_USER
tunset NPM
tunset REPO_NAME
tunset REPO_URL
tunset TARGET_DIR
}
