console.log('test');
const a = 5, b = 3;
let c = 4;

let flg = true
let n = null;
let m;
flg = 'et'

const l = [1,2,3,4,'d']
l.push('new')

// object
const player = {
    name : 'han',
    age: 27,
    height: 167
}
player.weight = 62
player.weight += 1


// function
function hi(name){
    console.log('hi '+name)
}

// hi('has')

const test_obj = {
    num : 0,
    name : 'test',
    describe : function(){
        console.log(test_obj.name)
    },
    add : function(a){
        test_obj.num = test_obj.num +a
        return a+test_obj.num
    }
}
// test_obj.describe()
// test_obj.add(5)
// console.log(test_obj.num)
// console.log(test_obj.add(5))

const age = parseInt(prompt('how old are you?'));

if(isNaN(age) || age <=0 ){
    alert('NaN')
}
else if(age >=19 && age < 99){
    alert('adu')
}