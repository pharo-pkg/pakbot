Class {
	#name : #PBMetacelloBaselineDependencyPanel,
	#superclass : #PBAbstractDependencyPanel,
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #building }
PBMetacelloBaselineDependencyPanel >> buildDependency [

	^ PBMetacelloBaselineProjectDependency
		name: (form valueNamed: #name)
		repositoryUrl: (form valueNamed: #repositoryUrl)
		version: (form valueNamed: #version)	
]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> icon [

	^ self iconNamed: PBMetacelloBaselineProjectDependency iconName
]

{ #category : #initialization }
PBMetacelloBaselineDependencyPanel >> initializeForm [
	form := ITForm owner: self.
	form
		addTextField: #name
			label: 'Baseline of'
			ghost: 'e.g., My Project'
			with: [ :field | field beRequired ];

		addTextField: #repositoryUrl label: 'Repository' ghost: 'e.g., github://project-owner/project';

		addTextField: #version
			label: 'Version'
			ghost: 'e.g., 1.0.1'
			with: [ :field | field beRequired ];

		addTextField: #srcDirectory
			label: 'Source directory'
			ghost: 'e.g., src';

		addTextField: #group
			label: 'Group'
			ghost: 'e.g., development';
			
		validateOnChange;
		whenChangedDo: [ self valueChanged ].
		
]

{ #category : #initialization }
PBMetacelloBaselineDependencyPanel >> setInitialValues [

	form valueNamed: #name set: self dependency name.
	form valueNamed: #repositoryUrl set: self dependency repositoryUrl.
	form valueNamed: #version set: self dependency version asString

]

{ #category : #accessing }
PBMetacelloBaselineDependencyPanel >> title [

	^ 'Metacello Baseline'
]

{ #category : #building }
PBMetacelloBaselineDependencyPanel >> updateDependency [
	
	self dependency
		setName: (form valueNamed: #name)
		repositoryUrl: (form valueNamed: #repositoryUrl)
		version: (form valueNamed: #version)	
]
