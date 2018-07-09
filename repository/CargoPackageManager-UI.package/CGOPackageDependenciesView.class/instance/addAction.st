actions
addAction
	
	CGONewDependencyDialog new 
		openDialogOnAccept: [ :dependency |
			ongoingPackageVersion addDependency: dependency.
			self refreshUI ]
		onCancel: [ "Nothing" ]