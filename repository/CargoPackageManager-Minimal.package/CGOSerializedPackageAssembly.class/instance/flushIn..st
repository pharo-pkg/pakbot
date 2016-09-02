deserialization
flushIn: aPackageAssembly
	super flushIn: aPackageAssembly.
	self deserializePartsIn: aPackageAssembly