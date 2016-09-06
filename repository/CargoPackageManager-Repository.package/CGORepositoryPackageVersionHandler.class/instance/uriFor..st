private
uriFor: aPackageVersion
	^ '/' , self class pattern first , '/' , aPackageVersion packageName , '/' , aPackageVersion version asString