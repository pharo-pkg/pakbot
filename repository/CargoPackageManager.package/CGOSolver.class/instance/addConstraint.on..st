private
addConstraint: aConstraint on: aPackageName
	| constraints |

	constraints := constraintsMap
		at: aPackageName
		ifPresent: [ :currentConstraints | aConstraint mergeAll: currentConstraints ]
		ifAbsent: [ aConstraint asOrderedCollection ].
	
	constraintsMap
		at: aPackageName
		put: constraints