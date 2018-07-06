converting
asPackageVersionReference
	| semanticVersion |
	semanticVersion := [ SemanticVersion fromString: version ]
		on: SemanticVersionFormatError
		do: [ SemanticVersion fromString: '0.0.0-' , version printString ].

	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: semanticVersion