axios.defaults.baseURL = 'http://127.0.0.1:4567'
var messages = [
  {message: 'Hi, I\'m OneLine. Type \'help\' to find out what I can do!', sender: 'system'}
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
          message: message
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
