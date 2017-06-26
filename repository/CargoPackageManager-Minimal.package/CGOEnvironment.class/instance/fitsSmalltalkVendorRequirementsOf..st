checking requirements
fitsSmalltalkVendorRequirementsOf: anEnvironment
	^ self smalltalkVendor 
		ifNil: [ true ]
		ifNotNil: [ self smalltalkVendor = anEnvironment smalltalkVendor ]