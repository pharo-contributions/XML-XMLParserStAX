"
A list for StAX events that supports conversion to DOM.
"
Class {
	#name : #StAXEventList,
	#superclass : #XMLOrderedList,
	#instVars : [
		'configuration'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXEventList class >> configuration: aConfiguration [
	^ self new configuration: aConfiguration
]

{ #category : #converting }
StAXEventList >> asElement [
	^ self domBuilder buildNextElement
]

{ #category : #converting }
StAXEventList >> asElementNamed: aName [
	^ self domBuilder buildNextElementNamed: aName
]

{ #category : #converting }
StAXEventList >> asElementNamed: aName namespaceURI: aURI [
	^ self domBuilder
		buildNextElementNamed: aName
		namespaceURI: aURI
]

{ #category : #converting }
StAXEventList >> asNode [
	^ self domBuilder buildNextNode
]

{ #category : #initialization }
StAXEventList >> configuration [
	^ configuration ifNil: [configuration := self configurationClass new]
]

{ #category : #initialization }
StAXEventList >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #defaults }
StAXEventList >> configurationClass [
	^ StAXConfiguration
]

{ #category : #copying }
StAXEventList >> copyEmpty [
	^ super copyEmpty configuration: configuration
]

{ #category : #converting }
StAXEventList >> domBuilder [
	^ (self domBuilderClass on: self)
		configuration: self configuration domConfiguration
]

{ #category : #defaults }
StAXEventList >> domBuilderClass [
	^ StAXDOMBuilder
]
