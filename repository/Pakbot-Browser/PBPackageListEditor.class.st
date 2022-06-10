"
Abstract class showing a list of packages and allowing to add/remove/edit elements from the list
"
Class {
	#name : #PBPackageListEditor,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'addButton',
		'editButton',
		'removeButton',
		'packageList'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #accessing }
PBPackageListEditor >> addButtonHelpString [
	^ 'Add a new dependency'
]

{ #category : #'private - displaying' }
PBPackageListEditor >> assemblyIcon [
	^ self iconNamed: #groupIcon
]

{ #category : #initialization }
PBPackageListEditor >> connectPresenters [
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
PBPackageListEditor >> defaultLayout [
	^ SpBoxLayout newTopToBottom 
		add: (SpBoxLayout newLeftToRight 
				add: 'Dependencies:';
				addLast: addButton expand: false;
				addLast: editButton expand: false;
				addLast: removeButton expand: false;
				yourself)
			expand: false;
		add: #packageList;
		yourself
]

{ #category : #accessing }
PBPackageListEditor >> editButtonHelpString [
	^ 'Edit the dependency'
]

{ #category : #'private - displaying' }
PBPackageListEditor >> iconForPackage: aDependency [

	^ self iconNamed: aDependency statusIconName.

]

{ #category : #initialization }
PBPackageListEditor >> initializePresenters [
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

]

{ #category : #initialization }
PBPackageListEditor >> initializeTable [

	packageList 
		items: self roots;
		addColumn: (SpCompositeTableColumn new
			title: 'Name';
			addColumn: (SpImageTableColumn evaluated: [ :each | self iconForPackage: each ]);
			addColumn: (SpStringTableColumn evaluated: [ :each | each displayString ])).
]

{ #category : #initialization }
PBPackageListEditor >> modelChanged [ 
	packageList items: self roots
]

{ #category : #'private - displaying' }
PBPackageListEditor >> morphIconFor: aPart [

	^ (self iconForPackage: aPart) asMorph
		 setBalloonText: aPart balloonText
]

{ #category : #'private - displaying' }
PBPackageListEditor >> notInstalledIcon [
	
	^ self iconNamed: #error
]

{ #category : #accessing }
PBPackageListEditor >> packageVersion [
	^ self model
]

{ #category : #accessing }
PBPackageListEditor >> removeButtonHelpString [
	^ 'Remove the dependency'
]

{ #category : #accessing }
PBPackageListEditor >> roots [
	self subclassResponsibility 
]

{ #category : #accessing }
PBPackageListEditor >> selectedPackage [
	^ packageList selectedItem
]

{ #category : #'private - displaying' }
PBPackageListEditor >> virtualPackageIcon [
	^ self iconNamed: #image
]
