initialization - private
repositoriesFrom: aDictionary
	^ aDictionary 
		at: #repositories 
		ifPresent: [ :aRepositoryList | 
						aRepositoryList collect: 
							[ :each | MCRepository fromUrl: each ] ]
		ifAbsent: #()
