"
An abstract class for tag events.
"
Class {
	#name : #StAXTagEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'name',
		'localName',
		'namespaceUri'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXTagEvent class >> name: aName localName: aLocalName namespaceURI: aNamespaceUri [
	^ self new
		setName: aName
		localName: aLocalName
		namespaceURI: aNamespaceUri
]

{ #category : #testing }
StAXTagEvent >> isNamed: aName [
	^ aName
		isQualifiedName: self name
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
	^ namespaceUri ifNil: [namespaceUri := '']
]

{ #category : #accessing }
StAXTagEvent >> prefix [
	^ self name prefixBeforeLocalName
]

{ #category : #printing }
StAXTagEvent >> printBodyOn: aStream [
	aStream
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : #initialization }
StAXTagEvent >> setName: aName localName: aLocalName namespaceURI: aNamespaceUri [
	name := aName.
	localName := aLocalName.
	namespaceUri := aNamespaceUri.
]
