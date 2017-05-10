accessing
collectPackageGroupProvidersFor: aProject

	^ {CGOClyAssemblyGroupProvider . CGOClyDependencyGroupProvider}
		collect: [ :each | each project: aProject ]