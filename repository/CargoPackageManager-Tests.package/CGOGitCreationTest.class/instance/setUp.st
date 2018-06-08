running
setUp
	CGOGitHostedPackageVersionEnforcingProtocol useHttpsUrl.

	iceCredentialsProviderBackup := IceCredentialsProvider providerType.
	"usable with pharo-counter project on GitHub"
	IceCredentialsProvider plaintextCredentials: 
		(IcePlaintextCredentials new
			username: 'cargo-test'; 
			password: 'cargo2017').
	IceCredentialsProvider providerType: IceNonInteractiveCredentialsProvider.