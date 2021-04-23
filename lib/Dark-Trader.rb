require 'nokogiri' #ajout dépendance 
require 'open-uri'#ajout dépendance 


def create_hash() #fonction

    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/")) #ouverture de l'url

    symbolS=[] # création d'un array
    page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').each{ |a| #ciblage par xpath pui ajout du text dans l'arrey symbol
        symbolS.push(a.text)
    }

    priceS=[]
    page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a').each{ |a| #ciblage par xpath pui ajout du text dans l'arrey priceS
        priceS.push("$" + a.text)
    }

    cryptoS = [] #création hash
    cryptoS = symbolS.zip(priceS).map! { |k, v| { k => v } } #utilisation du zip pour fusionner les 2 array dans le hash
    

#   cryptoS.count
    puts cryptoS #affichage du hash
    return cryptoS
end

create_hash #appelle fonction
