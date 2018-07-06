instance creation
fromProjectDependency: aCGOMetacelloProjectDependency
	| project |
	project := self
		repository: aCGOMetacelloProjectDependency repositoryUrl
		name: aCGOMetacelloProjectDependency name
		version: aCGOMetacelloProjectDependency version.
	aCGOMetacelloProjectDependency isMetacelloConfiguration
		ifTrue: [ project beConfiguration ]
		ifFalse: [ project beBaseline ].
	^ project