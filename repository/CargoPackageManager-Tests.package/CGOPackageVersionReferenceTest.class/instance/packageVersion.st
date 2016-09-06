input
packageVersion
	^ self packageVersions detect: [ :each | each packageName = pkgVersionReference packageName ]