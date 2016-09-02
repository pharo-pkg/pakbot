Error raised when a dependency cannot be resolved because of conflicting requirements.
ex: 
	example requires foo, bar
	foo requires PackageA 1.0
	bar requires PackageA 2.0
	=> conflict for PackageA