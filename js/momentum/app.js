const loginForm = document.getElementById('login-form')

const loginInput = loginForm.querySelector("input")
const loginButton = loginForm.querySelector("button")

function loginButtonClicked(){
    console.dir(loginButton)
    let userId = loginInput.value
    console.log(userId)

    // if (userId=='') {
    //     alert('write your ID')
    // }else if(userId.length >= 15){
    //     alert("it's too long")
    // } else console.log('hi', userId);
}
loginButton.addEventListener("click",loginButtonClicked) 