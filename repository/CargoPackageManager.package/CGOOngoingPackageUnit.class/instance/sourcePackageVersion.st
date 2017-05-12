accessing
sourcePackageVersion
	^ src ifNil: 
		[ src := CGOSourcePackageVersion 
			repository: self projectFromRegistry repository "Cannot use #project since #project send #projectFromSCM sending itself #sourcePackageVersion that will cause infinite loop"
			packageName: self packageName ]