instance creation
newWithFileName: aFileName
	"ensure we can handle relative pathes"
	^ self newWithUrl: aFileName asFileReference fullName