const loginForm = document.getElementById('login-form')

const loginInput = loginForm.querySelector("input")
const loginButton = loginForm.querySelector("button")

function loginButtonClicked() {
    // console.dir(loginButton)
    // let userId = loginInput.value
    // console.log(userId)

    // if (userId=='') {
    //     alert('write your ID')
    // }else if(userId.length >= 15){
    //     alert("it's too long")
    // } else console.log('hi', userId);
}

function onLoginSubmit(arg1) {
    arg1.preventDefault(); //default인 submit 방지
    console.log(arg1)
}

loginButton.addEventListener("click", loginButtonClicked);

// 자동으로 발생 이벤트 정보를 전달
loginForm.addEventListener('submit', onLoginSubmit);

function hrefClicked(event) {
    event.preventDefault();
}


const herf1 = document.querySelector("#href1");
herf1.addEventListener('click', hrefClicked);