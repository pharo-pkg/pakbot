template
startupScript
	| repository |
	
	ZnServer defaultOn: 8080.
	"ZnServer default logToStandardOutput."
	repository := CGOMongoRepository newWithDbName: 'package-repository'.
	ZnServer default delegate: (CGORepositoryRestServerDelegate newWith: repository).
