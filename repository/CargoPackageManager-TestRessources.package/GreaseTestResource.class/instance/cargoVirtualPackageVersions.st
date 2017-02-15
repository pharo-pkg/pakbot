data - cargo package versions
cargoVirtualPackageVersions
	^ #('Grease-Core-Platform@1' 'Grease-Slime@0.1' 'Grease-Slime@1')
		collect: [ :provision | CGOVirtualPackageVersion fromString: provision ]