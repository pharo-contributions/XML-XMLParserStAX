"
An start tag event.
"
Class {
	#name : #StAXStartTagEvent,
	#superclass : #StAXTagEvent,
	#instVars : [
		'attributes',
		'namespaceScope'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName [
	^ self attributes at: aName
]

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName ifAbsent: aBlock [
	^ self attributes
		at: aName
		ifAbsent: aBlock
]

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName ifAbsentPut: aBlock [
	^ self attributes
		at: aName
		ifAbsentPut: aBlock
]

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName put: aValue [
	^ self attributes at: aName put: aValue
]

{ #category : #accessing }
StAXStartTagEvent >> attributes [
	^ attributes ifNil: [attributes := OrderPreservingStringDictionary new]
]

{ #category : #building }
StAXStartTagEvent >> buildWith: aBuilder [
	aBuilder startTagEvent: self
]

{ #category : #testing }
StAXStartTagEvent >> hasAttributes [
	^ self attributes notEmpty
]

{ #category : #testing }
StAXStartTagEvent >> includesAttribute: anAttributeName [
	^ self attributes includesKey: anAttributeName
]

{ #category : #testing }
StAXStartTagEvent >> isStartTag [
	^ true
]

{ #category : #testing }
StAXStartTagEvent >> isStartTag: aTagName [
	^ self isNamed: aTagName
]

{ #category : #testing }
StAXStartTagEvent >> isStartTag: aTagName namespaceURI: aUri [
	^ (self isNamed: aTagName)
		and: [self namespaceURI = aUri]
]

{ #category : #private }
StAXStartTagEvent >> namespaceScope [
	^ namespaceScope
]

{ #category : #initialization }
StAXStartTagEvent >> setAttributes: anAttributeDictionary [
	attributes := anAttributeDictionary
]

{ #category : #initialization }
StAXStartTagEvent >> setNamespaceScope: aNamespaceScope [
	namespaceScope := aNamespaceScope
]

{ #category : #printing }
StAXStartTagEvent >> writeXMLOn: aWriter [
	(aWriter tag
		name: name)
		setAttributes: attributes;
		startWriting
		
]