running
tearDown


	Smalltalk at: #ConfigurationOfCargoTestExample ifPresent: [ :aConf |
		(aConf project version: '2.0') packages do: [ :aPackageSpec | (aPackageSpec name asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem. ].
		aConf package removeFromSystem.
	].

	MetacelloProjectRegistration registry configurationRegistry removeKey: 'ConfigurationOfCargoTestExample' ifAbsent: [].
	
	super tearDown.
	