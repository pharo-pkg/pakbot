"
Abstract class showing a list of packages and allowing to add/remove/edit elements from the list
"
Class {
	#name : #CGOPackageListEditor,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'label',
		'addButton',
		'editButton',
		'removeButton',
		'packageList'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #'private - displaying' }
CGOPackageListEditor >> assemblyIcon [
	^ self iconNamed: #groupIcon
]

{ #category : #initialization }
CGOPackageListEditor >> connectPresenters [
	super connectPresenters.
	packageList whenSelectionChangedDo: [ :selection | | enabled |
		enabled := selection isEmpty not.
		removeButton enabled: enabled.
		editButton enabled: enabled. ].
	addButton action: [ self addAction ].
	removeButton
		action: [ self removeAction: self selectedPackage.
			self refreshUI ].
	editButton action: [ self editAction ]
]

{ #category : #layout }
CGOPackageListEditor >> defaultLayout [
	^ SpBoxLayout newTopToBottom 
		add: (SpBoxLayout newLeftToRight 
				add: label;
				addLast: addButton expand: false;
				addLast: editButton expand: false;
				addLast: removeButton expand: false;
				yourself)
			expand: false;
		add: #packageList;
		yourself
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> displayFor: aDependency [

	^ aDependency displayString asMorph
		setBalloonText: aDependency balloonText;
		yourself
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> iconForPackage: aDependency [

	^ self iconNamed: aDependency statusIconName.

]

{ #category : #initialization }
CGOPackageListEditor >> initializePresenters [
	(label := self newLabel) label: self packageListEditorLabel.
	addButton := self newButton
		icon: (self iconNamed: #addIcon);
		enabled: true;
		help: self addButtonHelpString.
	editButton := self newButton
		icon: (self iconNamed: #editIcon);
		enabled: false;
		help: self editButtonHelpString.
	removeButton := self newButton
		icon: (self iconNamed: #removeIcon);
		enabled: false;
		help: self removeButtonHelpString.
	packageList := self newTable.
	self initializeTable.
	self layout: self defaultLayout.

]

{ #category : #initialization }
CGOPackageListEditor >> initializeTable [

	packageList 
		items: self roots;
		addColumn: (SpCompositeTableColumn new
			title: 'Name';
			addColumn: (SpImageTableColumn evaluated: [ :each | self iconForPackage: each ]);
			addColumn: (SpStringTableColumn evaluated: [ :each | self displayFor: each ])).
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> morphIconFor: aPart [

	^ (self iconForPackage: aPart) asMorph
		 setBalloonText: aPart balloonText
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> notInstalledIcon [
	
	^ self iconNamed: #error
]

{ #category : #accessing }
CGOPackageListEditor >> packageVersion [
	^ self model
]

{ #category : #accessing }
CGOPackageListEditor >> roots [
	self subclassResponsibility 
]

{ #category : #accessing }
CGOPackageListEditor >> selectedPackage [
	^ packageList selectedItem
]

{ #category : #'private - displaying' }
CGOPackageListEditor >> virtualPackageIcon [
	^ self iconNamed: #image
]
