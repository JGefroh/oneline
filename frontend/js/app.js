var messages = [
  {message: 'hello', sender: 'you'},
  {message: 'hi Joseph!', sender: 'system'}
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
        Vue.nextTick(function () {
          messageWindow.scrollTop = messageWindow.scrollHeight;
        })
      }
    }
  }
})
