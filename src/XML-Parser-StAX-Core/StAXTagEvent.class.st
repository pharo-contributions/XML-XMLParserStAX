"
An abstract class for tag events.
"
Class {
	#name : #StAXTagEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'name',
		'localName',
		'namespaceScope'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXTagEvent class >> name: aName [
	^ self named: aName
]

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
	"Does the receiver's qualified or local name match the argument?"

	^ self name isXMLQualifiedOrLocalName: aTagName
]

{ #category : #testing }
StAXTagEvent >> isNamedAny: aTagNameCollection [
	"Does the receiver's qualified or local tag name match any of the names
	in aTagNameCollection?"

	^ aTagNameCollection includesXMLName: self name
]

{ #category : #testing }
StAXTagEvent >> isTag [
	^ true
]

{ #category : #accessing }
StAXTagEvent >> localName [
	^ localName ifNil: [localName := self name xmlLocalNameAfterPrefix]
]

{ #category : #accessing }
StAXTagEvent >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
StAXTagEvent >> name: aName [
	name := aName.
	localName := aName xmlLocalNameAfterPrefix.
]

{ #category : #private }
StAXTagEvent >> namespaceScope [
	^ namespaceScope ifNil: [XMLNamespaceScope new]
]

{ #category : #accessing }
StAXTagEvent >> namespaceURI [
	^ self namespaceScope resolvePrefix: self prefix
]

{ #category : #accessing }
StAXTagEvent >> prefix [
	^ self name xmlPrefixBeforeLocalName
]

{ #category : #printing }
StAXTagEvent >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self name;
		nextPut: $).
]

{ #category : #initialization }
StAXTagEvent >> setName: aName namespaceURI: aURI [
	name := aName.
	(namespaceScope := XMLNamespaceScope new)
		mapPrefix: aName xmlPrefixBeforeLocalName
		to: aURI.
]
