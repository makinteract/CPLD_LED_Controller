



function setup() 
{
	createCanvas(windowWidth, windowHeight);
}

function windowResized() {
	resizeCanvas(windowWidth, windowHeight);
  }



function draw()
{
	background(0,0,0);
	fill (255, 0, 0);
	ellipse (mouseX, mouseY, 100, 100);

	fill (255, 255, 0);
	ellipse(width/2, height/2, 100, 100);
}

const serialport = require('serialport')
// const tableify = require('tableify')



serialport.list((err, ports) => {
  console.log('ports', ports);
//   if (err) {
//     // document.getElementById('error').textContent = err.message
//     return
//   } else {
//     // document.getElementById('error').textContent = ''
//   }

//   if (ports.length === 0) {
//     // document.getElementById('error').textContent = 'No ports discovered'
//   }

//   tableHTML = tableify(ports)
//   document.getElementById('ports').innerHTML = tableHTML
});