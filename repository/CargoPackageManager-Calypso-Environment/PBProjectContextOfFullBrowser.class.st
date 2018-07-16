Class {
	#name : #PBProjectContextOfFullBrowser,
	#superclass : #ClyFullBrowserContext,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #'selection strategy' }
PBProjectContextOfFullBrowser class >> selectionStrategy [
	<classAnnotation>
	
	^ClyContextSelectionStrategy for: ClyFullBrowser selectionType: PBProjectBrowserItem
]

{ #category : #'selection-projects' }
PBProjectContextOfFullBrowser >> selectedProjectItems [

	^selectedItems collect: [ :each | each rootParentItem ]
]
