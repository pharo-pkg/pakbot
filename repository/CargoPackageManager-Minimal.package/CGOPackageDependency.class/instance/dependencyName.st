accessing
dependencyName
	"Name used to find the depencency in a package repository"
	^ scope
		ifNil: [ targetedPackage ]
		ifNotNil: [ scope , self class scopeSeparator , targetedPackage ]