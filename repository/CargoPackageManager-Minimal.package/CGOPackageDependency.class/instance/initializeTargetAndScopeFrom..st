initialization
initializeTargetAndScopeFrom: aPackageName
	| index |
	index := self indexOfScope: aPackageName.
	index = 0
		ifTrue: [ targetedPackage := aPackageName asSymbol ]
		ifFalse: [ scope := aPackageName asSymbol first: index - 1.
			targetedPackage := aPackageName asSymbol
				copyFrom: index + 2
				to: aPackageName size ]