# gh-clone

> GitHub clone repo util

## Annotated source

`gh-clone` accepts one parameter, the GitHub repo zou want to clone, for example

* gh-clone foo

    gh-clone() {
    	REPO_NAME=$1

`GITHUB_USER` is prompted once, if not already configured.

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

Clone repo under `$HOME/github.com/$GITHUB_USER/$REPO_NAME` and cd into it.

    	cd $TARGET_DIR
    	git clone $REPO_URL && cd $REPO_NAME

Run `npm install` if it looks like a Node project.

    	if [ -e package.json ]
    	then
    		npm install
    	fi
    }

Run `make fun` to generate source from this file.

## Installation

Instructions borrowed from [git-aware-prompt](https://github.com/jimeh/git-aware-prompt#installation).

```
mkdir -p ~/.bash
cd ~/.bash
git clone git://github.com/fibo/gh-clone.git
```

Edit your `~/.bash_profile` or `~/.profile` and add the following

```
source ~/.bash/gh-clone/fun.sh
```

## License

[MIT](http://g14n.info/mit-license)

