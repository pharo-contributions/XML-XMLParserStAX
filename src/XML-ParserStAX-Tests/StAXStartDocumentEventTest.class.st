"
Unit tests for StAXStartDocumentEvent
"
Class {
	#name : #StAXStartDocumentEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests-Events'
}

{ #category : #accessing }
StAXStartDocumentEventTest >> eventClass [
	^ StAXStartDocumentEvent
]

{ #category : #tests }
StAXStartDocumentEventTest >> testIsStartDocument [
	self assert: self newEvent isStartDocument
]
