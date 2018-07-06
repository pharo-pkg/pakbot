running
tearDown
	IceCredentialsProvider providerType: iceCredentialsProviderBackup.
	Iceberg remoteTypeSelector: oldRemoteTypeSelector.

	repository ifNotNil: [ repository iceRepository ifNotNil: #delete ].