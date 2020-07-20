Class {
	#name : #PBImportProjectFromPackageRepositoryPanel,
	#superclass : #ITOptionPanel,
	#instVars : [
		'repositoryUrlLabel',
		'repositoryUrlInputText',
		'spacePanel',
		'packageLabel',
		'packageTree',
		'packageRepository'
	],
	#category : #'CargoPackageManager-UI-NewProject'
}

{ #category : #specs }
PBImportProjectFromPackageRepositoryPanel class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed 
		newColumn: [ :col | 
			col
				newRow: [ :row | 
						row
							add: #repositoryUrlLabel width: self formLabelWidth;
							add: #repositoryUrlInputText ]
					height: self inputTextHeight;
				add: #packageLabel;
				add: #packageTree;
				newRow: #spacePanel ]
]

{ #category : #action }
PBImportProjectFromPackageRepositoryPanel >> accept [
	| project selection |
	
	selection := self selectedPackage.
	selection ifNil: [ ^ nil ].
	
	project := packageRepository fetch: selection "name" version: '1.8.1'"selection version".
	project registry: PBPackageRegistry default.
	
	(PBLoadProjectDialog onProject: project) openDialogWithSpec.
	^ project
]

{ #category : #'data source' }
PBImportProjectFromPackageRepositoryPanel >> buildRoots [
	^ packageRepository packages
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> icon [

	^ self iconNamed: #git
]

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPanel >> initialize [
	packageRepository := PBPackageRepository newLocalRepositoryIn: FileLocator home / 'dev/rmod/test-pkg-repo'.
	super initialize.

]

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPanel >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBImportProjectFromPackageRepositoryPanel >> initializeWidgets [

	self initializeSpacePanel.

	repositoryUrlLabel := self newLabel label: 'Package Repository Url'.
	repositoryUrlInputText := self newTextInput 
		ghostText: 'e.g., git@github.com:pharo-pkg/project-repository';
		autoAccept: true.
		
	packageLabel := self newLabel label: 'Packages'.
	packageTree := self newFastTable.
	packageTree widget dataSource: self newDataSource.
]

{ #category : #'data source' }
PBImportProjectFromPackageRepositoryPanel >> newDataSource [
	
	^ FTEasyListDataSource new 
		elements: self buildRoots;
		"display: [ :each | self displayFor: each ];
		icon: [ :each | self morphIconFor: each ];"
		yourself
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> packageLabel [
	^ packageLabel
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> packageTree [
	^ packageTree
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> selectedPackage [
	| selectedIndex |
	selectedIndex := packageTree widget selectedIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].
	^ packageTree widget dataSource elementAt: selectedIndex
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
PBImportProjectFromPackageRepositoryPanel >> title [

	^ 'Import from Repository'
]
