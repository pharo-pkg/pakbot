loading
fetchInto: aMCRepository
	^ self mcVersions
		do: [ :version | aMCRepository storeVersion: version ];
		yourself