if (location.href.indexOf('127.0.0.1') >= 0) {
  axios.defaults.baseURL = 'http://127.0.0.1:5000/api'
}
else {
  axios.defaults.baseURL = 'http://oneline.jgefroh.com/api'
}
var url = new URL(location.href);
var owner_id = url.searchParams.get("owner_id")
if (!owner_id) {
   location.replace("?owner_id=" + Math.random() + '' + Math.random() + '' + Math.random() + '' + Math.random());
}

var messages = [
  {message: 'Hi, I\'m OneLine. What\'s your phone number?', sender: 'system'},
  {message: '(Enter an 11-digit phone number, without spaces or symbols.)', sender: 'system'}
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
