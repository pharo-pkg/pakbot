Class {
	#name : #ConfigurationOfCargo,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfCargo'
}

{ #category : #'development support' }
ConfigurationOfCargo class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfCargo class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfCargo class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfCargo class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfCargo class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfCargo class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfCargo class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfCargo class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfCargo class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfCargo class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfCargo >> baseline01: spec [
	<version: 'baseline-0.1'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/demarey/PPM/main'.
		spec 
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'Roassal' with: [
				spec
					className: #ConfigurationOfRoassal;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal/main/' ].
		spec package: 'PackagesManager'. ].

]

{ #category : #baselines }
ConfigurationOfCargo >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/demarey/PPM/main'.
		spec 
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/STON/main/' ];
			project: 'VoyageMongo' with: [
				spec
					className: #ConfigurationOfVoyageMongo;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/estebanlm/Voyage/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'bleedingEdge';
					loads: #('REST' );
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/' ];
			project: 'MooseAlgos' with: [
				spec
					className: #ConfigurationOfMooseAlgos;
					versionString: #'bleedingEdge';
					loads: #('Moose-Algos-Graph' );
					repository: 'http://smalltalkhub.com/mc/Moose/MooseAlgos/main/' ].
		spec 
			package: #PackageManager with: [
				spec requires: #('Ston' 'ZincHTTPComponents' 'MooseAlgos' ). ];
			package: #'PackageManager-Spec';
			package: #'PackageManager-TestRessources' with: [
				spec requires: #(#PackageManager #'PackageManager-Spec' 'BabyMock2' ). ];
			package: #'PackageManager-RepositoryBackend' with: [
				spec requires: #(#PackageManager #'PackageManager-TestRessources' 'VoyageMongo' ). ];
			package: #'PackageManager-Tests' with: [
				spec requires: #(#PackageManager #'PackageManager-RepositoryBackend' #'PackageManager-TestRessources' 'Ston' ). ];
			package: #'PackageManager-Repository' with: [
				spec requires: #(#PackageManager #'PackageManager-RepositoryBackend' #'PackageManager-TestRessources' 'ZincHTTPComponents' ). ].
		spec 
			group: 'server' with: #(#PackageManager #'PackageManager-RepositoryBackend' #'PackageManager-Repository' );
			group: 'client' with: #(#PackageManager ). ].

]

{ #category : #baselines }
ConfigurationOfCargo >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/demarey/CargoPackageManager/main'.
		spec 
			project: 'BabyMock2' with: [
				spec
					className: #ConfigurationOfBabyMock2;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ];
			project: 'DependencyAnalyser' with: [
				spec
					className: #ConfigurationOfDependencyAnalyser;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/Tool-DependencyAnalyser/main/' ];
			project: 'MooseAlgos' with: [
				spec
					className: #ConfigurationOfMooseAlgos;
					versionString: #'bleedingEdge';
					loads: #('Moose-Algos-Graph' );
					repository: 'http://smalltalkhub.com/mc/Moose/MooseAlgos/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/STON/main/' ];
			project: 'VoyageMongo' with: [
				spec
					className: #ConfigurationOfVoyageMongo;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'bleedingEdge';
					loads: #('REST' );
					repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/' ].
		spec 
			package: #CargoPackageManager with: [
				spec requires: #(#'CargoPackageManager-Minimal' 'ZincHTTPComponents' 'MooseAlgos' ). ];
			package: #'CargoPackageManager-Minimal' with: [
				spec requires: #('Ston' ). ];
			package: #'CargoPackageManager-Repository' with: [
				spec requires: #(#CargoPackageManager #'CargoPackageManager-RepositoryBackend' #'CargoPackageManager-TestRessources' 'ZincHTTPComponents' ). ];
			package: #'CargoPackageManager-RepositoryBackend' with: [
				spec requires: #(#CargoPackageManager #'CargoPackageManager-TestRessources' 'VoyageMongo' ). ];
			package: #'CargoPackageManager-Spec';
			package: #'CargoPackageManager-TestRessources' with: [
				spec requires: #(#CargoPackageManager #'CargoPackageManager-Spec' 'BabyMock2' ). ];
			package: #'CargoPackageManager-Tests' with: [
				spec requires: #(#CargoPackageManager #'CargoPackageManager-RepositoryBackend' #'CargoPackageManager-TestRessources' 'Ston' ). ];
			package: #'CargoPackageManager-Tests-FooResource';
			package: #'CargoPackageManager-UI' with: [
				spec requires: #(#CargoPackageManager ). ];
			package: 'CargoPackageManager-Utils' with: [
				spec requires: #('DependencyAnalyser' ). ];
			package: #'CargoPackageManager-Utils-Tests' with: [
				spec requires: #(#'CargoPackageManager-Tests-FooResource' ). ].
		spec 
			group: 'client' with: #(#CargoPackageManager );
			group: 'server' with: #(#'CargoPackageManager-RepositoryBackend' #'CargoPackageManager-Repository' );
			group: 'tests' with: #('CargoPackageManager-Tests' 'utils' #'CargoPackageManager-Utils-Tests' );
			group: 'utils' with: #('CargoPackageManager-Utils' 'client' ). ].

]

{ #category : #accessing }
ConfigurationOfCargo >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #'symbolic versions' }
ConfigurationOfCargo >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.3-baseline'.

]

{ #category : #accessing }
ConfigurationOfCargo >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfCargo >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.1'.

]

{ #category : #versions }
ConfigurationOfCargo >> version01: spec [
	<version: '0.1' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1 : early version for beta-testing'.
		spec author: 'ChristopheDemarey'.
		spec timestamp: '4/27/2015 15:51'.
		spec 
			project: 'BabyMock2' with: '2.0';
			project: 'Ston' with: '0.9';
			project: 'VoyageMongo' with: '1.3.1';
			project: 'ZincHTTPComponents' with: '2.5.5';
			project: 'MooseAlgos' with: '2.5-baseline'.
		spec 
			package: #PackageManager with: 'PackageManager-ChristopheDemarey.130';
			package: #'PackageManager-Spec' with: 'PackageManager-Spec-ChristopheDemarey.7';
			package: #'PackageManager-TestRessources' with: 'PackageManager-TestRessources-ChristopheDemarey.15';
			package: #'PackageManager-RepositoryBackend' with: 'PackageManager-RepositoryBackend-ChristopheDemarey.30';
			package: #'PackageManager-Tests' with: 'PackageManager-Tests-ChristopheDemarey.10';
			package: #'PackageManager-Repository' with: 'PackageManager-Repository-ChristopheDemarey.3'. ].

]
