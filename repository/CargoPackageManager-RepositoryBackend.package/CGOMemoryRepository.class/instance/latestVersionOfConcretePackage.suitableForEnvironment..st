versions fetching
latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes
	| candidates |

	candidates := CGOPackageVersion selectMany: 
		[ :each | 
		each packageName = aPackageName
		and: [ each platformRequirements 
					ifEmpty: [ true ]
					ifNotEmpty: [ :requirements | requirements includesAny: platformAttributes ] ] ].
	^ (candidates detectMax: #version) asPackageVersionReference