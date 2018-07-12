input
resolvedProjectVersion
	^ self packageVersions detect: [ :each | each packageName = pkgVersionReference packageName ]