axios.defaults.baseURL = 'http://127.0.0.1:4567'

var url = new URL(location.href);
var owner_id = url.searchParams.get("owner_id")
if (!owner_id) {
   location.replace("?owner_id=" + Math.random() + '' + Math.random() + '' + Math.random() + '' + Math.random());
}

var messages = [
  {message: 'Hi, I\'m OneLine. Enter \'help\' to find out what I can do!', sender: 'system'},
  {message: 'Enter an 11-digit mobile phone number without any symbols or spaces to receive text reminders. For example:', sender: 'system'},
  {message: '18085551234', sender: 'system'},
  {message: 'Alternatively, you can text me at 1-808-215-7977.', sender: 'system'}
]
var app = new Vue({
  el: '#app',
  data: {
    messages: messages,
    newMessage: ''
  },
  methods: {
    sendMessage: function(message) {
      if (message) {
        messages.push({
          message: message,
          sender: 'you'
        });
        this.newMessage = null;
        messageWindow = this.$el.querySelector("#message-window");
        axios.post('/messages', {
          message: message,
          owner_id: owner_id
        }).then(function(response) {
          if (response.data) {
            for (var i = 0; i < response.data.length; i++) {
              messages.push({
                message: response.data[i].message,
                sender: 'system'
              });
            }

            Vue.nextTick(function () {
              messageWindow.scrollTop = messageWindow.scrollHeight;
            })
          }
        }).catch(function(response) {
          console.info(response);
        });
        Vue.nextTick(function () {
          messageWindow.scrollTop = messageWindow.scrollHeight;
        })
      }
    }
  }
})
