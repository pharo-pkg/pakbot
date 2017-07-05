solving
versionOf: aPackageName in: aRepositoryList forEnvironment: platformAttributes
	| candidates |

	candidates := Set new.
	aRepositoryList 
		do: [ :repository | 
			[ candidates add: (repository latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes) asPackageVersionReference ]
				on: CGOPackageNotFoundError
				do: [ "ignore" ] ].
	candidates ifEmpty: [ CGOPackageNotFoundError signal: aPackageName ].
	candidates := candidates groupedBy: #packageName.
	(candidates size > 1)
		ifTrue: [ CGOUnresolvedDependency package: aPackageName candidates: candidates ].
	^ (candidates at: aPackageName) detectMax: [ :v | v ]