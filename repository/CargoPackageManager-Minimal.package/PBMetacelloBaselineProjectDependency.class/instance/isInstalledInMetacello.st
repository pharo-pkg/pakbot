querying - installed
isInstalledInMetacello
	| baseline |
	baseline := MetacelloProjectRegistration registry baselineRegistry 
		at: #BaselineOf , name 
		ifAbsent: [ ^ false ].
	^ baseline currentVersionString = version 
		and: [ baseline loadedInImage 
			and: [ baseline baselineProjectSpec loads isEmpty ] ]