initialization
initializeWithName: aName
	"Duplicated from GoferVersionReference to avoid a dependency"
	| basicName |
	
	super initialize.
	basicName := aName last isDigit
		ifTrue: [ aName ]
		ifFalse: [ (aName copyUpToLast: $.) copyUpTo: $( ].
	packageName := basicName copyUpToLast: $-.
	(packageName includes: $.)
		ifFalse: [ branch := '' ]
		ifTrue: [
			branch := packageName copyAfter: $..
			packageName := packageName copyUpTo: $. ].
	author := (basicName copyAfterLast: $-) copyUpToLast: $..
	versionNumber := (basicName copyAfterLast: $-) copyAfterLast: $..
	(versionNumber notEmpty and: [ versionNumber allSatisfy: [ :each | each isDigit ] ])
		ifTrue: [ versionNumber := versionNumber asInteger ]
		ifFalse: [ versionNumber := 0 ]