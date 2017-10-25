# 1line

1line is a personal assistant chatbot intended to simplify my life.

### Features:
* Schedules tasks and sends you reminders
* Tells you jokes!
* Receive SMS / Text message notifications
* Modular plugin architecture makes extensions easy!


# Future Plans

I plan on adding many modules and features to it, but the initial rollout will include a basic scheduling and notification service to help me remember appointments and to-do-lists.

# Requirements
* ruby
* foreman `gem install foreman`

# Run
`foreman run ruby ./core/bootstrap.rb`

```
Loaded Help::Plugin
Loaded Jokes::Plugin
Loaded Notifier::Plugin
Loaded Scheduler::Plugin
Hi, I'm your personal assistant. Type 'help me' to see what I can do!
> Go to the movies at 2pm tomorrow.
----- Great! I'll remind you to `Go to the movies .` on 2017-10-26 at 2:00 pm.
> tell me a joke
----- Why is Peter Pan always flying? Because he Neverlands.
> Call friend in 5 minutes
----- Great! I'll remind you to `Call friend` on 2017-10-27 at 11:33 am.
> list
----- Your list..
----- * Go to the movies at 2pm tomorrow.
----- * Call friend in 5 minutes
```

# Run tests
`foreman run ruby ./core/bootstrap.rb test`
