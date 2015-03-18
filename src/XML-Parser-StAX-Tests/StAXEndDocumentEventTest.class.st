Class {
	#name : #StAXEndDocumentEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXEndDocumentEventTest >> eventClass [
	^ StAXEndDocumentEvent
]

{ #category : #tests }
StAXEndDocumentEventTest >> testIsEndDocument [
	self assert: self newEvent isEndDocument
]
