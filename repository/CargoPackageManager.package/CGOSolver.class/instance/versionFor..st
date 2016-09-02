protocol
versionFor: aPackage
	| constraints version |
	
	constraints := constraintsMap 
							at: aPackage
							ifAbsent: [ ^ nil ].
	constraints size = 1
		ifFalse: [ CGOUnresolvedDependency package: aPackage candidates: constraints ].
	[ version := constraints first version ]
		on: MessageNotUnderstood
		do: [ CGOUnresolvedDependency package: aPackage candidates: constraints ].
	^ version