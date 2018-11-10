let navToggleButton = document.getElementById("navToggleButton");
let navList = document.getElementById("navList");

navList.classList.remove("expanded")
navList.classList.add("collapsed")

navToggleButton.onclick = function () {
  navToggleButton.classList.toggle("active");
  navList.classList.toggle("collapsed")
  navList.classList.toggle("expanded")
};
