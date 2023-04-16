

const API_KEY = '';

function onGeoOk(position){
    const lat = position.coords.latitude
    const lon = position.coords.longitude
    let url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric`
    
    
    fetch(url).then(response => response.json()).then(data => {
        console.log(data.name, data.weather[0].main);
        console.log(data);
        const weather = document.querySelector('#weather span:first-child')
        const city = document.querySelector('#weather span:last-child')
        weather.innerText = `${data.weather[0].main} / ${data.main.temp} `;
        city.innerText = data.name;
    });

}

function onGeoError(){
    alert('Geo Error!');
}

// 현재 위치 탐색
navigator.geolocation.getCurrentPosition(onGeoOk, onGeoError)

// 위경도를 주소로 변경 API
// https://openweathermap.org/
// 
// 35.8912968
// 128.6424869
// units=metric
