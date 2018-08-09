Class {
	#name : #PBMetacelloConfigurationDependencyPanel,
	#superclass : #PBAbstractDependencyPanel,
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #building }
PBMetacelloConfigurationDependencyPanel >> buildDependency [

	^ PBMetacelloConfigurationProjectDependency
		name: (form valueNamed: #name)
		repositoryUrl: (form valueNamed: #repositoryUrl)
		version: (form valueNamed: #version)
]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> icon [
	
	^ self iconNamed: PBMetacelloConfigurationProjectDependency iconName
]

{ #category : #initialization }
PBMetacelloConfigurationDependencyPanel >> initializeForm [
	form := ITForm owner: self.
	form
		addTextField: #name
			label: 'Name'
			ghost: 'e.g., My Project'
			with: [ :field | field beRequired ];

		addTextField: #repositoryUrl label: 'Repository' ghost: 'e.g., github://project-owner/project';

		addTextField: #version
			label: 'Version'
			ghost: 'e.g., 1.0.1'
			with: [ :field | field beRequired ];

		addTextField: #group
			label: 'Group'
			ghost: 'e.g., development';
			
		validateOnChange;
		whenChangedDo: [ self valueChanged ].
		
]

{ #category : #initialization }
PBMetacelloConfigurationDependencyPanel >> setInitialValues [

	form valueNamed: #name set: dependency name.
	form valueNamed: #repositoryUrl set: dependency repositoryUrl.
	form valueNamed: #version set: dependency version asString

]

{ #category : #accessing }
PBMetacelloConfigurationDependencyPanel >> title [

	^ 'Metacello Configuration'
]

{ #category : #building }
PBMetacelloConfigurationDependencyPanel >> updateDependency [

	dependency
		setName: (form valueNamed: #name)
		repositoryUrl: (form valueNamed: #repositoryUrl)
		version: (form valueNamed: #version)
]
