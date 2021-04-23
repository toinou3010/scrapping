require 'nokogiri' #ajout dépendance 
require 'open-uri' #ajout dépendance 

mail = [] # création d'un array
nom = [] # création d'un array
url = [] # création d'un array
url_var = "http://annuaire-des-mairies.com/"   #définition de l'url de base 






nokogiri_object = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html')) #ouverture de l'url
noms = nokogiri_object.xpath('//a[@class="lientxt"]/text()').each{ |c| #ciblage par xpath pui ajout du text dans l'arrey nom
nom.push(c.text)
}
cities = nokogiri_object.xpath('//a[@class="lientxt"]/@href').each{ |a| #ciblage par xpath pui ajout du text dans l'arrey url
 url.push(url_var + a.text)
}


url.each{ |b|
open = Nokogiri::HTML(open(b)) # ouverture de plusieur url 
email = open.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]') #ciblage par xpath pui ajout du text dans l'arrey mail
mail.push(email.text)

}

$hash = Hash[nom.zip(mail)] #création d'un hash et fusion des 2 arrey nom et mail
puts $hash
