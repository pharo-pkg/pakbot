private
addConstraint: aConstraint on: aPackage
	| constraints |

	constraints := constraintsMap
		at: aPackage
		ifPresent: [ :currentConstraints | aConstraint mergeAll: currentConstraints ]
		ifAbsent: [ aConstraint asOrderedCollection ].
	
	constraintsMap
		at: aPackage
		put: constraints