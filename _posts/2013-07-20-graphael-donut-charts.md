---
layout: post
title: How to Make a Donut Chart with gRaphael
---

<div class="intro">
  This will be a quick post showing how you can add native support for Donut Charts to g.raphael by extending the Pie Charts JS. Alternatively, you can just <a href="https://github.com/Matthew-Odette/g.raphael">clone my g.raphael repo</a> on GitHub, but where's the fun in that?
</div>

This post assumes you have a working set of raphael and g.raphael libraries, which depending on your source can be a little tricky.

-------------------------------------------------------------

##Adding Donut Chart Support to: g.pie.js

Crack open your (non-minified) g.pie.js. The Piechart function already accepts an options argument: *opts*. We'll extend this to include: donut (bool), donutDiameter (ratio 0.0 - 1.0), and donutFill (hex color code). We also need to set up default values so nothing falls through the cracks.

The begining of your Piechart function should resemble:


	function Piechart(paper, cx, cy, r, values, opts) {
        opts = opts || {};

        var chartinst = this,
            sectors = [],
            covers = paper.set(),
            chart = paper.set(),
            series = paper.set(),
            order = [],
            len = values.length,
            angle = 0,
            total = 0,
            others = 0,
            cut = 9,
            defcut = true,
            donut         = opts.donut         || false,    // default to false
            donutDiameter = opts.donutDiameter || 0.6666,   // percentage of the pie charts width
            donutFill     = opts.donutFill     || "#FFFFFF";// the color of the donut 'hole'

            ... cont'd


Only three new lines of code so far -- that's not so bad.

Now, we need to draw our donut, if opts.donut === true. Let's place this code just before the *chart.hover* method is defined. All this code needs to do is draw a circle over the pie chart, using our new options. Note that the charts radius (r) is multiplied by the donutDiameter to give us the width of our donut chart's 'hole'.


		// donut chart code
        if (donut) series.push(paper.circle(cx, cy, r * donutDiameter).attr({ fill: donutFill, stroke: opts.stroke || donutFill}));


Annnnd you're done. The *paper.circle* is a part of the raphael library and *cx* & *cy* are the center x & y coordinates of the pie chart.  

-----------------------------------------------------------------

##Making Donut Charts and Taking Names

Now let's actually draw some donut charts. We'll start super basic, mimicking g.raphael's basic pie chart example.

Either start with the [piechart_basic.html](https://github.com/Matthew-Odette/g.raphael/blob/master/examples/piechart/piechart_basic.html) example from the GitHub repo, or make a simple html page that includes your raphael.js, g.raphael.js, and your shiny new g.pie.js.

Here's the magic code that draws the pie chart:


	// Creates pie chart at with center at 320, 200,
    // radius 100 and data: [55, 20, 13, 32, 5, 1, 2]
    var pie = r.piechart(320, 240, 100, [55, 20, 13, 32, 5, 1, 2]);


And here it is as a donut chart:


	// Creates pie chart at with center at 320, 200,
    // radius 100 and data: [55, 20, 13, 32, 5, 1, 2]
    var pie = r.piechart(320, 240, 100, [55, 20, 13, 32, 5, 1, 2], {donut : true});


The (slightly boring) result:

![](/static/images/donutchart/donutchart-basic.png)

Now your free to add all the bells and whistles you can to any g.raphael pie chart. Here's a example with a legend, the value displayed in the center when a slice is hovered, and a bounce animation. The source can be found on [GitHub](https://github.com/Matthew-Odette/g.raphael/blob/master/examples/piechart/piechart_donut.html).


	window.onload = function() {
        // Creates canvas 640 × 480 at 10, 50
        var r = Raphael(10, 50, 640, 480);


        // Creates donut chart with center at 320, 200,
        // radius 100 and data: [55, 20, 13, 32, 5, 1, 2]
        var pie = r.piechart(320, 240, 100, [50, 20, 13, 32, 7], {donut : true, legend: ["Chrome", "Firefox", "Internet Explorer", "Safari", "Other"], legendpos: "east"});

        r.text(320, 100, "Interactive Donut Chart").attr({ font: "20px sans-serif" });
        pie.hover(
			// mouse over
        	function () {
            var that = this.sector;
            this.sector.stop();
            this.sector.scale(1.1, 1.1, this.cx, this.cy);

            pie.each(function() {
               if(this.sector.id === that.id) {
                console.log(pie)
                   tooltip = r.text(320, 240, this.sector.value.value).attr({"font-size": 35, "fill":"#000"});
               }
            });

            if (this.label) {
                this.label[0].stop();
                this.label[0].attr({ r: 7.5 });
                this.label[1].attr({ "font-weight": 800 });
            }
        }, 

		// mouse out
        function () {
            this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
            tooltip.remove();

            if (this.label) {
                this.label[0].animate({ r: 5 }, 500, "bounce");
                this.label[1].attr({ "font-weight": 400 });
            }
        });
    }


Looking good:

![](/static/images/donutchart/donutchart-interactive1.png)

![](/static/images/donutchart/donutchart-interactive2.png)

----------------------------------------------------------------

##On deck

I plan on exploring and explaining g.raphael charts in more detail, fixing a few quircks along the way.








