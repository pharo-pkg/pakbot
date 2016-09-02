private
computeName
	name := ', ' join: (packageVersions collect: #packageName)