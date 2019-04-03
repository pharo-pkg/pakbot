Class {
	#name : #PBImportProjectFromPackageRepository,
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
PBImportProjectFromPackageRepository class >> defaultSpec [
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
PBImportProjectFromPackageRepository >> accept [
	| project selection |
	
	selection := self selectedPackage.
	selection ifNil: [ ^ nil ].
	
	project := packageRepository fetch: selection "name" version: '1.8.1'"selection version".
	project registry: PBPackageRegistry default.
	
	(PBLoadProjectDialog onProject: project) openDialogWithSpec.
	^ project
]

{ #category : #'data source' }
PBImportProjectFromPackageRepository >> buildRoots [
	^ packageRepository packages
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> icon [

	^ self iconNamed: #git
]

{ #category : #initialization }
PBImportProjectFromPackageRepository >> initialize [
	packageRepository := PBPackageRepository newLocalRepositoryIn: FileLocator home / 'dev/rmod/test-pkg-repo'.
	super initialize.

]

{ #category : #initialization }
PBImportProjectFromPackageRepository >> initializeSpacePanel [
	"just to gain space"
	spacePanel := self newPanel. 
]

{ #category : #initialization }
PBImportProjectFromPackageRepository >> initializeWidgets [

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
PBImportProjectFromPackageRepository >> newDataSource [
	
	^ FTEasyListDataSource new 
		elements: self buildRoots;
		"display: [ :each | self displayFor: each ];
		icon: [ :each | self morphIconFor: each ];"
		yourself
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> packageLabel [
	^ packageLabel
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> packageTree [
	^ packageTree
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> repositoryUrlInputText [
	^ repositoryUrlInputText
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> repositoryUrlLabel [
	^ repositoryUrlLabel
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> selectedPackage [
	| selectedIndex |
	selectedIndex := packageTree widget selectedRowIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].
	
	^ packageTree widget dataSource elementAt: selectedIndex
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> spacePanel [
	^ spacePanel
]

{ #category : #accessing }
PBImportProjectFromPackageRepository >> title [

	^ 'Import from Repository'
]
