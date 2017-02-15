tests
testCanDeserialize
	| stonString virtualPkgVersion |
	stonString := CGOPackageVersionWriter
		toStringPretty: self mailVirtualPackage.
	
	virtualPkgVersion := STON fromString: stonString.
	
	self
		assert: virtualPkgVersion
		equals: self mailVirtualPackage.
	self 	
		assert: virtualPkgVersion package class
		equals: CGOVirtualPackage 