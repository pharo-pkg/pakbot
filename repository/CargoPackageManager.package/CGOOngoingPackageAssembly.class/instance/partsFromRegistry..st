private
partsFromRegistry: filterBlock
	^ parts
		collect: [ :each | 
			self project registry 
				packageNamed: each packageName 
				ifAbsent: [ CGOPackageNotFoundError signal: each packageName ] ]
		thenSelect: filterBlock