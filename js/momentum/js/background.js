const images = [
    '0.png',
    '1.png',
    '2.png',
];

const backgroundImage = images[Math.floor(Math.random()*images.length)];

const baImage = document.createElement('img');
baImage.src = "img/"+backgroundImage;

document.body.appendChild(baImage)