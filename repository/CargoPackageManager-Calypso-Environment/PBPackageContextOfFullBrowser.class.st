Class {
	#name : #PBPackageContextOfFullBrowser,
	#superclass : #ClyProjectContextOfFullBrowser,
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #'selection strategy' }
PBPackageContextOfFullBrowser class >> selectionStrategy [
	<classAnnotation>
	
	^ClyContextSelectionStrategy for: ClyFullBrowser selectionType: PBPackageUIItem
]

{ #category : #'selection-packages' }
PBPackageContextOfFullBrowser >> isPackageSelected [

	^ selectedItems isEmpty not
]

{ #category : #'selection-packages' }
PBPackageContextOfFullBrowser >> lastSelectedPackage [

	^ selectedItems first actualObject
]
