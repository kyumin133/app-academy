const Router = require("./router");
const Inbox = require("./inbox");
const Sent = require("./sent")
const Compose = require("./compose")

const routes = {
  inbox: Inbox,
  sent: Sent,
  compose: Compose
};

document.addEventListener("DOMContentLoaded", () => {
  let sidebarNavLi = document.querySelectorAll(".sidebar-nav li")
  for (let i = 0; i < sidebarNavLi.length; i++) {
    sidebarNavLi[i].addEventListener("click", (e) => {
      let innerText = e.currentTarget.innerText;
      innerText = innerText.toLowerCase();
      window.location.hash = innerText;
    });
  }

  let content = document.querySelector(".content");
  let router = new Router(content, routes);

  let startRouter = new Promise((resolve, reject) => {
    router.start();
    resolve();
  });

  startRouter.then(() => {
    window.location.hash = "#inbox";
    router.render();
  }).catch(() => {
    console.log("Failed to start router.");
  });
});
