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
			"self babyMock: spec."
			"self zincHttpComponents: spec."
			self aiGrapsAlgos: spec.
			self iceberg: spec.
			self parametrizedTests: spec.
			
			spec
				package: #'Pakbot-Minimal';
				package: #'Pakbot-Core'
					with: [ spec requires: #('Pakbot-Minimal' 'Iceberg' "'ZincHTTPComponents'" "'AIGraphAlgorithms'") ];

				"Tests and its ressources"
				package: #'CargoPackageManager-Spec';
				package: #'CargoPackageManager-TestRessources'
					with: [ spec requires: #('Pakbot-Core' 'CargoPackageManager-Spec') ];
				package: #'Pakbot-Tests'
					with: [ spec requires: #('Pakbot-Core' 'ParametrizedTests') ];
				package: #'CargoPackageManager-Tests'
					with: [ spec requires: #('Pakbot-Core' 'CargoPackageManager-TestRessources' 'ParametrizedTests') ];
				package: #'Pakbot-IntegrationTests' with: [ spec requires: #('Pakbot-Core' 'Pakbot-Tests') ];
				package: #'CargoPackageManager-FailingTests' with: [ spec requires: #('Pakbot-Tests') ];
				package: #'CargoPackageManager-Tests-FooResource'.
							
			self pakbotUI: spec.		
			self pakbotCatalog: spec.
				
			spec
				package: 'CargoPackageManager-Utils';
				package: #'CargoPackageManager-Utils-Tests' with: [ spec requires: #('CargoPackageManager-Tests-FooResource') ];
				package: #'CargoPackageManager-Utils-FailingTests' with: [ spec requires: #('CargoPackageManager-Utils-Tests') ].	

			spec
				group: 'core' with: #('Pakbot-Core' 'Pakbot-Catalog');
				group: 'tests-core' with:
					#('core'
					'Pakbot-Tests'
					'CargoPackageManager-FailingTests'
					'Pakbot-IntegrationTests'
					'Pakbot-Catalog-Tests'); 
				group: 'tests' with: 
					#('tests-core'
					'Pakbot-Browser-Tests'
					'utils' 
					'CargoPackageManager-Utils-Tests' 
					'CargoPackageManager-Utils-FailingTests'
					'CargoPackageManager-UI-Tests');
				group: 'utils' with: #('CargoPackageManager-Utils' 'core');
				group: 'browser' with: #('Pakbot-Browser' 'Pakbot-Browser-Tests');
				group: 'default' with: #('tests-core' 'browser') ]
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
BaselineOfPakbot >> pakbotCatalog: spec [

	spec
		package: #'Pakbot-Catalog' with: [ 
			spec requires: #( 'Pakbot-Core' ) ];
		package: #'Pakbot-Catalog-Tests' with: [ 
			spec requires:
					#( 'Pakbot-Catalog'
					   'Pakbot-Core-Tests' ) ].
				
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
		package: #'Pakbot-Browser' with: [ 
			spec requires: #( CargoPackageManager ) ];
		package: #'Pakbot-Browser-Tests' with: [ 
			spec requires: #( 'Pakbot-Browser' ) ]
]

{ #category : #baseline }
BaselineOfPakbot >> parametrizedTests: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #baseline }
BaselineOfPakbot >> zincHttpComponents: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec 
					repository: 'github://svenvc/zinc/repository';
					loads: #('REST') ]
]
