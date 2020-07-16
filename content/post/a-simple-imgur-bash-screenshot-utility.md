---
date: "2010-05-10T00:00:00Z"
title: A simple Imgur Bash screenshot utility
---

I use screenshots a lot, every day. Mostly when I do instant messaging, they can usually help explain something much quicker than anything else. It's rare that I edit the screenshot, and in these rare occasions, it doesn't bother me all that much having to fire up [Pinta](http://pinta-project.com/) or [Gimp](http://www.gimp.org/)--to make these small changes.

## Installation

`shoot`'s dependencies are: 

* `curl`
* `grep`
* `scrot` 
* `xclip`
* `libnotify` (*optional*)

You probably have those already, if not, install them via your package manager.

{{< highlight bash >}}
curl http://sirupsen.com/static/misc/shoot > ~/bin/shoot && chmod 755 ~/bin/shoot
{{< / highlight >}}

Assuming `~/bin` is in your `$PATH`, you're ready to `shoot`:

{{< highlight bash >}}
$ shoot
$ xclip -selection c -o
http://imgur.com/Z8prG.jpg
{{< / highlight >}}

I recommend that you bind the script to a key, so you can easily activate it.

## Coming up with the script

The functionality needed, came down to this:

* Select region and take screenshot of this region
* Upload screenshot to [Imgur](http://imgur.com)
* Put direct link to screenshot into the clipboard

Taking a screenshot of a specified region is quite easy with `scrot`:

{{< highlight bash >}}
scrot -s
{{< / highlight >}}

Then using `curl` to upload the picture, via the Imgur API:

{{< highlight bash >}}curl -s -F "image=@$1" -F "key=api-key" \
https://imgur.com/api/upload.xml {{< / highlight >}}

This returns some XML containing, among other things, the direct URL to the uploaded screenshot, which we extract from the returned XML with a simple regex:

{{< highlight bash >}}grep -E -o "<original_image>(.)*</original_image>" | \
grep -E -o "http://i.imgur.com/[^<]*" {{< / highlight >}}

Now we have the direct link, and then it's simply a matter of putting this all into the clipboard with `xclip`:

{{< highlight bash >}}xclip -selection c {{< / highlight >}}

Now this is optional, but quite handy. It uses `libnotify` to notify you when the image is uploaded, and ready to be pasted:

{{< highlight bash >}}notify-send "Clipboard ready!" {{< / highlight >}}

## The script

And I compiled all this into this simple script (I'm aware that this can be a one-liner and everything but this just seems more readable and *works*. If you have a better solution, be sure to contact me!):

{{< highlight bash >}}
function uploadImage {
  curl -s -F "image=@$1" -F "key=486690f872c678126a2c09a9e196ce1b" https://imgur.com/api/upload.xml | grep -E -o "<original_image>(.)*</original_image>" | grep -E -o "http://i.imgur.com/[^<]*"
}

scrot -s "shot.png" 
uploadImage "shot.png" | xclip -selection c
rm "shot.png"
notify-send "Done"
{{< / highlight >}}

That's it. Hopefully you'll enjoy it as much as I do.
