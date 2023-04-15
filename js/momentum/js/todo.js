const toDoFrom = document.querySelector('#todo-form')
const toDoInput = toDoFrom.querySelector('input')
const toDoList = document.querySelector('#todo-list')

const toDoesKey = 'toDoes'
let toDoes = [];

function saveTodoes(){
    localStorage.setItem(toDoesKey, JSON.stringify(toDoes));
}
// JSON.stringify
// JSON.parse

function deletTodo(event){
    const li = event.target.parentElement;
    toDoes = toDoes.filter(todo => todo.id != li.id);
    li.remove();
    saveTodoes();
}


function paintTodo(newTodoObj){
    const li = document.createElement('li');
    li.id = newTodoObj.id;
    const span = document.createElement('span');
    span.innerText = newTodoObj.text;
    const btn = document.createElement('button');
    btn.innerText = '❌';
    btn.addEventListener('click', deletTodo);

    li.appendChild(span);
    li.appendChild(btn);
    toDoList.appendChild(li);
    
}

function handleToDoSubmit(event){
    event.preventDefault();
    const newTodoObj = {
        text: toDoInput.value,
        id : Date.now(),
    }
    toDoInput.value = '';

    toDoes.push(newTodoObj);
    saveTodoes();
    paintTodo(newTodoObj);
}
toDoFrom.addEventListener('submit', handleToDoSubmit);

const savedTodoes = localStorage.getItem(toDoesKey);
if (savedTodoes){
    const parsedToDoes = JSON.parse(savedTodoes);
    toDoes = parsedToDoes
    parsedToDoes.forEach(paintTodo);
} 