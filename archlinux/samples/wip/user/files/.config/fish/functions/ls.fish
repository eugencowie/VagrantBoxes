function ls
	# https://wiki.archlinux.org/index.php/locale#LC_COLLATE:_collation
	env LC_COLLATE=C ls --color=auto --group-directories-first $argv
end
