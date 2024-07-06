# gh-clone

> GitHub clone repo util

[![KLP](https://img.shields.io/badge/kiss-literate-orange.svg)](http://g14n.info/kiss-literate-programming)

Very simple bash function that let you quickly clone git your repositories stored on GitHub.

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
    	cat <<-EOF
	Missing github.user config, run a command like

    		git config --global github.user <MY_GITHUB_USER>
    	EOF
    	return 0
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
Use `git clone --recursive` to initialize and update submodules.

    TARGET_DIR=$GITHUB_DIR/$GITHUB_USER
    mkdir -p $TARGET_DIR
    cd $TARGET_DIR
    REPO_URL=git@github.com:$GITHUB_USER/${REPO_NAME}.git
    git clone --recursive $REPO_URL && cd $REPO_NAME

Clean up

    unset GITHUB_DIR
    unset GITHUB_USER
    unset MY_GITHUB_USER
    unset REPO_NAME
    unset REPO_URL
    unset TARGET_DIR

## Installation

To install, do something like the following.

Clone the repo somewhere

```bash
mkdir -p ~/.shell
cd ~/.shell
git clone git://github.com/fibo/gh-clone.git
```

Edit your *~/.profile* and add the following

```bash
source ~/.shell/gh-clone/fun.sh
```

## License

[MIT](https://fibo.github.io/mit-license)

