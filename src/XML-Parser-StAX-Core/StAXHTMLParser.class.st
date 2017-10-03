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
	^ XMLClassFinder classNamed: #SAXHTMLParserDriver
]

{ #category : #testing }
StAXHTMLParser class >> isSupported [
	^ self htmlParserDriverClassOrNil notNil
]

{ #category : #defaults }
StAXHTMLParser >> driverClass [
	^ self class htmlParserDriverClassOrNil
		ifNil: [self errorHTMLParsingUnsupported]
]

{ #category : #private }
StAXHTMLParser >> errorHTMLParsingUnsupported [
	Error signal: 'HTML parsing is unsupported without the XMLParserHTML package'
]
