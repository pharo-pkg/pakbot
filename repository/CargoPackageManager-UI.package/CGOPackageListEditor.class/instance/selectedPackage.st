accessing
selectedPackage
	| selectedIndex |
	selectedIndex := packageTree widget selectedRowIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].
	
	^ packageTree widget dataSource elementAt: selectedIndex