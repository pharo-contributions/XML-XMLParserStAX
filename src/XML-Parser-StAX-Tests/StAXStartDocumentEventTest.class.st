Class {
	#name : #StAXStartDocumentEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXStartDocumentEventTest >> eventClass [
	^ StAXStartDocumentEvent
]

{ #category : #tests }
StAXStartDocumentEventTest >> testIsStartDocument [
	self assert: self newEvent isStartDocument
]
