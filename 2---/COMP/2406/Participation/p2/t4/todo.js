/* 

In this versions, we contain all of the list information
in an array of objects. A renderList() function is defined.
This goes through the array and generates new HTML elements
to match the state of the objects in the array.
User interactions cause changes in the object state.
Render function is called whenever a change is made.
This is a nice design when involving a server, as it allows
the list data to easily be stringified and transmitted.
	
*/

let highlightColor = "yellow";

//The array to store all items in the list
let items = [];
let list = null;

function init(){
	//Initialize the event handlers
	document.getElementById("additem").addEventListener("click", addItem);
	document.getElementById("removeitem").addEventListener("click", removeItem);
	document.getElementById("highlight").addEventListener("click", highlightItems);
	document.getElementById("sort").addEventListener("click", sortItems);
	
	getList();

	setInterval(getList,10000);
}

function getList(){
	list = new XMLHttpRequest();
	list.onreadystatechange = function(){
		if(this.readyState==4 && this.status==200){
			items = JSON.parse(this.responseText).items;
			renderList();
		}
	}
	list.open("GET","http://127.0.0.1:3000/list",true);
	list.send();
}

//Returns true if an item with that name exists
function isDuplicate(itemName){
	for(let i = 0; i < items.length; i++){
		if(items[i].name === itemName){
			return true;
		}
	}
	return false;
}

function addItem(){
	//Verify an item name was entered
	let itemName = document.getElementById("itemname").value;
	if(itemName.length == 0){
		alert("You must enter an item name.");
		return;
	}
	
	//If it is not a duplicate
	if(!isDuplicate(itemName)){
		//Add a new object to the items array and render
		let newItem = {name: itemName, light: false, checked: false};
		
		let xhttp = new XMLHttpRequest();
		xhttp.open("POST","http://127.0.0.1:3000/list",true);
		xhttp.onreadystatechange = function(){
			if(this.readyState==4 && this.status==200){
				items.push(newItem);
				renderList();
			}
		}
		xhttp.send(JSON.stringify({operation:"add",item: newItem}));
		document.getElementById("itemname").value = "";
	}else{
		alert("Duplicate item names not allowed.");
	}
}

//Removes selected items
//Strategy is actually to build a new array of items to keep
//Then re-assign the items array to this new array
function removeItem(){
	let newItems = [];
	items.forEach(elem =>{
		//If an item isn't checked, we want to keep it
		if(!elem.checked){
			newItems.push(elem);
		}
	});
	let xhttp = new XMLHttpRequest();
	xhttp.open("POST","http://127.0.0.1:3000/list",true);
	xhttp.onreadystatechange = function(){
		if(this.readyState==4 && this.status==200){
			items = newItems;
			renderList();
		}
	}
	xhttp.send(JSON.stringify({operation:"rem",items: newItems}));
}

//Toggles highlight of selected items
function highlightItems(){
	items.forEach(elem =>{
		//If the item is checked, toggle its light property
		if(elem.checked){
			elem.light = !elem.light;
			elem.checked = false;
		}
	});

	let xhttp = new XMLHttpRequest();
	xhttp.open("POST","http://127.0.0.1:3000/list",true);
	xhttp.onreadystatechange = function(){
		if(this.readyState==4 && this.status==200){
			renderList();
	}
}
xhttp.send(JSON.stringify({operation:"highlight",items: items}));
}

//Sort the array, render the list again
function sortItems(){
	items.sort(function(a,b){
		if(a.name < b.name){
			return -1;
		}else if(a.name > b.name){
			return 1;
		}else{
			return 0;
		}
	})
	renderList();
}

function toggleCheck(){
	//'this' refers to the calling object
	//In this case, the checkbox that was clicked
	//We saved the 'value' property with the item name
	let itemName = this.value;
	items.forEach(elem => {
		if(elem.name === itemName){
			elem.checked = !elem.checked;
			renderList();
			return;
		}
	});
}

//Creates new items list HTML and replaces the old HTML
function renderList(){
	let highlightColor = "yellow";
	
	//Create a new div to hold the list
	//This will replace the old one
	let newList = document.createElement("div");
	newList.id = "list";
	
	//For each item in the array of items
	items.forEach(elem => {
		//Create a new div to be child of 'list' div
		//Set highlighting based on property of item
		let newDiv = document.createElement("div");
		if(elem.light){
			newDiv.style.backgroundColor = highlightColor
		}
		
		//Create and add the new checkbox
		let newItem = document.createElement("input");
		newItem.type = "checkbox";
		newItem.value = elem.name;
		newItem.id = elem.name;
		newItem.checked = elem.checked
		newItem.onclick = toggleCheck;
		newDiv.appendChild(newItem);
	
		//Create and add the new text node (the item name)
		let text = document.createTextNode(elem.name);
		newDiv.appendChild(text);
	
		//Add newly created div to children of list div
		newList.appendChild(newDiv);
	});
	
	let origList = document.getElementById("list");
	origList.parentNode.replaceChild(newList, origList);
}