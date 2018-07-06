running
tearDown
	IceCredentialsProvider providerType: iceCredentialsProviderBackup.
	Iceberg remoteTypeSelector: oldRemoteTypeSelector.

	"I know this is awful, but the CGOGitRepository is using IceRepository and IceRepositoryCreator as polymorphic (shhhhh..... they are not!)"
	repository ifNotNil: [ repository iceRepository ifNotNil: [ :aRepositoryOrRepositoryCreator | (aRepositoryOrRepositoryCreator isKindOf: IceRepository) ifTrue: [ aRepositoryOrRepositoryCreator delete ] ] ].