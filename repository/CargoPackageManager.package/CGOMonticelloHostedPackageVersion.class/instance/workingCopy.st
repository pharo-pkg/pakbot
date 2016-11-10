saving
workingCopy
	^ MCWorkingCopy allManagers 
		detect: [ :wc | wc packageName = packageName ]
		ifNone: [ CGOWorkingCopyNotFound signalFor: self ]