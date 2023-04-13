const loginForm = document.getElementById('login-form')
const loginInput = loginForm.querySelector("input")
const greeting = document.querySelector('#greeting')
const HIDDEN_CLASSNAME = 'hidden'
const USERNAME_KEY = 'username'
// const loginButton = loginForm.querySelector("button")
// function loginButtonClicked() {
    // console.dir(loginButton)
    // let userId = loginInput.value
    // console.log(userId)

    // if (userId=='') {
    //     alert('write your ID')
    // }else if(userId.length >= 15){
    //     alert("it's too long")
    // } else console.log('hi', userId);
// }
function showGreeting(){
    const username = localStorage.getItem(USERNAME_KEY)
    greeting.innerText = `hello ${username}`
    greeting.classList.remove(HIDDEN_CLASSNAME)
    
}

// 자동으로 발생 이벤트 정보를 전달
function onLoginSubmit(arg1) {
    arg1.preventDefault(); //default인 submit 방지
    loginForm.classList.add(HIDDEN_CLASSNAME)
    const username = loginInput.value;
    localStorage.setItem(USERNAME_KEY, username)
    showGreeting()
}

// localStorage에 데이터가 있는지 확인
const savedUsername = localStorage.getItem(USERNAME_KEY)
if (savedUsername === null){
    loginForm.classList.remove(HIDDEN_CLASSNAME);
    loginForm.addEventListener('submit', onLoginSubmit);
} else{
    showGreeting()
}
