checking
workingCopy
	^ MCWorkingCopy allManagers 
		detect: [ :wc | wc packageName = self packageName ]
		ifNone: [ Error signal: self packageName , ' has no working copy!' ]