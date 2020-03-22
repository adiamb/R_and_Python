let myImage =document.querySelector('img')

myImage.onclick = function(){
    let mySrc = myImage.getAttribute('src')
    if(mySrc == "https://lh3.googleusercontent.com/proxy/CppALewjfwPYJmDpSvCIdTdV_00bZiAgpIQc3urGKiE3XUPWtHNmgWp6S4OOd_NIOitGkbmUQRiAYMJEwBV6Sm_h2Zy3OJ5Vz9oLxXqxN-TZKaDTPbgIsXa8_3E6_6w") {
    myImage.setAttribute('src', "https://icons.iconarchive.com/icons/cornmanthe3rd/squareplex/512/Internet-chrome-icon.png")
    } else {
        myImage.setAttribute('src', "https://lh3.googleusercontent.com/proxy/CppALewjfwPYJmDpSvCIdTdV_00bZiAgpIQc3urGKiE3XUPWtHNmgWp6S4OOd_NIOitGkbmUQRiAYMJEwBV6Sm_h2Zy3OJ5Vz9oLxXqxN-TZKaDTPbgIsXa8_3E6_6w")
    }
}

let myButton = document.querySelector('button');
let myHeading = document.querySelector('h1');

function setUserName() {
    let myName = prompt('Please enter your name.');
    if(!myName || myName == null){
        setUserName();
    } else{
        localStorage.setItem('name', myName);
        myHeading.textContent = myName +'s First JS REACT Script';
    }
  }

if(!localStorage.getItem('name')) {
    setUserName();
} else {
    let storedName = localStorage.getItem('name');
    myHeading.textContent = storedName +'s First JS REACT Script';
}

myButton.onclick = function() {
    setUserName();
  }