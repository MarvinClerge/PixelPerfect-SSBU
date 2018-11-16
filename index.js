// Wait for DOM to load
document.addEventListener('DOMContentLoaded', function(){
  // Current highlighted character to display
  let characterImage = document.querySelector('.player1 img')

  // Find characters box and obtain data from json
  let container = document.querySelector('.characters-container')
  fetch('./data.json')
  .then(response => response.json())
  .then(data => {

    // Create a div for each character in the container
    Object.keys(data).forEach(key => {

      let div = document.createElement('div')
      div.className = "character"
      div.innerText = key
      div.style.backgroundImage = "url(" + data[key]["portrait"] + ")"
      div.id = key

      // Border the show when the div is hovered
      let activeBorder = document.createElement('div')
      activeBorder.className = "active-border"

      // Display border when the div is hovered, set active character
      div.addEventListener('mouseenter', event => {
        event.target.querySelector('.active-border').style.display = "inline"

        characterImage.src = data[key]["image"]
        characterImage.alt = key
      })

      // Hide border when the div is not hovered
      div.addEventListener('mouseleave', event => {
        event.target.querySelector('.active-border').style.display = "none"
      })

      // Add border to div, div to container
      div.appendChild(activeBorder)
      container.appendChild(div)
    })
  })
})
