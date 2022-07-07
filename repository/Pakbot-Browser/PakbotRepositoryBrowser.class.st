"
I'm the UI to browse the content of a Pakbot package repository.

I list projects as well as available versions.
"
Class {
	#name : #PakbotRepositoryBrowser,
	#superclass : #SpApplication,
	#instVars : [
		'packageRepository'
	],
	#category : #'Pakbot-Browser-Repository'
}

{ #category : #'instance creation' }
PakbotRepositoryBrowser class >> open [
	<script>
	
	self new start
]

{ #category : #accessing }
PakbotRepositoryBrowser >> packageRepository [
	
	^ packageRepository ifNil: [ PBPackageRepository default ]
]

{ #category : #starting }
PakbotRepositoryBrowser >> start [ 
	(PBPackageRepositoryPresenter on: self packageRepository)
		application: self;
		open
]
