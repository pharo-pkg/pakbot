private
fetchFromDb: aSymbol
	^ CGOPackage selectOne: [ :each | each name = aSymbol ]