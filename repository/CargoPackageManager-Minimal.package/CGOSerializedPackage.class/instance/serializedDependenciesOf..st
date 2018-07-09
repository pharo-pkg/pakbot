serialization
serializedDependenciesOf: aPackageDependencyList
	^ self toArray:
		(aPackageDependencyList
			collect: [ :dependency |	| constraints |
				constraints := self dependencyConstraintsMapping: dependency.
				constraints
					ifEmpty: [ dependency dependencyName ]
					ifNotEmpty: [ Association key: dependency dependencyName value: constraints ] ])