tests
setUp

	super setUp.
	registry := CGOPackageRegistry new.
	project := CGOOngoingProject named: 'test'.
	registry register: project.
	
	systemPackageOrganizer := RPackageOrganizer new.
	project systemPackageOrganizer: systemPackageOrganizer.