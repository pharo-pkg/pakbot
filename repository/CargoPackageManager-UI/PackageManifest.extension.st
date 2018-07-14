Extension { #name : #PackageManifest }

{ #category : #'*CargoPackageManager-UI' }
PackageManifest class >> gtInspectorDependenciesIn: composite [
	<gtInspectorPresentationOrder: 35>  
	 composite table
		title: 'Dependencies';
		display: [ self dependencies ];
		column: 'Package' evaluated: #name;
		column: 'Constraints' evaluated: #value;
		act: [ :presentation |
			(CGOOngoingPackageUnit on: self) addNewDependency: presentation.
			presentation update ]
		icon: Smalltalk ui icons addIcon
		entitled: 'Add a new dependency';
		
		act: [ :presentation :manifest | 
			presentation rawSelection ifNotNil: [ :selection|
				(CGOOngoingPackageUnit on: self) 
					removeDependency: selection key.
				presentation update ] ]
		icon: Smalltalk ui icons removeIcon
		entitled: 'Remove';
		
		act: [ :presentation :manifest | 
			presentation rawSelection ifNotNil: [ :selection|
				(CGOOngoingPackageUnit on: self) 
					updateDependencyConstraints: selection ].
			presentation update ]
		icon: Smalltalk ui icons editIcon
		entitled: 'Edit dependency';		
		noSelection
]

{ #category : #'*CargoPackageManager-UI' }
PackageManifest class >> gtInspectorDescriptionIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'Description';
		display: [ self description ];
		act: [ :presentation :manifest | 
			(CGOOngoingPackageUnit on: self) 
				updateDescription: presentation text asString printString ]
		icon: GLMUIThemeExtraIcons glamorousSave
		on: $s
		entitled: 'Save'
]

{ #category : #'*CargoPackageManager-UI' }
PackageManifest class >> gtInspectorVersionIn: composite [
	<gtInspectorPresentationOrder: 40>
	(composite custom: CGOVersionBrowser new)
		act: [ :presentation :manifest | 
					(CGOOngoingPackageUnit on: self) updateVersion.
					presentation
						entity: PackageManifest new;
						entity: manifest	"Hack to force Glamour to refresh the pane even if the entity has the same id" ]
			icon: Smalltalk ui icons editIcon
			entitled: 'Edit version';
		act: [ :presentation :manifest | 
				(CGOOngoingPackageUnit on: self) publishNewPackageVersion ]
			icon: GLMUIThemeExtraIcons glamorousSaveToUrl
			entitled: 'Publish a new package version';
		yourself
]
