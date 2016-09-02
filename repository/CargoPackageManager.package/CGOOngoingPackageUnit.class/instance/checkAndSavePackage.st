checking
checkAndSavePackage
	self workingCopy needsSaving 
		ifTrue: [ self flag: 'ignore in experimentation mode' "PMDirtyPackageWarning signal: self packageName , ' has unsaved changes'" ].
	self checkRepositories.
	self savePackage. "We need to save the package because meta-data could have been updated"