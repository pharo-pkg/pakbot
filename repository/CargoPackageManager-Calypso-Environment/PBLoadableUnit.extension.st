Extension { #name : #PBLoadableUnit }

{ #category : #'*CargoPackageManager-Calypso-Environment' }
PBLoadableUnit class >> convertToCalypsoBrowserItem: aPackage [ 
	^ClyBrowserItem named: aPackage packageName with: aPackage
]

{ #category : #'*CargoPackageManager-Calypso-Environment' }
PBLoadableUnit >> managedByCalypsoUsing: aPackageManager [
	^aPackageManager packageOf: self
]
