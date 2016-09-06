versions posting
savePackageVersion: aPackageVersion
	[ self fetch: aPackageVersion packageName version: aPackageVersion version.
	CGOPackageVersionAlreadyExistsError signal: aPackageVersion asString , ' already defined' ]
		on: CGOPackageNotFoundError, CGOPackageVersionNotFoundError
		do: [ packages := packages copyWith: aPackageVersion ]