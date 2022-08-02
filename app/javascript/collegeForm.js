let button = document.querySelector("#change_college_info"); 
button.addEventListener("click", () => {
  let form = document.querySelector("#college_form"); 
  form.classList.toggle("hidden");
} )