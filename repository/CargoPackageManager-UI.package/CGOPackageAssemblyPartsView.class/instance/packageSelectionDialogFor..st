private
packageSelectionDialogFor: aListOfPackages
	^ ListDialogWindow new
		getList: [ :regexp | aListOfPackages "sorted" select: [ :package | regexp search: package packageName ] ];
		displayBlock: [ :package | package packageName ];
		title: 'Package to add to the project';
		yourself