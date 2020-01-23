---
date: "2012-08-12T00:00:00Z"
hidden: true
title: Handle passwords with Keychain
---

I considered [1password][1password], but playing with
Keychain, which ships with OS X, I found out it does all I need from a password manager. 
No need for any browser extensions or app store purchases. It's all built in to OS X. 
Simply understanding how "Save Password" works in the browser is enough to solve
the problem.

Safari and Chrome both save and fetch passwords from Keychain. You want to have
the encrypted keychain which you'll store all your passwords in backed up. I store it
in my Dropbox. You can find the default keychain at
`~/Library/Keychains/login.keychain`. Once you've moved it to your Dropbox, open
`Keychain Access` and add it from the file menu. Most of your passwords will 
already be in there. That's fine.

You might also want to change the password to the keychain. By default the
password to the login keychain is your user login. You change it by right
clicking it in the left-hand pane.

Whenever I create a new account, or change a password, I come up with a 
[random password](http://xkcd.com/936/) myself and put it in my clipboard. Paste
it when signing up, and when signing in. On sign in I allow Safari/Chrome to remember my password, which means 
it stores the password in Keychain. 

If you ever need the password outside your OS X browser, for instance to sign in to
Twitter on your phone, you can copy the password to the clipboard from `Keychain`:

![](/static/images/passwords/copy-to-clipboard.png)

Once a password is in Keychain it will auto-fill in your browser, regardless of
how you add it, as long as the "where" attribute is the same as the page you are
currently on:

![](/static/images/passwords/keychain-facebook-details.png)

![](/static/images/passwords/facebook-autocomplete.png)

Since there's no magic in adding keys, you can just as well add them from the
command line or in the Keychain app, as long as the "where" attribute (as shown on the
picture above) is right.

`security` also allows you to easily add new passwords with the
`add-internet-password` command:

{{< highlight bash >}}
    security add-internet-password -a "John Doe" -s foo.com -w pass 
{{< / highlight >}}

Furthermore, passwords in Keychain can be accessed via `security` on the command line:

{{< highlight bash >}}
    security 2>&1 >/dev/null find-internet-password -gs www.google.com | grep -o \
      '".*"' | sed 's/"//g'
{{< / highlight >}}

It will prompt me for the password to the keychain, then output the decrypted
password. This is handy for [various][mutt] [packages][gist] that require passwords.

[Keychain2go][keychain2go] exists if you want to bring it to your iPhone.

You can also add encrypted notes to your keychain, these can be used for credit card
numbers, images, bank account information, secret documents etc.

[gist]: https://github.com/defunkt/gist/#authentication
[mutt]: http://www.mutt.org/
[1password]: https://agilebits.com/onepassword
[keychain2go]: http://www.jinx.de/Keychain2Go.html
