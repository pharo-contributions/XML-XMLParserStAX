"
A StAX parser for messy HTML. Requires the optional XMLParserHTML package.
"
Class {
	#name : #StAXHTMLParser,
	#superclass : #StAXParser,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #accessing }
StAXHTMLParser class >> htmlParserDriverClassOrNil [
	^ Smalltalk
		at: #SAXHTMLParserDriver
		ifAbsent: [nil]
]

{ #category : #testing }
StAXHTMLParser class >> isSupported [
	^ self htmlParserDriverClassOrNil notNil
]

{ #category : #private }
StAXHTMLParser >> driverClass [
	^ self class htmlParserDriverClassOrNil
		ifNil: [self errorHTMLParsingUnsupported]
]

{ #category : #private }
StAXHTMLParser >> errorHTMLParsingUnsupported [
	Error signal: 'HTML parsing is unsupported without the XMLParserHTML package'
]
