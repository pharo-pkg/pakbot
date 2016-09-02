instance creation
fromString: aString
	"Answer the parts of aString, expected in short format <major>.<minor>.<patch>"
	| parts version majorNumber minorNumber patchNumber suffixString |

	aString ifNil: [ ^ self ].
	
	version := self new.
	parts := $. split: aString.
	(parts size > 3) ifTrue: [ SemanticVersionFormatError signal: aString ].
	
	majorNumber := (parts at: 1) asInteger.
	majorNumber ifNil: [ SemanticVersionFormatError signal: 'Wrong major format' ].
	[ minorNumber := (parts at: 2) asInteger.
	minorNumber ifNil: [ SemanticVersionFormatError signal: 'Wrong minor format' ].
	patchNumber := (parts at: 3) asInteger. ]
		on: SubscriptOutOfBounds
		do: [ "if minor and/or patch version is not specified, keep nil" ].
	suffixString := self suffixFrom: parts last.
	version 
		initializeWithMajor: majorNumber
		minor: minorNumber
		patch: patchNumber
		suffix: suffixString.
		
	^ version