Class {
	#name : #StAXEndDocumentEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests'
}

{ #category : #accessing }
StAXEndDocumentEventTest >> eventClass [
	^ StAXEndDocumentEvent
]

{ #category : #tests }
StAXEndDocumentEventTest >> testIsEndDocument [
	self assert: self newEvent isEndDocument
]
