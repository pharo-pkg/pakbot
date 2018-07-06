building
buildPackages
	(project newPackageUnit: #'PharoLauncher-Download')
		description: 'Package dealing with image / VM detection and download.';
		addDependencyOn: #'OSProcess::Core with Output';
		addDependencyOn: #'ProcessWrapper::Core'.
	(project newPackageUnit: #'PharoLauncher-Core')
		description: 'Core package with the model, commands and settings.';
		addDependencyOn: #'PharoLauncher-Download';
		addDependencyOn: #'XMLParser::Core';
		addDependencyOn: #'Ston';
		addDependencyOn: #'JSON'.
	(project newPackageUnit: #'PharoLauncher-Spec')
		description: 'PharoLauncher UI.';
		addDependencyOn: #'PharoLauncher-Core'.
	(project newPackageUnit: #'PharoLauncher-Tests-Download')
		description: 'Tests of the PharoLauncher-Download package.';
		addDependencyOn: #'PharoLauncher-Download'.
	(project newPackageUnit: #'PharoLauncher-Tests-Core')
		description: 'Tests of the PharoLauncher-Core package..';
		addDependencyOn: #'PharoLauncher-Core'.