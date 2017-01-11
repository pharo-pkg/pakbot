comparing
hash
	self flag: 'warning #= was updated to take into account all inst var for equality.
	 do not rely anymore on the package name. Hash should reflect that'.
	^ self packageName hash