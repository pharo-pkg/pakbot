Class {
	#name : #PBPakbotDependencyPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'form'
	],
	#category : #'CargoPackageManager-UI-NewDependency'
}

{ #category : #specs }
PBPakbotDependencyPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: #form
]

{ #category : #building }
PBPakbotDependencyPanel >> buildDependency [
	^ PBPakbotProjectDependency
		named: (form valueNamed: #projectName)
		repositoryUrl: (form valueNamed: #projectRepository)
		version: (form valueNamed: #projectVersion)
]

{ #category : #accessing }
PBPakbotDependencyPanel >> form [
	^ form
]

{ #category : #accessing }
PBPakbotDependencyPanel >> icon [
	^ self iconNamed: #glamorousBookmark
]

{ #category : #initialization }
PBPakbotDependencyPanel >> initializeWidgets [
	
	form := ITForm owner:self.
	form 
		addTextField: #projectName label: 'Name' ghost: 'e.g., My Project' 
			with: [:field | field beRequired ];
		addTextField: #projectVersion label: 'Version' ghost: 'e.g., 1.0.1'
			with: [:field | field beRequired ];
		addTextField: #projectRepository label: 'Repository' ghost: 'e.g., github://project-owner/project';
		validateOnChange;
		whenChangedDo: [ self valueChanged ]

			

	
]

{ #category : #validation }
PBPakbotDependencyPanel >> isValid [
	^ form isValid
]

{ #category : #accessing }
PBPakbotDependencyPanel >> title [
	^ 'Pakbot Project'
]
