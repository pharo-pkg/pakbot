opening
browsePackageMetadata: aBuilder
	<contextMenu>
	<nautilusGlobalPackageMenu>
	| selectedPackage |
	selectedPackage := aBuilder model selectedPackage package.
	selectedPackage ifNil: [ ^ self ].
	(aBuilder item: #'Browse package metadata ...')
		action: [ self openOn: selectedPackage ];
		order: 1000