private
withRepositoryDo: aBlock
	repository 
		ifNil: [ CGOGitRepositoryCreationPanel withNewRepositoryDo: aBlock ]
		ifNotNil: [ aBlock value: repository ]