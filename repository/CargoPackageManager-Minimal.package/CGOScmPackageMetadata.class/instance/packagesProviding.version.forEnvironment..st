versions fetching
packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes
	"We ignore virtual package version as we load from SCM, eveything should be in sync."
	"We also ignore platformAttributes as a virtual package has no platform attribute"
	| virtualPkgVersion |
	virtualPkgVersion := (CGOPackageVersionReference packageName: aName version: aSemanticVersion).
	^ self packageVersions 
		select: [ :each | 
			each isUnit
			and: [ (each provisions includes: virtualPkgVersion) 
			and: [ CGOPackageRepository new does: each fitPlatformRequirements: platformAttributes ] ] ]