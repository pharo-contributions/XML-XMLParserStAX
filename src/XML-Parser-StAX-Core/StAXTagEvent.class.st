"
An abstract class for tag events.
"
Class {
	#name : #StAXTagEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'name',
		'localName',
		'namespaceURI'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXTagEvent class >> name: aName namespaceURI: aURI [
	^ self new
		setName: aName
		namespaceURI: aURI
]

{ #category : #'instance creation' }
StAXTagEvent class >> named: aName [
	^ self new name: aName
]

{ #category : #testing }
StAXTagEvent >> isNamed: aTagName [
	"tests if tag has same qualified or local name as argument"
	^ aTagName
		isQualifiedName: self name
		orLocalName: self localName
]

{ #category : #testing }
StAXTagEvent >> isNamedAny: aTagNameCollection [
	"tests if tag qualified or local name is in collection"
	^ aTagNameCollection
		includesQualifiedName: self name
		orLocalName: self localName
]

{ #category : #testing }
StAXTagEvent >> isTag [
	^ true
]

{ #category : #accessing }
StAXTagEvent >> localName [
	^ localName ifNil: [localName := self name localNameAfterPrefix]
]

{ #category : #accessing }
StAXTagEvent >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
StAXTagEvent >> name: aName [
	name := aName.
	localName := aName localNameAfterPrefix.
]

{ #category : #accessing }
StAXTagEvent >> namespaceURI [
	^ namespaceURI ifNil: [namespaceURI := '']
]

{ #category : #accessing }
StAXTagEvent >> prefix [
	^ self name prefixBeforeLocalName
]

{ #category : #printing }
StAXTagEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : #initialization }
StAXTagEvent >> setName: aName namespaceURI: aURI [
	name := aName.
	namespaceURI := aURI.
]
