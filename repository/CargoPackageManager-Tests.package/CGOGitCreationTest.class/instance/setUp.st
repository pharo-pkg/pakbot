running
setUp
	oldRemoteTypeSelector := Iceberg remoteTypeSelector.
	iceCredentialsProviderBackup := IceCredentialsProvider providerType.

	CGOGitHostedPackageVersionEnforcingProtocol useHttpsUrl.
	
	Iceberg remoteTypeSelector: #httpsUrl.
	
	"usable with pharo-counter project on GitHub"
	IceCredentialStore current
		storeCredential: (IcePlaintextCredentials new 
			username: 'cargo-test';
			password: 'cargo2017';
			host: 'github.com';
			yourself).
	
	IceCredentialsProvider providerType: IceNonInteractiveCredentialsProvider.