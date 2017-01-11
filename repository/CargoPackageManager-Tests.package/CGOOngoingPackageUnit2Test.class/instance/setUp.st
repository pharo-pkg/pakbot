initialization
setUp
	super setUp.
	oldPackageRegistry := CGOPackageRegistry default.
	CGOPackageRegistry default: CGOPackageRegistry new.
	CGOPackageRegistry default
		register: CGOOngoingProject example
	