"
Initial (null) event returned by current before parsing has started.
"
Class {
	#name : #StAXInitialEvent,
	#superclass : #StAXStatelessEvent,
	#category : #'XML-ParserStAX-Core'
}

{ #category : #testing }
StAXInitialEvent >> isInitialEvent [
	^ true
]
