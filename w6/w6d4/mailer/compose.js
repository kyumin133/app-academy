const MessageStore = require("./message_store");

const Compose = {

  render: () => {
    let div = document.createElement("div");
    div.className = "new-message";
    div.innerHTML = Compose.renderForm();

    div.addEventListener("change", (e) => {
      let el = e.target;
      let name = el.name;
      let value = el.value;
      MessageStore.updateDraftField(name, value);
    });

    div.addEventListener("submit", (e) => {
      e.preventDefault();
      MessageStore.sendDraft();
      window.location.hash = "#inbox";
    });
    return div;
  },

  renderForm: () => {
    let draft = MessageStore.getMessageDraft();
    return `<p class="new-message-header">New Message</p>
    <form class="compose-form">
    <input placeholder="Recipient", name="to", type="text", value="${draft.to}"/>
    <input placeholder="Subject", name="subject", type="text", value="${draft.subject}"/>
    <textarea name="body" rows="20">${draft.body}</textarea>
    <button type="submit" class="btn btn-primary submit-message">Send</button>
    </form>`;
  }
};

module.exports = Compose;
