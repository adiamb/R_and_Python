const app = document.getElementById('root');

// const logo = document.createElement('img');
// logo.src = 'images/SU.png';
// app.appendChild(logo);



const url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmax=30&retmode=json&rettype=abstract&term=Ambati+A&sort=date&mindate=2013/01&maxdate=2020/03'


fetch(url)
  .then((response) => response.json())
  .then((data) => {
    // console.log(data.esearchresult.idlist);
    var ids = data.esearchresult.idlist;
    console.log(ids.toString())
    parsedJson=parsePubmed(pubId=ids.reverse().toString())
  });


function parsePubmed(pubId) {
  const textUrl='https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&rettype=title&sort=date&id='+pubId
  fetch(textUrl)
    .then((resp) => resp.json())
    .then(data => {
      console.log(data)
      ul = document.getElementById('pubs')
      for (let item of Object.keys(data.result)){
        if(item != undefined){
          var title = data.result[item].title+' '
          var source = ' '+data.result[item].source.italics()+' '
          var dates_ = data.result[item].epubdate
          var authorsJson = data.result[item].authors
          const authList = []
          for (let ath of Object.keys(authorsJson)){
            var author = authorsJson[ath].name
            if (author == "Ambati A"){
              var author = author.fontcolor('red')
            }
            authList.push(author)
          }
          let li = document.createElement('li');
          ul.appendChild(li);
          li.innerHTML += title
          li.innerHTML += authList.toString(' ')
          li.innerHTML += source
          li.innerHTML += dates_

      }
    }
    });
  }
