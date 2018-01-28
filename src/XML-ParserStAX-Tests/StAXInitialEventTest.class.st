Class {
	#name : #StAXInitialEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests'
}

{ #category : #accessing }
StAXInitialEventTest >> eventClass [
	^ StAXInitialEvent
]

{ #category : #tests }
StAXInitialEventTest >> testIsInitialEvent [
	self assert: self newEvent isInitialEvent
]
