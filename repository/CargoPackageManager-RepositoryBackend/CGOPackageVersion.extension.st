Extension { #name : #CGOPackageVersion }

{ #category : #'*CargoPackageManager-RepositoryBackend' }
CGOPackageVersion class >> isVoyageRoot [
	^ true
]

{ #category : #'*CargoPackageManager-RepositoryBackend' }
CGOPackageVersion class >> mongoVersion [
	<mongoDescription>
	^ VOToOneDescription new
		attributeName: 'version';
		accessor: (MAPluggableAccessor
			read: [ :pkgVersion | pkgVersion version asString ]
			write: [ :pkgVersion :value | 
					pkgVersion 
						instVarNamed: 'version'
						put:  (SemanticVersion fromString: value)] );
		yourself
]

{ #category : #'*CargoPackageManager-RepositoryBackend' }
CGOPackageVersion class >> voyageCollectionName [
	^ 'PackageVersion'
]
