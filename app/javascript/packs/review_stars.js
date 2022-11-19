const stars = document.querySelector(".ratings").children;
const ratingValue = document.querySelector("#rating_value");
const ratingValueDisplay = document.querySelector("#rating-value-display");


let index;

for(let i=0; i < stars.length; i++){
  stars[i].addEventListener("mouseover", () => {
  for(let j=0; j<stars.length; j++){
  stars[j].classList.remove("far fa-star")
  stars[j].classList.add("fas fa-star")
  }
  for(let j=0; j<=i; j++){
    stars[j].classList.remove("far fa-star");
    stars[j].classList.add("fas fa-star");
  }
  })

  stars[i].addEventListener("click", () => {
    ratingValue.value = i+1;
    ratingValueDisplay.textContent = ratingValue.value;

    index = i;
  })

  stars[i].addEventListener("mouseout", () => {
    for(let j=0; j<stars.length; j++){
      stars[i].classList.remove("fas fa-star");
      stars[i].classList.add("far fa-star");
    }
    for(let j=0; j <=index; j++){
      stars[j].classList.remove("far fa-star");
      stars[j].classList.add("fas fa-star");
    }
  })
}