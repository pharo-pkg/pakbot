setting
addAllRepositories: aListOfRepositoryUrl
	"add a repository to load packages from. Will take precedence on the repository defined in the packageVersion"
	self repositories addAll: aListOfRepositoryUrl