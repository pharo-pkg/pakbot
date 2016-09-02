versions fetching
packagesProviding: aName version: aSemanticVersion for: platformAttributes
	self shouldBeImplemented
	"^ (self packagesProviding: aName for: platformAttributes)
		select: [ :pkgVersion | pkgVersion version = aSemanticVersion ]"