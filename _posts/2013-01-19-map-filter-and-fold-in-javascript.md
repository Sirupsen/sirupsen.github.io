---
layout: post
title: Map, Filter, and Fold in JavaScript
---

<div class="intro">
  Map, filter, and fold are three workhorse functions that form a very common <a href="http://en.wikipedia.org/wiki/Functional_programming">functional programming</a> design pattern. These higher order functions give you the power to abstract away a lot of for loops and if statements -- cleaning up the control flow of your code. In a nutshell, map, filter, and fold operate on a sequence of elements (arrays or objects) and returns a new updated array or a new value all together.
</div>

Native support for [map](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array/map), [filter](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array/filter), and [fold](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array/reduce) (aka reduce) was introduced in ECMAScript 5/JavaScript 1.6. This means Internet Explorer 8 and below do not have access to these methods. Which brings us to the next hanging point, these three functions are methods of the Array class, leaving objects in the dark. There are a few more imperfections, albeit minor. You can read a well written rant by Swizec Teller [here](http://swizec.com/blog/javascripts-native-map-reduce-and-filter-are-wrong/swizec/1873).

So I'm going to explore M,F,F with influence from studying Python's documentation, [this paper](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-005-elements-of-software-construction-fall-2011/lecture-notes/MIT6_005F11_lec15.pdf) by Professor Rob Miller of MIT, the [Underscore.js](http://documentcloud.github.com/underscore/) source code, and a myriad of other sources.

-------------------------------------------------------------

##Helper function: forEach

We'll need a little help from the helper function forEach, a function that abstracts away for loops. Again, [native support](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array/forEach) was introduced in ECMA5 and JS 1.6, so Internet Explorer 8 and below need a little help. But that doesn't surprise you, right? Since this too is a method of the Array class, we'll extend forEach to work with objects as well.

forEach needs to invoke a supplied function once per array element or once per object property.

The most basic implementation of forEach looks like this:


	var forEach = function (obj, iterator) {
		for (var i = 0, l = obj.length; i < l; i += 1) {
			iterator.call(this, obj[i]);
		}
	};


Now we want to add support for passing an Object as an argument. We'll also use the .call method to invoke the function, this give us control over the context of *this* during the function's callback. Read more about why you may want control over the context of *this* [here](http://odetocode.com/blogs/scott/archive/2007/07/05/function-apply-and-function-call-in-javascript.aspx).


	var forEach = function (obj, iterator, thisArg) {

		// check to see if we're working with an array
		if (obj.length === +obj.length) {
			for (var i = 0, l = obj.length; i < l; i += 1) {
				iterator.call(thisArg, obj[i]);
			}

		// otherwise iterate over an object
		} else {
			for (var key in obj) {
				if(obj.hasOwnProperty(key)) {
					iterator.call(thisArg, obj[key]);
				}
			}
		}
	};


And finally we'll check to see if native support is available, if it is we'll pass over control to the native function.


	var forEach = function (obj, iterator, thisArg) {

		// test for native forEach support
		if (Array.prototype.forEach && obj.forEach === Array.prototype.forEach) {
			obj.forEach(iterator, thisArg);

		// arrays
		} else if (obj.length === +obj.length) {
			for (var i = 0, l = obj.length; i < l; i += 1) {
				iterator.call(thisArg, obj[i]);
			}

		// objects
		} else {
			for (var key in obj) {
				if(obj.hasOwnProperty(key)) {
					iterator.call(thisArg, obj[key]);
				}
			}
		}
	};


Bonus: use our forEach function to make a function that returns the sum of an array.

-----------------------------------------------------------------

##Map

Map takes a list of values (an array or object), invokes a function on each of those values, and returns the new updated list in the same order. So, read map as: you're mapping a function to an array or object -- such as taking a function that converts dollar amounts into cents and mapping that function to each element of the array [20, 100, 2.5], this will be returned as [2000, 11000, 250].

You'll note the primary difference between forEach and map is that map returns the new list whereas forEach simply applies an action to list without returning the result.

After we set the result variable to an empty set, we invoke the native map method if it is available, else we invoke the function and push the result to the array, and finally we return the result.


	var map = function (obj, iterator, thisArg) {

		// prepare the result variable
		var result = [];

		// pass control to native map if it's available
		if (Array.prototype.map && obj.map === Array.prototype.map) {
			return obj.map(iterator, thisArg);
		}

		// otherwise, use our version of map
		forEach(obj, function (value, index, list) {
			// push the value returned from the iterator onto result
			result[result.length] = iterator.call(thisArg, value, index, list);
		});

		// return the new updated array
		return result;
	};


Let's see how we would implement our theoretical example of converting dollar ammounts to cents.


	// make an array of dollar values
	var someDollars = [2.5, 10, 50, 1];

	// build a conversion function
	var toCents = function (n) {
		return n * 100;
	};

	// output an array of value in cents
	var someCents = map(someDollars, toCents); // nice and easy to read
	// == [250, 1000, 5000, 100]


-----------------------------------------------------------

##Filter

Similar to map, filter takes a list of values and returns a new list. But filter invokes a function that returns a boolean result. If the function returns true, the value is added to the new list, values that return a falsey result are filtered out.

So, if you were filtering by testing if a value is a number, ["Large", 20, "100", 3] would filter down to [20, 3].

Again, we set the result variable to an empty set and use the native filter method if it's available. Then we run a value through the function, if the function returns true, we push that value to our result array. And we of course return the result variable after all values have been filtered.


	var filter = function (obj, iterator, thisArg) {

		// prepare the result variable
		var result = [];

		// pass control to the native filter if it's available
		if (Array.prototype.filter && obj.filter === Array.prototype.filter) {
			return obj.filter(iterator, thisArg);
		}

		// otherwise use our own filter
		forEach(obj, function (value, index, list) {

			// if the result of passing a value through the function
			// is true, then add that value you to the new list
			if (iterator.call(thisArg, value, index, list)) {
				result[result.length] = value;
			}
		});

		// return the new list
		return result;
	};


To demonstrate filter, lets filter through the values of a list, keeping only those values that are numbers.


	// make an array of values to filter
	var someArray = ["Large", 20, "100", 4];

	// make a function that returns true if its argument is a number
	var isNumber = function (x) {
		return typeof x === 'number';
	};

	// output a filtered array
	var filteredArray = filter(someArray, isNumber);
	// == [20, 4]


----------------------------------------------------------------

##Fold (aka reduce)

Along with invoking a function on each value in the list, fold accepts an accumulator (the fold's initial value) as an argument. Fold ultimately returns the accumulator. If the list passed to fold is empty, the accumulator is return. The accumulator is added to the result of invoking the function on each value, so that the accumulator becomes a sum of sorts.

There are two variations of fold: foldl and foldr. These can be read as: fold from left, and fold from right, giving you control over which end your fold starts at and its direction. There's a great explanation of the differences between foldl and foldr on [stackoverflow](http://stackoverflow.com/questions/3082324/foldl-versus-foldr-behavior-with-infinite-lists/3085516#3085516). We'll work through the 'default' direction, foldl.


	var foldl = function (obj, iterator, accu, thisArg) {

		// set a variable that tells us if an accumulator was set
		var hasAccu = arguments.length > 2;
		
		// pass control to the native foldl if it's available
		if ((Array.prototype.reduce && obj.reduce === (Array.prototype.reduce) {
			// if accumulator present, pass it
			return hasAccu ? obj.reduce(iterator, accu) : obj.reduce(iterator);
		}

		// otherwise use our own definition of foldl
		forEach(obj, function (value, index, list) {

			// set the accu to the first value, if accu wasn't 
			// supplied as an argument
			if (!hasAccu) {
				accu    = value;
				hasAccu = true;
			} else {
				accu = iterator.call(thisArg, accu, value, index, list);
			}
		});

		// return the final value of our accumulator
		return accu;
	};


The easiest implementation of foldl to wrap your head around is to create a sum or a sum plus an initial value.


	// set an array of values to get the sum of
	var someArray = [1, 10, 100];

	// define an add function
	var add = function (x, y) {
		return x + y;
	};

	// output the sum of someArray
	var foldedArray = foldl(someArray, add); // 111
	var foldedArray = foldl(someArray, add, 1000); //1111


----------------------------------------------------------------

##On deck

I hope to come back and expand on the use cases between foldl and foldr, and also write another post on advanced implementations of M,F,F using different contexts of *this*. But, first I want to tackle a visual guide on applying MVC frameworks in JavaScript.

The above implementations are missing a few simple error prevention lines. Consider that your homework! The answer can be found in the sources linked throughout the article.








