accessing
authors
	self flag: 'TODO'.
	" Use libigt to get the result of this command?
		git log 5c3843fd626b6ce88b74302ba9d2af6bc93904a9 --format='%aN' --reverse
	"
	^ #()