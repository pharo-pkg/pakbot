Extension { #name : #CGOClyVirtualPackage }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
CGOClyVirtualPackage >> decorateTableCell: anItemCellMorph of: groupItem [
	super decorateTableCell: anItemCellMorph of: groupItem.
			
	anItemCellMorph definitionIcon: #image
]
