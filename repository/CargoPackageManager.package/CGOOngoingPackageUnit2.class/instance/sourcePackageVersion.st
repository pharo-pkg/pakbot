accessing
sourcePackageVersion
	^ src ifNil: 
		[ src := CGOSourcePackageVersion 
			repository: self project repository
			packageName: self packageName ]