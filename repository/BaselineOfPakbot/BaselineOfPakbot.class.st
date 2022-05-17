Class {
	#name : #BaselineOfPakbot,
	#superclass : #BaselineOf,
	#category : #BaselineOfPakbot
}

{ #category : #baseline }
BaselineOfPakbot >> aiGrapsAlgos: spec [
	spec
    	baseline: 'AIGraphAlgorithms'
    	with: [ spec 
					repository: 'github://pharo-ai/graph-algorithms:v1.1.0/src' ]
]

{ #category : #baseline }
BaselineOfPakbot >> babyMock: spec [
	spec
		project: 'BabyMock2'
		with: [ spec
				className: #ConfigurationOfBabyMock2;
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ]
]

{ #category : #baseline }
BaselineOfPakbot >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			"self icetray: spec."
			"self babyMock: spec."
			self voyage: spec.
			"self zincHttpComponents: spec."
			self aiGrapsAlgos: spec.
			self iceberg: spec.
			self parametrizedTests: spec.
			
			spec
				package: #'CargoPackageManager-Minimal';
				package: #CargoPackageManager
					with: [ spec requires: #('CargoPackageManager-Minimal' 'Iceberg' "'ZincHTTPComponents'" 'AIGraphAlgorithms') ];

				"Tests and its ressources"
				package: #'CargoPackageManager-Spec';
				package: #'CargoPackageManager-TestRessources'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-Spec') ];
				package: #'CargoPackageManager-Tests' with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-TestRessources' 'ParametrizedTests') ];
				package: #'CargoPackageManager-IntegrationTests' with: [ spec requires: #('CargoPackageManager' 'CargoPackageManager-Tests') ];
				package: #'CargoPackageManager-FailingTests' with: [ spec requires: #('CargoPackageManager-Tests') ];
				package: #'CargoPackageManager-Tests-FooResource'.
							
			self pakbotUI: spec.		
			self pakbotPackageRepository: spec.
				
			spec
				package: 'CargoPackageManager-Utils';
				package: #'CargoPackageManager-Utils-Tests' with: [ spec requires: #('CargoPackageManager-Tests-FooResource') ];
				package: #'CargoPackageManager-Utils-FailingTests' with: [ spec requires: #('CargoPackageManager-Utils-Tests') ].	

			spec
				group: 'client' with: #(CargoPackageManager);
				group: 'tests-client' with:
					#('client'
					'CargoPackageManager-Tests'
					'CargoPackageManager-FailingTests'
					'CargoPackageManager-IntegrationTests'
					); 
				group: 'tests-client-ui' with: 
					#('tests-client-ui'
					'utils' 
					'CargoPackageManager-Utils-Tests' 
					'CargoPackageManager-Utils-FailingTests'
					'CargoPackageManager-UI-Tests');
				group: 'tests-server' with: 
					#('PakbotPackageManager-Repository-Tests'
					'PakbotPackageManager-Repository-IntegrationTests');
				group: 'tests' with: #('tests-client-ui' 'tests-server');
				group: 'utils' with: #('CargoPackageManager-Utils' 'client');
				group: 'default' with: 'tests-client' ]
]

{ #category : #baseline }
BaselineOfPakbot >> iceberg: spec [
	
	spec
		baseline: 'Iceberg'
		with: [ spec
				repository: (self class environment at: #BaselineOfPharo) icebergRepository;
				loads: #('Iceberg-Memory') ]
]

{ #category : #baseline }
BaselineOfPakbot >> icetray: spec [
	spec baseline: 'Icetray' with: [ spec repository: 'github://pharo-spec/icetray/src' ]
]

{ #category : #baseline }
BaselineOfPakbot >> pakbotPackageRepository: spec [

	spec
		package: #'PakbotPackageManager-Repository' with: [ 
			spec requires: #( CargoPackageManager ) ];
		package: #'PakbotPackageManager-Repository-Tests' with: [ 
			spec requires:
					#( 'PakbotPackageManager-Repository'
					   'CargoPackageManager-Tests' ) ];
		package: #'PakbotPackageManager-Repository-IntegrationTests' with: [ 
			spec requires:
					#( 'PakbotPackageManager-Repository'
					   'CargoPackageManager-Tests' ) ].
				
	" Old implementation using aMongoDB as backend"
	"spec			
		package: #'CargoPackageManager-Repository' with: [ 
			spec requires:
					#( CargoPackageManager 
						'CargoPackageManager-RepositoryBackend'
					   'CargoPackageManager-TestRessources' ) ""'ZincHTTPComponents'"" ];
		package: #'CargoPackageManager-RepositoryBackend' with: [ 
			spec requires:
					#( CargoPackageManager 
						'CargoPackageManager-TestRessources'
					   'Voyage' ) ]"
]

{ #category : #baseline }
BaselineOfPakbot >> pakbotUI: spec [

	spec
		package: #'CargoPackageManager-UI' with: [ 
			spec requires: #( CargoPackageManager ) ];
		
		package: #'CargoPackageManager-UI-Tests' with: [ 
			spec requires:
					#( 'CargoPackageManager-UI' 'CargoPackageManager-Calypso-Browser' ) ];
				
		package: #'CargoPackageManager-Calypso-Environment'	with: [ 
				spec requires: #( CargoPackageManager ) ];
			
		package: #'CargoPackageManager-Calypso-Browser' with: [ 
			spec requires: #( CargoPackageManager 'CargoPackageManager-UI'
					   'CargoPackageManager-Calypso-Environment' ) ]
]

{ #category : #baseline }
BaselineOfPakbot >> parametrizedTests: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #baseline }
BaselineOfPakbot >> voyage: spec [
	spec
		baseline: 'Voyage'
		with: [ spec
				repository: 'github://pharo-nosql/voyage:master/mc';
				loads: #('memory' 'mongo tests') ]
]

{ #category : #baseline }
BaselineOfPakbot >> zincHttpComponents: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec 
					repository: 'github://svenvc/zinc/repository';
					loads: #('REST') ]
]
