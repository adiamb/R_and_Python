const app = document.getElementById('root');

const logo = document.createElement('img');
logo.src = 'images/SU.png';
app.appendChild(logo);



const url = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmax=30&retmode=json&rettype=abstract&term=Ambati+A&sort=date'


fetch(url)
  .then((response) => response.json())
  .then((data) => {
    // console.log(data.esearchresult.idlist);
    var ids = data.esearchresult.idlist;
    ul = document.getElementById('pubs');
    ids.forEach(testFunc);
    function testFunc(val) {
      let li = document.createElement('li');
      ul.appendChild(li);
      li.innerHTML += val
      // console.log(val);
    }
    

    // return pubs.map(function(pubs) {
    //   let li = createNode('li')
    //   f= pubs.esearchresult.idlist[0];
    //   append(li, f)
    //   append(ul, li)
    // })
  });


// let request = new XMLHttpRequest();
// request.open("GET", "https://jsonplaceholder.typicode.com/todos/1")
// request.send()
// request.onload = ()

//request.open('GET', 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&rettype=abstract&term=Ambati+A&sort=date', true);
//request.onload = function () {

//   // Begin accessing JSON data here
//   var data = JSON.parse(this.response);
//   if (request.status >= 200 && request.status < 400) {
//     data.forEach(movie => {
//       const card = document.createElement('div');
//       card.setAttribute('class', 'card');

//       const h1 = document.createElement('h1');
//       h1.textContent = movie.title;

//       const p = document.createElement('p');
//       movie.description = movie.description.substring(0, 300);
//       p.textContent = `${movie.description}...`;

//       container.appendChild(card);
//       card.appendChild(h1);
//       card.appendChild(p);
//     });
//   } else {
//     const errorMessage = document.createElement('marquee');
//     errorMessage.textContent = `Gah, it's not working!`;
//     app.appendChild(errorMessage);
//   }
// }