tests - saving
testSavePackageVersionCanSaveCargoProject
	| project |

	project := CGOOngoingProject example asCargoProject.

	emptyRepository savePackageVersion: project.
	
	self assert: (emptyRepository rootDirectory / project packageName asLowercase / project name asLowercase) isFile.