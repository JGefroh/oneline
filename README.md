# 1line

1line is a personal assistant chatbot intended to simplify my life.

### Features:
* Schedule tasks
* Receive SMS / Text message notifications

# Future Plans

I plan on adding many modules and features to it, but the initial rollout will include a basic scheduling and notification service to help me remember appointments and to-do-lists.

# Requirements
* ruby
* foreman `gem install foreman`

# Run
`foreman run ruby main.rb`

```shell
Hi, I'm your personal assistant. Type 'help me' to see what I can do!
> help
Ask me to remember something and I will.
eg. 'Go to the movies at 2pm tomorrow.'

Type 'list' to see everything I'm remembering at the moment.
Type 'exit' to quit.
> Go to the movies at 2pm tomorrow.
----- Great! I'll remind you about this on 2017-10-22 at 2:00 pm.
> Interview on 10/14 at 1pm
----- Great! I'll remind you about this on 2017-10-14 at 1:00 pm.
> list
----- Your list..
----- * Go to the movies at 2pm tomorrow.
----- * Interview on 10/14 at 1pm
```
# Test
`ruby test.rb`
