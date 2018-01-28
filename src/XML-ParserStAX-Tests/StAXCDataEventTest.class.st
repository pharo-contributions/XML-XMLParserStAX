Class {
	#name : #StAXCDataEventTest,
	#superclass : #StAXStringEventTest,
	#category : #'XML-ParserStAX-Tests'
}

{ #category : #accessing }
StAXCDataEventTest >> eventClass [
	^ StAXCDataEvent
]

{ #category : #tests }
StAXCDataEventTest >> testIsCData [
	self assert: self newEvent isCData
]
