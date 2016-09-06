versions fetching
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	| candidates |

	candidates := CGOPackageVersion selectMany: 
		[ :each | 
		each packageName = aPackageName
		and: [ each platformRequirements 
					ifEmpty: [ true ]
					ifNotEmpty: [ :requirements | requirements includesAny: platformAttributes ] ] ].
	^ Array with: (candidates detectMax: #version) asPackageVersionReference