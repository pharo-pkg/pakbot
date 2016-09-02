class initialization
initialize
	"initialize default repository if CGORemoteRepositoryProxy is loaded"
	self defaultPackageRepository: 
		(Smalltalk globals 
			at: #CGORemoteRepositoryProxy
			ifPresent: [ :repositoryClass | repositoryClass newWithUrl: self defaultPackageRepositoryUrl ])