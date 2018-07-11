private
computeName
	name := ', ' join: (packageVersions collect: #name)