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

## Properties order

> Ordering is hardcoded right now, you can see it here https://github.com/miraks/sort-sass/blob/master/src/order.coffee. I think I'll add an option to change this.

– [miraks](https://github.com/miraks) (repository owner) [in a comment](https://github.com/miraks/sort-sass/issues/1#issuecomment-238791283) to #1

There is an issue [#3](https://github.com/miraks/sort-sass/issues/3)

## License

MIT © [Alexey Volodkin](a@vldkn.net)
