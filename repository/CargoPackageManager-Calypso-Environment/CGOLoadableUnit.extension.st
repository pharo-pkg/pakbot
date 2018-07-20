Extension { #name : #CGOLoadableUnit }

{ #category : #'*CargoPackageManager-Calypso-Environment' }
CGOLoadableUnit class >> convertToCalypsoBrowserItem: aPackage [ 
	^ClyBrowserItem named: aPackage packageName with: aPackage
]

{ #category : #'*CargoPackageManager-Calypso-Environment' }
CGOLoadableUnit >> managedByCalypsoUsing: aPackageManager [
	^aPackageManager packageOf: self
]
