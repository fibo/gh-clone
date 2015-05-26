# gh-clone

> GitHub clone repo util

Very simple bash function that let you clone git repositories quickly.

Ah, and it is also my first bash literate programming experiment.
Do not edit *fun.sh*, run instead `make fun` to generate source from this file.

## Annotated source

`gh-clone` expects one parameter, otherwise prints its **usage**

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

Repos will be cloned under folder `$GITHUB_DIR` which defaults to *~/github.com*.

    GITHUB_DIR=${GITHUB_DIR:-~/github.com}

`MY_GITHUB_USER` is prompted once, if not already configured.

    MY_GITHUB_USER=$(git config --global github.user)
    if [ -z "$MY_GITHUB_USER" ]
    then
    	read -p "Enter your github.user: " MY_GITHUB_USER
    	git config --global github.user $MY_GITHUB_USER
    fi

Parse parameter which can be given in the form `$GITHUB_USER/$REPO_NAME` or just `$REPO_NAME`.

    GITHUB_USER=$(echo $1 | cut -d / -f1)
    REPO_NAME=$(echo $1 | cut -d / -f2)

In the latter case `$GITHUB_USER` defaults to `$MY_GITHUB_USER`.

    if [ "$REPO_NAME" == "$GITHUB_USER" ]
    then
    	GITHUB_USER=$MY_GITHUB_USER
    fi

Clone repo under `$GITHUB_DIR/$GITHUB_USER/$REPO_NAME` and cd into it.

    TARGET_DIR=$GITHUB_DIR/$GITHUB_USER
    mkdir -p $TARGET_DIR
    cd $TARGET_DIR
    REPO_URL=git@github.com:$GITHUB_USER/${REPO_NAME}.git
    git clone $REPO_URL && cd $REPO_NAME

**Bonus feature**: run `npm install` if it looks like a Node project and there is some *npm* available.

    if [ -e package.json ]
    then
    	NPM=$(which npm 2> /dev/null)
    	if [ ! -z "$NPM" ]
    	then
    		$NPM install
    	fi
    fi

… and run `bower install` if  there is a *bower.json* anb *bower* is found in your `PATH`.

    if [ -e bower.json ]
    then
    	BOWER=$(which bower 2> /dev/null)
    	if [ ! -z "$BOWER" ]
    	then
    		$BOWER install
    	fi
    fi

Clean up

    unset BOWER
    unset GITHUB_DIR
    unset GITHUB_USER
    unset MY_GITHUB_USER
    unset NPM
    unset REPO_NAME
    unset REPO_URL
    unset TARGET_DIR

## Installation

Instructions borrowed from [git-aware-prompt](https://github.com/jimeh/git-aware-prompt#installation).

```
mkdir -p ~/.bash
cd ~/.bash
git clone git://github.com/fibo/gh-clone.git
```

Edit your *~/.bash_profile* or *~/.profile* and add the following

```
source ~/.bash/gh-clone/fun.sh
```

## License

[MIT](http://g14n.info/mit-license)

