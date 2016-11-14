# SortSass

> Sass properties sorting tool.

It supports only indented sass syntax.

## Install

```sh
npm install -g sort-sass
```

Leave off the `-g` if you don't wish to install globally.

## Usage

From CLI:
```sh
sortsass /path/to/styles.sass
```

From node:
```js
var fs = require('fs');
var sortSass = require('sort-sass');

var sassString = fs.readFileSync('some.sass');
var sortedSassString = sortSass(sassString);
```

## Examples

Input:

```sass
.foo
	font-size: 1em
	content: 'bar'
	color: white
	display: block
	position: absolute
```

Output:

```sass
.foo
	content: 'bar'
	display: block
	position: absolute
	font-size: 1em
	color: white
```

## License

MIT © [Alexey Volodkin](a@vldkn.net)
