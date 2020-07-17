Class {
	#name : #BaselineOfPakbot,
	#superclass : #BaselineOf,
	#category : #BaselineOfPakbot
}

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
			self icetray: spec.
			self babyMock: spec.
			self mooseAlgos: spec.
			self voyage: spec.
			"self zincHttpComponents: spec."
			self iceberg: spec.
			self parametrizedTests: spec.
			
			spec
				package: #'CargoPackageManager-Minimal';
				package: #CargoPackageManager
					with: [ spec requires: #('CargoPackageManager-Minimal' 'Iceberg' "'ZincHTTPComponents'" 'MooseAlgos') ];

				package: #'PakbotPackageManager-Repository'
					with: [ spec requires: #(CargoPackageManager) ];
				package: #'PakbotPackageManager-Repository-Tests'
					with: [ spec requires: #('PakbotPackageManager-Repository' 'CargoPackageManager-Tests') ];
				package: #'PakbotPackageManager-Repository-IntegrationTests'
					with: [ spec requires: #('PakbotPackageManager-Repository' 'CargoPackageManager-Tests') ];
					
				package: #'CargoPackageManager-Repository'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-RepositoryBackend' 'CargoPackageManager-TestRessources' "'ZincHTTPComponents'") ];
				package: #'CargoPackageManager-RepositoryBackend'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-TestRessources' 'Voyage') ];
					
				package: #'CargoPackageManager-Spec';
				package: #'CargoPackageManager-TestRessources'
					with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-Spec' 'BabyMock2') ];
				package: #'CargoPackageManager-Tests' with: [ spec requires: #(CargoPackageManager 'CargoPackageManager-TestRessources' 'ParametrizedTests') ];
				package: #'CargoPackageManager-IntegrationTests' with: [ spec requires: #('CargoPackageManager' 'CargoPackageManager-Tests') ];
				package: #'CargoPackageManager-FailingTests' with: [ spec requires: #('CargoPackageManager-Tests') ];
				package: #'CargoPackageManager-Tests-FooResource';
				package: #'CargoPackageManager-UI' with: [ spec requires: #(CargoPackageManager Icetray) ];
				package: #'CargoPackageManager-UI-Tests' with: [ spec requires: #('CargoPackageManager-UI' 'CargoPackageManager-Calypso-Browser') ];
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
				group: 'tests-client' with: 
					#('client' 
					'CargoPackageManager-Tests' 
					'utils' 
					'CargoPackageManager-Utils-Tests' 
					'CargoPackageManager-FailingTests' 
					'CargoPackageManager-Utils-FailingTests'
					'CargoPackageManager-IntegrationTests'
					'CargoPackageManager-UI-Tests' 
					'PakbotPackageManager-Repository-Tests'
					'PakbotPackageManager-Repository-IntegrationTests');
				group: 'tests-client-pharo9' with: 
					#(CargoPackageManager 
					'CargoPackageManager-Tests' 
					'utils' 
					"'CargoPackageManager-Utils-Tests' 
					'CargoPackageManager-FailingTests' 
					'CargoPackageManager-Utils-FailingTests'"
					'CargoPackageManager-IntegrationTests'
					'CargoPackageManager-UI-Tests' 
					'PakbotPackageManager-Repository-Tests'
					'PakbotPackageManager-Repository-IntegrationTests');
				group: 'tests-server' with: #('server' 'tests-client');
				group: 'tests' with: #('tests-client' 'tests-server');
				group: 'utils' with: #('CargoPackageManager-Utils' 'client');
				group: 'development' with: #(client server tests utils);
				group: 'default' with: 'tests-client' ]
]

{ #category : #baseline }
BaselineOfPakbot >> iceberg: spec [
	| repository |
	"re := '[:space:]*repository\:[:space:]*(.+)' asRegex.
	re matchesIn:
		((BaselineOfIDE>>#loadIceberg) sourceCode lines 
		detect: [ :line | line includesSubstring: 'repository:' ])."
	
	spec
		baseline: 'Iceberg'
		with: [ spec
				repository: 'github://pharo-vcs/iceberg:v1.8.3';
				loads: #('Iceberg-Memory') ]
]

{ #category : #baseline }
BaselineOfPakbot >> icetray: spec [
	spec baseline: 'Icetray' with: [ spec repository: 'github://pharo-spec/icetray/src' ]
]

{ #category : #baseline }
BaselineOfPakbot >> mooseAlgos: spec [
	spec
    	baseline: 'MooseAlgos'
    	with: [ spec 
					repository: 'github://moosetechnology/MooseAlgos:master/src';
					loads: #('Moose-Algos-Graph') ]
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
