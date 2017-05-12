accessing
dependenciesOf: systemPackage
	| package |
	package := cargoRegistry packageNamed: systemPackage name.
	^ package dependencies 
		collect: [ :dependency |
			cargoRegistry packageNamed: dependency packageName ifAbsent: [ nil ] ]
		thenSelect: #notNil