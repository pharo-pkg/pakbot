checking requirements
fitsRequirementsOf: anEnvironment
	^ (self fitsSmalltalkVendorRequirementsOf: anEnvironment)
		and: [ self fitsSmalltalkVersionRequirementsOf: anEnvironment ]