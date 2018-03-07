test data
counterUiProject
	| project |
	
	project := (CGOOngoingProject for: #'Counter-UI')
		description: 'Small UI for the counter model.';
		addExternalCargoProject: #Counter -> (CGOCargoProjectDependency repositoryUrl: 'github://demarey/pharo-counter-ui:master');
		registry: 'registry';
		yourself.
		
	(project newPackageUnit: #'Counter-UI-Spec')
		description: 'Core package with the counter UI based on Spec.';
		addDependencyOn: #'Counter::Counter-Core';
		yourself.
	
	^ project