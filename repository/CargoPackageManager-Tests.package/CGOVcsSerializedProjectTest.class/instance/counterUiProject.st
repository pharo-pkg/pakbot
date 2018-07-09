test data
counterUiProject
	| project |
	project := (CGOOngoingProject named: #'Counter-UI')
		description: 'Small UI for the counter model.';
		addExternalCargoProject:
			(CGOCargoProjectDependency
				repositoryUrl: 'github://demarey/pharo-counter-ui:master');
		registry: CGOPackageRegistry new;
		yourself.
	(project newPackageUnit: #'Counter-UI-Spec')
		description: 'Core package with the counter UI based on Spec.';
		addDependencyOn: #'Counter::Counter-Core';
		yourself.
	^ project