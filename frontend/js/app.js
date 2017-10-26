console.info("Hello")

var messages = [
  {key: 1, message: 'Hello OneLine!', sender: 'you'},
  {key: 2, message: 'The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.', sender: 'system'}
]

var Message = React.createClass({
  propTypes: {
    message: React.PropTypes.string.isRequired
  },
  render: function() {
    return React.createElement('div', {className: `Message-wrapper Message-wrapper-${this.props.sender === 'system' ? 'received' : 'sent'}`}, React.createElement('div', {className: `Message Message-${this.props.sender === 'system' ? 'received' : 'sent'}`}, this.props.message));
  }
});


var ChatInput = React.createClass({
  propTypes: {
  },
  render: function() {
    return React.createElement('div', {},
      React.createElement('input', {}),
      React.createElement('button', {}, 'Send'),
    );
  }
})

var messageElements = messages.map(function(message) {
  return React.createElement(Message, message);
});
var chatMessagesElement =
  React.createElement('div', {},
    React.createElement('h1', {}, 'OneLine'),
    React.createElement('div', {}, messageElements)
  )
var chatInputElement = React.createElement(ChatInput, {})

ReactDOM.render(chatMessagesElement, document.getElementById('chat-messages'))
ReactDOM.render(chatInputElement, document.getElementById('chat-input'))
