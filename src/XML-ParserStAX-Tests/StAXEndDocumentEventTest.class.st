"
Unit tests for StAXEndDocumentEvent
"
Class {
	#name : #StAXEndDocumentEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests-Events'
}

{ #category : #accessing }
StAXEndDocumentEventTest >> eventClass [
	^ StAXEndDocumentEvent
]

{ #category : #tests }
StAXEndDocumentEventTest >> testIsEndDocument [
	self assert: self newEvent isEndDocument
]
