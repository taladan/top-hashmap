# Hashmap

This [assignment](https://www.theodinproject.com/lessons/ruby-hashmap) is to write a Hashmap functionality that utilizes a bucket system for storing key/value pairs in a linked list (to avoid collisions until the map can grow).

The methods for hashmap:

- #set(key, value) - sets k/v pair in hashmap
- #get(key) - returns value from key in hashmap
- #has?(key) - boolean t/f if key is in hashmap
- #remove(key) - removes k/v pair based on key from hashmap
- #length - returns the number of k/v pairs in hashmap
- #clear - clears all values out of hashmap
- #keys - returns array of keys in hashmap
- #values - returns array of values in hashmap
- #entries - returns array of k/v pairs of all entries in hashmap

As per the assignment, this hashmap automatically grows once the number of entries is greater than the load factor of the capacity. The initial capacity of the hashmap is 16 and grows by a factor of 2.

This code utilizes my old [linked list](https://github.com/taladan/TOP-ruby-linked_list) code, and for it to work I had to twiddle it a bit, clean it up and make it hang just right.

In all, this took me about three days from start to finish - something I never would have been able to do before completing the Chess assignment. The only reason I did Chess before hashmap is because it took me so long to complete chess that they added the Hashmap assignment into the course after I'd already started it. I could have just skipped it and gone on, but two factors applied:

- I'm a bit of a completionist idiot
- I figured learning how hashmaps work couldn't hurt, might help

This was a fun little diversion and while my solution probably isn't the best or cleanest out there (a couple of my class objects are a little bloated - I'm looking at **you** `hashmap.rb` and `linked_list.rb`) but I did get a deeper understanding of how hashes work in theory.
