document.addEventListener('DOMContentLoaded', function(){
  let container = document.querySelector('.characters-container')
  fetch('./data.json')
  .then(response => response.json())
  .then(data => {


    Object.keys(data).forEach(key => {

      let div = document.createElement('div')
      div.className = "character"
      div.innerText = key
      div.style.backgroundImage = "url(" + data[key]["portrait"] + ")"
      div.id = key

      let activeBorder = document.createElement('div')
      activeBorder.className = "active-border"

      div.appendChild(activeBorder)
      container.appendChild(div)
    })



  })


})
