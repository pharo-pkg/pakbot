accessing
sourcePackageVersion
	^ src ifNil: 
		[ src := CGOSourcePackageVersion 
			repository: self projectFromRegistry repository "Cannot use #project since # project send #projectFromSCM sending itself #sourcePackageVersion that will caus infinite loop"
			packageName: self packageName ]