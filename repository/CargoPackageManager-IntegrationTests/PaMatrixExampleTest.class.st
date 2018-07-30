Class {
	#name : #PaMatrixExampleTest,
	#superclass : #PaAbstractExampleTest,
	#category : #'CargoPackageManager-IntegrationTests-ParametrizedTests'
}

{ #category : #private }
PaMatrixExampleTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelector: #option1 addOptions: #(a b c);
		forSelector: #option2 addOptions: {[1].[2].[3]};
		yourself.
]
