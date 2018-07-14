"
I' m a simple browser with the same logic as the GTInspector.
I open myself onthe list of PackageManifest available in the image.

self open
"
Class {
	#name : #CGOPackageBrowser,
	#superclass : #GLMCompositePresentation,
	#category : 'CargoPackageManager-UI'
}

{ #category : #opening }
CGOPackageBrowser class >> open [
	<script>
	self openOn: (PackageManifest allSubclasses	 , AssemblyManifest allSubclasses)
]

{ #category : #building }
CGOPackageBrowser >> compose [
	self
		title: 'Package Browser';
		custom:
			(GTInspector new
				noTitle; 
				noActions;
				showFirst: [ :composite |
					self packageListIn: composite ];
				yourself)
]

{ #category : #constants }
CGOPackageBrowser >> manifestClassPrefix [
	^ 'Manifest'
]

{ #category : #actions }
CGOPackageBrowser >> newPackageAssembly [
	| name rpackage assemblyClass |
	name := UIManager default 
		request: 'Name of the package assembly to create'
		initialAnswer: ''.
	name ifNil: [ ^ nil ].
	rpackage := SearchFacade rPackageSearch
		acceptNewEntry: true;
		chooseFromOwner: World.
	rpackage ifNil: [ ^ nil ].
	rpackage isString ifTrue: 
		[ rpackage := RPackageOrganizer default registerPackageNamed: rpackage ].
	assemblyClass := AssemblyManifest 
		newNamed: (name select: #isAlphaNumeric), 'Assembly'
		category: rpackage name.
	assemblyClass asOngoingPackageVersion updatePackageName: name.
	^ assemblyClass
]

{ #category : #actions }
CGOPackageBrowser >> newPackageUnit [
	| package |
	package := SearchFacade rPackageSearch chooseFromOwner: World.
	^ package 
		ifNil: [ nil ]
		ifNotNil: [ | manifest |
				manifest := TheManifestBuilder new createManifestNamed: package name.
				(CGOOngoingPackageVersion on: manifest new)
					updatePackageName: package name.
				manifest  ]
]

{ #category : #actions }
CGOPackageBrowser >> newPackageVersion [
	| choice |
	choice := UIManager default 
		chooseFrom: #('Package Assembly' 'Package Unit')
		values: { #newPackageAssembly . #newPackageUnit }.
	choice 
		ifNotNil: [ (choice value: self)
			ifNotNil: [ :newPackageVersion |
				self entity: (self entity 
					add: newPackageVersion;
					yourself ) ] ]
]

{ #category : #building }
CGOPackageBrowser >> packageListIn: aPresentation [
	^ aPresentation tree
		title: 'Package Manifest List';
		icon: [ Smalltalk ui icons packageIcon ];
		display: [ :items | items sorted: [ :a :b | a name < b name ]  ];
		format: [ :item | | packageManifestName |
					packageManifestName := item name.
					(packageManifestName beginsWith: self manifestClassPrefix)
						ifTrue: [ packageManifestName 
										copyFrom: self manifestClassPrefix size + 1
										to: packageManifestName size ]
						ifFalse: [ packageManifestName ] ];
		act: [ :presentation :manifest | self newPackageVersion ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Create a new package version'
]
