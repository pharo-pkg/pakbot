private
ongoingPackageResolutionFor: aPackage
	^ ongoingPackageResolutions 
		at: aPackage
		ifAbsentPut: [ CGOOngoingPackageResolution new
						targetedPackage: aPackage;
						yourself ]