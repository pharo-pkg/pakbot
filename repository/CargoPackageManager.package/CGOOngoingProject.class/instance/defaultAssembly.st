accessing
defaultAssembly

	^ (CGOOngoingPackageAssembly named: #default inProject: self)
		parts: units copy;
		yourself