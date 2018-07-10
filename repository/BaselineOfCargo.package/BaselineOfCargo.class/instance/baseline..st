baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			self icetray: spec.
			self babyMock: spec.
			self mooseAlgos: spec.
			self voyage: spec.
			self zincHttpComponents: spec.
			
			spec
				package: #'CargoPackageManager-Minimal';
				package: #CargoPackageManager
					with: [ spec requires: #('CargoPackageManager-Minimal' 'ZincHTTPComponents' 'MooseAlgos') ];

				package: #'CargoPackageManager-Repository'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-RepositoryBackend' 'CargoPackageManager-TestRessources' 'ZincHTTPComponents') ];
				package: #'CargoPackageManager-RepositoryBackend'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-TestRessources' 'Voyage') ];
					
				package: #'CargoPackageManager-Spec';
				package: #'CargoPackageManager-TestRessources'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-Spec' 'BabyMock2') ];
				package: #'CargoPackageManager-Tests' with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-TestRessources') ];
				package: #'CargoPackageManager-IntegrationTests' with: [ spec requires: #('CargoPackageManager') ];
				package: #'CargoPackageManager-FailingTests' with: [ spec requires: #('CargoPackageManager-Tests') ];
				package: #'CargoPackageManager-Tests-FooResource';
				package: #'CargoPackageManager-UI'
					with: [ spec requires: #(CargoPackageManager Icetray) ];
				package: #'CargoPackageManager-Calypso-Environment'
					with: [ spec requires: #(CargoPackageManager) ];
				package: #'CargoPackageManager-Calypso-Browser'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-UI' 'CargoPackageManager-Calypso-Environment') ];
				package: 'CargoPackageManager-Utils';
				package: #'CargoPackageManager-Utils-Tests' with: [ spec requires: #('CargoPackageManager-Tests-FooResource') ];
				package: #'CargoPackageManager-Utils-FailingTests' with: [ spec requires: #('CargoPackageManager-Utils-Tests') ].	

			spec
				group: 'client'
					with: #(CargoPackageManager 'CargoPackageManager-Calypso-Browser');
				group: 'server'
					with:
					#(#'CargoPackageManager-RepositoryBackend' 'CargoPackageManager-Repository');
				group: 'tests-client' with: #('client' 'CargoPackageManager-Tests' 'utils' 'CargoPackageManager-Utils-Tests' 'CargoPackageManager-FailingTests' 'CargoPackageManager-Utils-FailingTests' 'CargoPackageManager-IntegrationTests');
				group: 'tests-server' with: #('server' 'tests-client');
				group: 'tests' with: #('tests-client' 'tests-server');
				group: 'utils' with: #('CargoPackageManager-Utils' 'client');
				group: 'development' with: #(client server tests utils);
				group: 'default' with: 'tests-client' ]