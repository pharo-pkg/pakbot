Class {
	#name : #BaselineOfPakbot,
	#superclass : #BaselineOf,
	#category : #BaselineOfPakbot
}

{ #category : #dependencies }
BaselineOfPakbot >> aiGrapsAlgos: spec [
	spec
    	baseline: 'AIGraphAlgorithms'
    	with: [ spec 
					repository: 'github://pharo-ai/graph-algorithms:v1.1.0/src' ]
]

{ #category : #baselines }
BaselineOfPakbot >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			"self zincHttpComponents: spec."
			"self aiGrapsAlgos: spec."
			self iceberg: spec.
			self parametrizedTests: spec.
			
			spec
				package: #'Pakbot-Minimal';
				package: #'Pakbot-Core'
					with: [ spec requires: #('Pakbot-Minimal' 'Iceberg' "'ZincHTTPComponents'" "'AIGraphAlgorithms'") ];

				"Tests and its ressources"
				package: #'Pakbot-Tests'
					with: [ spec requires: #('Pakbot-Core' 'ParametrizedTests') ];
				package: #'Pakbot-IntegrationTests' with: [ spec requires: #('Pakbot-Core' 'Pakbot-Tests') ].
							
			self pakbotUI: spec.		
			self pakbotCatalog: spec.
				
			spec
				group: 'core' with: #('Pakbot-Core' 'Pakbot-Catalog');
				group: 'tests-core' with:
					#('core'
					'Pakbot-Tests'
					'Pakbot-IntegrationTests'
					'Pakbot-Catalog-Tests'); 
				group: 'tests' with: 
					#('tests-core'
					'Pakbot-Browser-Tests');
				group: 'browser' with: #('Pakbot-Browser' 'Pakbot-Browser-Tests');
				group: 'default' with: #('tests-core' 'browser') ]
]

{ #category : #dependencies }
BaselineOfPakbot >> iceberg: spec [
	
	spec
		baseline: 'Iceberg'
		with: [ spec
				repository: (self class environment at: #BaselineOfPharo) icebergRepository;
				loads: #('Iceberg-Memory') ]
]

{ #category : #dependencies }
BaselineOfPakbot >> pakbotCatalog: spec [

	spec
		package: #'Pakbot-Catalog' with: [ 
			spec requires: #( 'Pakbot-Core' ) ];
		package: #'Pakbot-Catalog-Tests' with: [ 
			spec requires:
					#( 'Pakbot-Catalog'
					   'Pakbot-Tests' ) ].
				
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

{ #category : #dependencies }
BaselineOfPakbot >> pakbotUI: spec [

	spec
		package: #'Pakbot-Browser' with: [ 
			spec requires: #( 'Pakbot-Core' ) ];
		package: #'Pakbot-Browser-Tests' with: [ 
			spec requires: #( 'Pakbot-Browser' ) ]
]

{ #category : #dependencies }
BaselineOfPakbot >> parametrizedTests: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #dependencies }
BaselineOfPakbot >> zincHttpComponents: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec 
					repository: 'github://svenvc/zinc/repository';
					loads: #('REST') ]
]
