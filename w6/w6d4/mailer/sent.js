const MessageStore = require("./message_store")

const Sent = {
  render: function() {
    let ul = document.createElement("ul");
    ul.className = "messages";

    let messages = MessageStore.getSentMessages();
    for (let i = 0; i < messages.length; i++) {
      let li = this.renderMessage(messages[i]);
      ul.appendChild(li);
    }

    return ul;
  },

  renderMessage: function(message) {
    let li = document.createElement("li");
    li.className = "message";
    li.innerHTML = `<span class="to">To: ${message.to}</span>
                    <span class="subject">${message.subject}</span>
                    <span class="body">${message.body}</span>`;
    return li;
  }
}

module.exports = Sent;
