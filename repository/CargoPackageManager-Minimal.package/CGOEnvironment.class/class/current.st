accessing
current
	^ Current ifNil: 
		[ Current := self new 
			smalltalkVendor: SystemVersion current type;
			smalltalkVersion: SystemVersion current dottedMajorMinor;
			yourself.
			"with: 'Environment:Smalltalk:VM' ->"
			"with: 'Environment:OS:Type' -> OSPlatform currentPlatformName" ]