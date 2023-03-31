// 기초
// console.log('test');
// const a = 5, b = 3;
// let c = 4;

// let flg = true
// let n = null;
// let m;
// flg = 'et'

// const l = [1,2,3,4,'d']
// l.push('new')

// // object
// const player = {
//     name : 'han',
//     age: 27,
//     height: 167
// }
// player.weight = 62
// player.weight += 1


// function
// function hi(name){
//     console.log('hi '+name)
// }

// hi('has')

// const test_obj = {
//     num : 0,
//     name : 'test',
//     describe : function(){
//         console.log(test_obj.name)
//     },
//     add : function(a){
//         test_obj.num = test_obj.num +a
//         return a+test_obj.num
//     }
// }
// test_obj.describe()
// test_obj.add(5)
// console.log(test_obj.num)
// console.log(test_obj.add(5))

// const age = parseInt(prompt('how old are you?'));

// if(isNaN(age) || age <=0 ){
//     alert('NaN')
// }
// else if(age >=19 && age < 99){
//     alert('adu')
// }
// else if(age == 30 ){
//     alert('30')
// }
// else if(age != 30 ){
//     alert('not 30')
// }


// document 접근 및 변환
// var title = document.getElementById('title')
// console.dir(title)
// console.log(title.className)
// var hs = document.getElementsByClassName('h')
// console.log(hs)
// var tit = document.getElementsByTagName('h1')
// console.log(tit)
// .class:id __
// const title = document.querySelector('.d h1')
// console.log(title)
// title.innerText = 'get it'

// const titles = document.querySelectorAll('h1')
// console.log(titles)

// title.style.color = 'blue'


// 이벤트
const title = document.querySelector('.d h1')
const result = document.getElementById('title')

function handleTitleClick(){
    // console.log('clicked')
    result.textContent = 'clicked'
}
function thandleTitleClick(){
    // console.log('clicked')
    result.textContent = ''
}
// mdn


// title.onclick = handleTitleClick
title.addEventListener("click", handleTitleClick)
result.addEventListener('click', thandleTitleClick)
//  addEventListener를 사용하면 removeEventLinstener를 써서 제거 가능

function handleTitleMouseEnter(){
    title.innerText = 'mouse in'
}
function handleTitleMouseLeave(){
    title.innerText = 'mouse out'
}
title.addEventListener('mouseenter', handleTitleMouseEnter)
title.addEventListener('mouseleave', handleTitleMouseLeave)

title.onclick = handleTitleClick

// window
function handleWindowResize(){
    document.body.style.backgroundColor='tomato';
}
function handleWindowCopy(){
    alert('copy!')
}
function handleWindowWifiOn(){
    result.innerText = 'wifi on'
}

window.addEventListener('resize', handleWindowResize)
window.addEventListener('copy',handleWindowCopy)
window.addEventListener('online', handleWindowWifiOn)