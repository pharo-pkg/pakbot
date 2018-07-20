Extension { #name : #PackageManifest }

{ #category : #'*CargoPackageManager' }
PackageManifest class >> asOngoingPackageVersion [
	^ CGOOngoingPackage on: self
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> dependencies [
	^ #()
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> description [
	^ self name , ' description'
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> file [
	^ nil
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> packageName [
	self shouldBeImplemented
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> packageNamed: aString [
	^ self subclasses detect: 
		[ :manifest | 
		[ manifest packageName = aString asSymbol ]
			on: ShouldBeImplemented
			do: [ false ] ]
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> platformRequirements [
	^ #()
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> provisions [
	"A package may provide a virtual package. A virtual package is one which appears in the provisions  of another package. The effect is as if the package(s) which provide a particular virtual package name had been listed by name everywhere the virtual package name appears. See https://www.debian.org/doc/debian-policy/ch-relationships.html#s-virtual"
	^ #()
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> repositories [
	^ #()
]

{ #category : #'*CargoPackageManager' }
PackageManifest class >> version [
	^ '0.1-dev'
]
