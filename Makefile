
.PHONY: fun

fun:
	echo 'gh-clone() {' > fun.sh; grep '    ' README.md | sed -e 's/    /\t/' >> fun.sh; echo '}' >> fun.sh

