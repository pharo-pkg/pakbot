building
mcVersionFor: reference packages: packages
	^ MCVersion new
		setPackage: 
			(packages 
				at: reference packageName
				ifAbsentPut: [ MCPackage new name: reference packageName ])
		info: (self mcVersionInfoMockFor: reference)
		snapshot: (self mcSnapshotMockFor: reference packageName)
		dependencies: #()