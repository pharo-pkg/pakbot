Class {
	#name : #PBPakbotDependencyPanel,
	#superclass : #PBAbstractDependencyPanel,
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #building }
PBPakbotDependencyPanel >> buildDependency [
	^ PBPakbotProjectDependency
		named: (form valueNamed: #projectName)
		repositoryUrl: (form valueNamed: #projectRepository)
		version: (form valueNamed: #projectVersion)
]

{ #category : #accessing }
PBPakbotDependencyPanel >> icon [
	^ self iconNamed: #glamorousBookmark
]

{ #category : #initialization }
PBPakbotDependencyPanel >> initializeForm [
	form := ITForm owner: self.
	form
		addTextField: #projectName
			label: 'Name'
			ghost: 'e.g., My Project'
			with: [ :field | field beRequired ];

		addTextField: #projectVersion
			label: 'Version'
			ghost: 'e.g., 1.0.1'
			with: [ :field | field beRequired ];

		addTextField: #projectRepository label: 'Repository' ghost: 'e.g., github://project-owner/project';
		validateOnChange;
		whenChangedDo: [ self valueChanged ].
		
	self setInitialValues.
]

{ #category : #initialization }
PBPakbotDependencyPanel >> setInitialValues [

	dependency ifNil: [ ^ self ].
	form valueNamed: #projectName set: dependency name.
	form valueNamed: #projectRepository set: dependency repositoryUrl.
	form valueNamed: #projectVersion set: dependency	version asString

]

{ #category : #accessing }
PBPakbotDependencyPanel >> title [
	^ 'Pakbot Project'
]

{ #category : #building }
PBPakbotDependencyPanel >> updateDependency [

	dependency
		name: (form valueNamed: #projectName);
		repositoryUrl: (form valueNamed: #projectRepository);
		version: (form valueNamed: #projectVersion)
]
