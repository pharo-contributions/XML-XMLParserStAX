Class {
	#name : #StAXEventTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-StAX-Tests'
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
	self
		deny: self newEvent isEndTag;
		deny: (self newEvent isEndTag: 'test')
]

{ #category : #tests }
StAXEventTest >> testIsEndTagNamespaceURI [
	self deny:
		(self newEvent
			isEndTag: 'one'
			namespaceURI: 'two')
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
	self
		deny: self newEvent isStartTag;
		deny: (self newEvent isStartTag: 'test')
]

{ #category : #tests }
StAXEventTest >> testIsStartTagNamespaceURI [
	self deny:
		(self newEvent
			isStartTag: 'one'
			namespaceURI: 'two')
]

{ #category : #tests }
StAXEventTest >> testIsTag [
	self deny: self newEvent isTag
]

{ #category : #tests }
StAXEventTest >> testIsText [
	self
		deny: self newEvent isText;
		deny: (self newEvent isText: 'test')
]
