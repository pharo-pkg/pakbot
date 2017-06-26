accessing
smalltalkVersion: aString
	^ tags
		at: self class smalltalkVersionTag 
		put: aString