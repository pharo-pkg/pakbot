fetching
fetchFromCache
	"Search the package version description from the local cache"
	^ CGOPackageVersionCache new fetchDescription: self asString