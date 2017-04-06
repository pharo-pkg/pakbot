# Some useful code snippets related to Cargo

## Copy package versions from a repository to another
If you want to copy package versions present in a package repository to another package repository, this small script is for you. It can be used to move package versions from a file-based package repository to a mongo-based package repository.
```smalltalk
(srcRepo packageNames 
	flatCollect: [ :pkgName | 
		(srcRepo versionStringsOf: pkgName)
			collect: [ :pkgVersionString | | pkgVersion |
				pkgVersion := pkgVersionString asPackageVersionReference.
				srcRepo fetch: pkgVersion packageName version: pkgVersion versionNumber] ])
	do: [ :each | destRepo savePackageVersion: each ]
```
