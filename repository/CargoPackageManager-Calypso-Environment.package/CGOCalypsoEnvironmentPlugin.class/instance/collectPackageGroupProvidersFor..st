accessing
collectPackageGroupProvidersFor: aProject

	^ { CGOClyAssemblyGroupProvider }
		collect: [ :each | each project: aProject ]