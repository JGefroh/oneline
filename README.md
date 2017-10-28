# OneLine

OneLine is a personal assistant chatbot intended to simplify my life.

<img width="709" alt="screen shot 2017-10-28 at 12 42 15 pm" src="https://user-images.githubusercontent.com/1077095/32137894-79460be4-bbdd-11e7-84ed-2ca606ac63be.png">

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


### SMS / Text Interface
Want to just send texts instead of using the web app? No problem! You can use it entirely through text messages / SMS.

![image_uploaded_from_ios_720](https://user-images.githubusercontent.com/1077095/32137937-a2685102-bbde-11e7-94aa-dda75ce8678f.png)



### Modular architecture
OneLine uses a plugin architecture to make adding additional functionality easy! It'll auto-detect any plugins you create and automatically start using them.


# Requirements
* ruby
* bundler `gem install bundler`
* foreman `gem install foreman`

# Run
`foreman start`
