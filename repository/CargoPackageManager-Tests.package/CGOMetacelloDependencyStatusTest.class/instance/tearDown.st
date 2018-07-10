running
tearDown

	Smalltalk at:#ConfigurationOfCargoTestExample ifPresent: [ :aClass |
			(aClass project version: '2.0') packages do: [ :each | 
				(each getName asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem].
			aClass package removeFromSystem. ].
		
	MetacelloProjectRegistration registry configurationRegistry removeKey: 'ConfigurationOfCargoTestExample' ifAbsent: [].
	
	super tearDown.
	