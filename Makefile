
.PHONY: fun

fun:
	> fun.sh; grep '    ' README.md | sed -e 's/^    //' >> fun.sh

