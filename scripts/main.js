// const app = document.getElementById('root');

// const logo = document.createElement('img');
// logo.src = 'images/SU.png';
// app.appendChild(logo);



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
  });