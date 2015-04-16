gh-clone() {
	REPO_NAME=$1
	GITHUB_USER=$(git config --global github.user)
	if [ -z "$GITHUB_USER" ]
	then
		read -p "Enter your github.user: " GITHUB_USER
		git config --global github.user $GITHUB_USER
	fi
	GITHUB_DIR=$HOME/github.com
	TARGET_DIR=$GITHUB_DIR/$GITHUB_USER
	mkdir -p $TARGET_DIR
	REPO_URL=git@github.com:$GITHUB_USER/${REPO_NAME}.git
	cd $TARGET_DIR
	git clone $REPO_URL && cd $REPO_NAME
	if [ -e package.json ]
	then
		npm install
	fi
}
