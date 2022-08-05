let button = document.querySelector("#change_college_info")
button.addEventListener("click", () => {
  let form = document.querySelector("#college_form"); 
  let caption = document.querySelector("caption");
  form.classList.toggle("hidden");
  caption.classList.toggle("hidden");
} )