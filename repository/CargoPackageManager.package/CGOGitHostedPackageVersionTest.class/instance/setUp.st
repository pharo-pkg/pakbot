initialization
setUp
	"need to use libgit for HTPPS urls"
	"note: by using libgit, HTTPS will be used evan if the url is a SCP url like git@..."
	IceRepository defaultBackendType: IceLibgitLocalRepository.