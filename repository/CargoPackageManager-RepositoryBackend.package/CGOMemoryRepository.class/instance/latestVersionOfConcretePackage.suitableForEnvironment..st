versions fetching
latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes
	| candidates |

	candidates := CGOPackageVersion selectMany: 
		[ :each | 
		each packageName = aPackageName
		and: [ self does: each fitPlatformRequirements: platformAttributes ] ].
	^ (candidates detectMax: #version) asPackageVersionReference