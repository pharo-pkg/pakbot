"
I define the configuration for Pakbot Browser.
For now, I only define new styles.
"
Class {
	#name : #PakbotBrowserConfiguration,
	#superclass : #SpMorphicConfiguration,
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #styling }
PakbotBrowserConfiguration >> customStyleSheet [
	^ (SpStyleVariableSTONReader fromString: '.application [       
 	   .textInputField [ 
			.readonly [ Draw { #color: #transparent } ] ],
 	   .text [ 
			.readonly [ Draw { #color: #transparent } ] ]
		]
	')
]

{ #category : #'instance creation' }
PakbotBrowserConfiguration >> newStyleSheet [

	^ SpStyle defaultStyleSheet copy, self customStyleSheet
]
