initialization
setUp
	"need to use libgit for HTPPS urls"
	"note: by using libgit, HTTPS will be used evan if the url is a SCP url like git@..."
	IceRepository defaultBackend: IceLibgitLocalRepository.
	CGOGitHostedPackageVersionEnforcingProtocol useHttpsUrl.
	
	iceCredentialsProviderBackup := IceCredentialsProvider providerType.
	IceCredentialsProvider plaintextCredentials: 
		(IcePlaintextCredentials new
			username: 'cargo-test'; 
			password: 'cargo2017').
	IceCredentialsProvider providerType: IceCredentialsProvider.