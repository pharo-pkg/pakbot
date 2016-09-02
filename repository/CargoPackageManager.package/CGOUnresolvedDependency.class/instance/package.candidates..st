signaling
package: aPackageName candidates: aPackageVersionReferenceList
	candidates := aPackageVersionReferenceList.
	^ self signal: 'Unresolved dependency: ' , aPackageName , ' has ' , aPackageVersionReferenceList size asString , ' candidates!'