# XML-XMLParserStAX

[![Build Status](https://travis-ci.org/pharo-contributions/XML-XMLParserStAX.svg?branch=master)](https://travis-ci.org/pharo-contributions/XML-XMLParserStAX) [![Coverage Status](https://coveralls.io/repos/github/pharo-contributions/XML-XMLParserStAX/badge.svg?branch=master)](https://coveralls.io/github/pharo-contributions/XML-XMLParserStAX?branch=master)

XMLParserStAX is a pull parser in [Pharo](http://www.pharo.org) for [XMLParser](https://github.com/pharo-contributions/XML-XMLParser) that provides a streaming interface for "pulling" XML events and also supports pull-style DOM parsing for dynamically converting events into DOM nodes.

## Installation

```Smalltalk
Metacello new
	baseline: 'XMLParserStAX';
	repository: 'github://pharo-contributions/XML-XMLParserStAX/src';
	load.
```
## Usage

A simple example on how to use the XML parser for HTML:

```Smalltalk
...
```

results in the following XML output
```HTML
...
```


## LICENSE
[MIT License](LICENSE)

## History
This project was migrated from [http://smalltalkhub.com/#!/~PharoExtras/XMLParserStAX](http://smalltalkhub.com/#!/~PharoExtras/XMLParserStAX)
