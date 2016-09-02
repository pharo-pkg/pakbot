*CargoPackageManager
packageNamed: aString
	^ self subclasses detect: 
		[ :manifest | 
		[ manifest packageName = aString asSymbol ]
			on: ShouldBeImplemented
			do: [ false ] ]