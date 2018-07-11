converting
asPackageDependency
	^ (self packageName -> {('=', self version asString)}) asPackageDependency
		project: project;
		yourself