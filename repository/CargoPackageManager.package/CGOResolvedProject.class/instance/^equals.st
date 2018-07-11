comparing
= other
	(self class = other class) ifFalse: [ ^ false ].
	(self targetedPackage = other targetedPackage) ifFalse: [ ^ false ].
	(self packageVersion = other packageVersion) ifFalse: [ ^ false ].
	(self originDependencies = other originDependencies) ifFalse: [ ^ false ].
	^ true
	