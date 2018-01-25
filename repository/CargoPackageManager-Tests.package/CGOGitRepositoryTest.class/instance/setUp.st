initialization
setUp
	IceRepository defaultBackend: IceLibgitLocalRepository.
	CGOGitHostedPackageVersionEnforcingProtocol useHttpsUrl.

	iceCredentialsProviderBackup := IceCredentialsProvider providerType.
	IceCredentialsProvider plaintextCredentials: 
		(IcePlaintextCredentials new
			username: 'cargo-test'; 
			password: 'cargo2017').
	IceCredentialsProvider providerType: IceCredentialsProvider.