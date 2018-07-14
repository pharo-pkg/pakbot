Extension { #name : #CGOOngoingPackage }

{ #category : #'*CargoPackageManager-Calypso-Environment' }
CGOOngoingPackage class >> convertToCalypsoBrowserItem: aPackage [ 
	^ClyBrowserItem named: aPackage packageName with: aPackage
]

{ #category : #'*CargoPackageManager-Calypso-Environment' }
CGOOngoingPackage >> managedByCalypsoUsing: aPackageManager [
	^aPackageManager packageOf: self
]
