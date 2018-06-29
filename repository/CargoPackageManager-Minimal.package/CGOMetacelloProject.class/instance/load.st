loading
load
	| metacello |
	metacello := Metacello new 
		repository: repository;
		yourself.
	self isConfiguration
		ifTrue: [ metacello configuration: name ]
		ifFalse: [ metacello baseline: name ].
	metacello
		version: version;
		load: packageNames.