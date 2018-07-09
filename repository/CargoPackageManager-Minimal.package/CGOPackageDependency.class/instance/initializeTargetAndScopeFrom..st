initialization
initializeTargetAndScopeFrom: aPackageName
	| index |
	index := self indexOfScope: aPackageName.
	index = 0
		ifTrue: [ targetedPackage := aPackageName asSymbol ]
		ifFalse: [ scope := (aPackageName first: index - 1) asSymbol.
			targetedPackage := (aPackageName
				copyFrom: index + 2
				to: aPackageName size) asSymbol ]