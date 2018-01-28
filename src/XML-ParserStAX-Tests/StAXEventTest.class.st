Class {
	#name : #StAXEventTest,
	#superclass : #TestCase,
	#category : #'XML-ParserStAX-Tests'
}

{ #category : #testing }
StAXEventTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
StAXEventTest >> eventClass [
	^ StAXEvent
]

{ #category : #'instance creation' }
StAXEventTest >> newEvent [
	^ self eventClass new
]

{ #category : #tests }
StAXEventTest >> testIsCData [
	self deny: self newEvent isCData
]

{ #category : #tests }
StAXEventTest >> testIsComment [
	self deny: self newEvent isComment
]

{ #category : #tests }
StAXEventTest >> testIsEndDocument [
	self deny: self newEvent isEndDocument
]

{ #category : #tests }
StAXEventTest >> testIsEndTag [
	self deny: self newEvent isEndTag
]

{ #category : #tests }
StAXEventTest >> testIsEndTagNamed [
	self deny: (self newEvent isEndTagNamed: 'test')
]

{ #category : #tests }
StAXEventTest >> testIsEndTagNamedAny [
	self deny: (self newEvent isEndTagNamed: #('one' 'two' 'three'))
]

{ #category : #tests }
StAXEventTest >> testIsInitialEvent [
	self deny: self newEvent isInitialEvent
]

{ #category : #tests }
StAXEventTest >> testIsPI [
	self deny: self newEvent isPI
]

{ #category : #tests }
StAXEventTest >> testIsStartDocument [
	self deny: self newEvent isStartDocument
]

{ #category : #tests }
StAXEventTest >> testIsStartTag [
	self deny: self newEvent isStartTag
]

{ #category : #tests }
StAXEventTest >> testIsStartTagNamed [
	self deny: (self newEvent isStartTagNamed: 'test')
]

{ #category : #tests }
StAXEventTest >> testIsStartTagNamedAny [
	self deny: (self newEvent isStartTagNamedAny: #('one' 'two' 'three'))
]

{ #category : #tests }
StAXEventTest >> testIsStringEvent [
	self
		deny: self newEvent isStringEvent;
		deny: (self newEvent isStringEvent: 'test')
]

{ #category : #tests }
StAXEventTest >> testIsTag [
	self deny: self newEvent isTag
]
