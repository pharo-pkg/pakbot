accessing
ongoingPackageUnitOf: aPackageName
	| manifest ongoing |
	manifest := self manifestOf: aPackageName.
	ongoing := CGOOngoingPackageUnit on: manifest.
	(manifest class selectors includes: #packageName)
		ifFalse: [ ongoing updatePackageName: aPackageName ].
	^ ongoing
