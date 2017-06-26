accessing
smalltalkVersion
	^ tags
		at: self class smalltalkVersionTag 
		ifAbsent: [ nil ]