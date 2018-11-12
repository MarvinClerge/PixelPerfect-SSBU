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

      div.addEventListener('mouseenter', event => {
        console.log(event.target.id);
        event.target.querySelector('.active-border').style.display = "inline"
      })

      div.addEventListener('mouseleave', event => {
        console.log(event.target.id);
        event.target.querySelector('.active-border').style.display = "none"
      })

      div.appendChild(activeBorder)
      container.appendChild(div)
    })




  })


})
