"
A base class for stateless event classes with single shared instances.
"
Class {
	#name : #StAXStatelessEvent,
	#superclass : #StAXEvent,
	#classInstVars : [
		'instance'
	],
	#category : #'XML-ParserStAX-Core-XML-ParserStAX-Core'
}

{ #category : #accessing }
StAXStatelessEvent class >> instance [
	^ instance ifNil: [instance := self basicNew initialize]
]

{ #category : #'instance creation' }
StAXStatelessEvent class >> new [
	^ self instance
]
