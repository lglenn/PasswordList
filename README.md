Password List
=============

The problem: someone says to you, "I need a list of all of your team's passwords." You don't really want to walk around collecting them, you don't want to have people send them to you via email, both because that's insecure and because you don't really feel like babysitting your inbox and collating a list. Enter Password List. A small webapp that lets people enter their name, username, and password in a form. The webapp will encrypt the password with a public key, and store it in a database. Going to /accounts/report (or /accounts/txtreport), and you get the list. Then use the decryptor script in /tools (along with the private key) to convert the entire list to plaintext, at which point you can hand it off to whoever asked for it. 

Dependencies
============

* Ruby 1.9
* Rails 3.0
* openssl

Installation
============

It's a rails app. Deploy it somewhere, e.g. Heroku. 

Do a rake db:migrate

Create a public key, and stick it in /keys/public.pem. There's a sample key there, but it's useless to you, as you don't have the private key. 

Usage
=====

Send people to the site, have them enter their info. 

To retrieve the data that's been uploaded, go to /acounts/report (or /accounts/txtreport for a text-plain version), and save the report. Then run the decryptor script (/tools/decryptor.rb), with the filename of the report, the filename of the private key, and the key's passphrase (yes, I know that's bad) as command-line arguments. For example: 

	./tools/decryptor.rb passwords.txt secret.key foobar

As soon as you get what you needed, blow away the database, just to be safe. 
 
Caveats
=======

This thing isn't intended to provide anything more than a modicum of security:

* You'll probably run it over HTTP, which means that the passwords will be sent over the wire in plaintext when the user submits them. 
* Usernames and names are stored / transmitted / reported in plaintext. 
* Anyone can go in and edit names/usernames/passwords once they've been submitted (although they can't see passwords).

Really, I wrote it because I didn't want to go around and ask people for their passwords, and I didn't feel OK storing the passwords on a server (even if only for a day or so) in plaintext. And really, at the end of the day, if you're collecting the passwords because you need to give them to someone in plaintext, there's a fairly weak link in the chain no matter what, and it doesn't make too much sense to get a lot stronger than that.

Please don't use this for anything that really matters. 
