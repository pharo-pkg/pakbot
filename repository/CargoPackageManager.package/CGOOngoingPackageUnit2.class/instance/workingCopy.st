checking
workingCopy
	^ MCWorkingCopy allManagers 
		detect: [ :wc | wc packageName = self packageName ]
		ifNone: [ CGOWorkingCopyNotFound signalFor: self ]