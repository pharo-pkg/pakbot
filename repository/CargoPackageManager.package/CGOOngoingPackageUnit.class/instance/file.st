accessing
file
	self flag: 'TODO: handle git'.
	
	[ self workingCopy needsSaving 
		ifTrue: [ CGODirtyPackageWarning signal: self packageName , ' has unsaved changes' ].
	^ self workingCopy ancestors first name ]
	on: CGOMissingSourcePackageRepository, MessageNotUnderstood
	do: [ ^ nil ]