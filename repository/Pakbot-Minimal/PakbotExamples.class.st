"
I present some usage examples of Pakbot command-line API to load projects.
"
Class {
	#name : #PakbotExamples,
	#superclass : #Object,
	#category : #'Pakbot-Minimal'
}

{ #category : #'load instructions' }
PakbotExamples >> getAProjectLoadInstructionsFromPharoCatalog [

	Pakbot new
		project: 'Unicode';
		version: '1.1.0';
		loadInstructions
]

{ #category : #loading }
PakbotExamples >> loadAProjectBranchFromItsGitRepository [
	"load Unicode master branch from the specified git repository"
	
	Pakbot new
		repository: 'https://github.com/pharo-contributions/pharo-unicode.git';
		version: 'master';
		load.

]

{ #category : #loading }
PakbotExamples >> loadAProjectFromItsGitRepository [
	"load Unicode default branch from the specified git repository"

	Pakbot new
		repository: 'https://github.com/pharo-contributions/pharo-unicode.git';
		load. 
]

{ #category : #loading }
PakbotExamples >> loadAProjectFromPharoCatalog [
	"load Unicode 1.0 from package repository"

	Pakbot new
		project: 'Unicode';
		version: '1.1.0';
		load. 
]

{ #category : #loading }
PakbotExamples >> loadAProjectGroupFromPharoCatalog [
	"load Unicode 1.1.0 'Collate' group from package repository"

	Pakbot new
		project: 'Unicode';
		version: '1.1.0';
		load: 'Collate'. 
]

{ #category : #loading }
PakbotExamples >> loadAProjectPackageFromPharoCatalog [
	"load Unicode 1.1.0 'Unicode-Character-Data' package from package repository"
	
	Pakbot new
		project: 'Unicode';
		version: '1.1.0';
		load: 'Unicode-Character-Data'. 
]
