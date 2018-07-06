accessing
package: aPackageName
	| dependency |
	dependency := CGOPackageDependency on: aPackageName.
	^ dependency hasScope
		ifTrue: [ "For now, only Metacello projects have a scope"
			(projects 
				at: dependency scope
				ifAbsent: [ CGOPackageNotFoundError signal: dependency dependencyName ]) 
					detect: [ :each | each hasPackage: dependency targetedPackage ] ]
		ifFalse: [ self packageVersions
			detect: [ :each | each packageName = aPackageName ]
			ifNone: [ "package name could be the name of a project"
				(projects 
					at: aPackageName 
					ifAbsent: [ CGOPackageNotFoundError signal: aPackageName ]) 
						detect: [ :each | each hasPackage: 'default' ] ] ]