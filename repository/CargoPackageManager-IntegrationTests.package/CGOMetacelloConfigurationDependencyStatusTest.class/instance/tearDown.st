running
tearDown

	(#JSON asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.	
	MetacelloProjectRegistration registry configurationRegistry removeKey: 'ConfigurationOfJSON' ifAbsent: [].
	
	super tearDown.
	