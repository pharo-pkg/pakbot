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
	
	^ClyContextSelectionStrategy for: ClyFullBrowser selectionType: PBProjectUIItem 
]

{ #category : #'selection strategy' }
PBProjectContextOfFullBrowser class >> selectionStrategyForPackages [
	<classAnnotation>
	
	^ClyContextSelectionStrategy for: ClyFullBrowser selectionType: PBPackageUIItem 
]

{ #category : #'selection-projects' }
PBProjectContextOfFullBrowser >> selectedPackageItems [
	^ selectedItems select: [ :each | each isBasedOnItemType: CGOOngoingPackageUnit ]
]

{ #category : #'selection-projects' }
PBProjectContextOfFullBrowser >> selectedProjectItems [

	^selectedItems collect: [ :each | each rootParentItem ]
]
