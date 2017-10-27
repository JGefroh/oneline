# OneLine

OneLine is a personal assistant chatbot intended to simplify my life.

<img width="656" alt="screen shot 2017-10-26 at 4 16 06 pm" src="https://user-images.githubusercontent.com/1077095/32081242-039a5eba-ba69-11e7-8aa3-5839c5706bd5.png">

# Features:

### Track your to-do-list and receive SMS / Text message reminders
You're a busy person with many important things to do. Why waste time remembering and inevitably forgetting all those important things? Let OneLine remind you of them! Just give OneLine a time or date (or both) and you'll receive a reminder via text at that time.

```
> Go to the movies at 2pm 11/13
Great! I'll remind you to `Go to the movies` on 2017-11-13 at 2:00 pm.
> Call friend in 5 minutes
Great! I'll remind you to `Call friend` on 2017-10-27 at 11:33 am.
```


### Tells you jokes!
OneLine will tell you the very ~best~ worst dad-jokes and lame puns. It's almost as if I were telling you the jokes myself!

We currently support Dad jokes and Chuck Norris jokes.
```
> tell me a joke
Why is Peter Pan always flying? Because he Neverlands.
> tell me a dad joke
It doesn't matter how much you push the envelope. It will still be stationary.
> tell me a chuck norris joke
Do you know why Baskin Robbins only has 31 flavors? Because Chuck Norris doesn't like Fudge Ripple.
```

Thanks to the following API providers for their jokes:
* [icanhazdadjoke](https://icanhazdadjoke.com)
* [The Internet Chuck Norris Database](http://www.icndb.com/)

### Multiple interfaces
Want to talk to OneLine in the browser? Great! There's a front-end for that. Do you prefer the console? No problem - OneLine works perfectly well in the terminal. Want to just send texts instead?

### Modular architecture
OneLine uses a plugin architecture to make adding additional functionality easy! It'll auto-detect any plugins you create and automatically start using them.


# Future Plans

I plan on adding many modules and features to it, but the initial rollout will include a basic scheduling and notification service to help me remember appointments and to-do-lists.


# Requirements
* ruby
* bundler `gem install bundler`
* foreman `gem install foreman`

# Run
`foreman run ruby ./core/bootstrap.rb`

```
Loaded Help::Plugin
Loaded Jokes::Plugin
Loaded Notifications::Plugin
Loaded Scheduler::Plugin
Hi, I'm your personal assistant. Type 'help me' to see what I can do!
> Go to the movies at 2pm tomorrow.
Great! I'll remind you to `Go to the movies .` on 2017-10-26 at 2:00 pm.
> tell me a joke
Why is Peter Pan always flying? Because he Neverlands.
> Call friend in 5 minutes
Great! I'll remind you to `Call friend` on 2017-10-27 at 11:33 am.
> list
Your list..
* Go to the movies at 2pm tomorrow.
* Call friend in 5 minutes
```

# Run tests
`foreman run ruby ./core/bootstrap.rb test`
