accessing
collectPackageGroupProvidersFor: aProject

	^ { CGOClyPackageGroupProvider }
		collect: [ :each | each project: aProject ]