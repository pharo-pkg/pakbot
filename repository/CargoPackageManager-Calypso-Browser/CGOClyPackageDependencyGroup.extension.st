Extension { #name : #CGOClyPackageDependencyGroup }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
CGOClyPackageDependencyGroup >> decorateTableCell: anItemCellMorph of: groupItem [
	super decorateTableCell: anItemCellMorph of: groupItem.
			
	anItemCellMorph definitionIcon: #glamorousBookmark
]
