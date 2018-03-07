serialization
serializedDependenciesOf: aPackageDependencyList
	^ self toArray:
		(aPackageDependencyList
			collect: [ :dependency |	| constraints |
				constraints := self dependencyConstraintsMapping: dependency.
				constraints
					ifEmpty: [ dependency targetedPackage ]
					ifNotEmpty: [ Association key: dependency targetedPackage value: constraints ] ])