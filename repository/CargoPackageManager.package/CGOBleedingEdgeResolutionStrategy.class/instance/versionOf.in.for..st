solving
versionOf: aPackageName in: aRepositoryList for: platformAttributes
	| candidates |

	candidates := Set new.
	aRepositoryList 
		do: [ :repository | 
			[ candidates add: (repository bleedingEdgeOf: aPackageName for: platformAttributes) asPackageVersionReference ]
				on: CGOPackageNotFoundError
				do: [ "ignore" ] ].
	candidates ifEmpty: [ CGOPackageNotFoundError signal: 'Cannot find ' , aPackageName , ' package' ].
	candidates := candidates groupedBy: #packageName.
	(candidates size > 1)
		ifTrue: [ CGOUnresolvedDependency package: aPackageName candidates: candidates ].
	^ (candidates at: aPackageName) detectMax: [ :v | v ]