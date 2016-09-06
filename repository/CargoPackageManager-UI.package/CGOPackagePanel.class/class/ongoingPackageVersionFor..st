private
ongoingPackageVersionFor: selectedPackage
	| manifest ongoing |
	manifest := selectedPackage packageManifest.
	ongoing := CGOOngoingPackageUnit on: manifest.
	(manifest class selectors includes: #packageName)
		ifFalse: [ ongoing updatePackageName: selectedPackage name ].
	^ ongoing