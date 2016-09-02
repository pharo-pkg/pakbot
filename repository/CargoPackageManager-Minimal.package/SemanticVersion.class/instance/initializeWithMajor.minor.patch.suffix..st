initialization
initializeWithMajor: majorNumber minor: minorNumber patch: patchNumber suffix: suffixString
	super initialize.
	major := majorNumber.
	minorNumber 
		ifNil: [ 0 ]
		ifNotNil: [ minor := minorNumber ].
	patchNumber
		ifNil: [ 0 ]
		ifNotNil: [ patch := patchNumber ].
	suffixString ifNotNil: [ suffix := suffixString ]