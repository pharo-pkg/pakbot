loading
load
	| metacello |
	metacello := Metacello new 
		repository: repository asString;
		yourself.
	self isConfiguration
		ifTrue: [ metacello configuration: name ]
		ifFalse: [ metacello baseline: name ].
	metacello
		version: version;
		load: packageNames.