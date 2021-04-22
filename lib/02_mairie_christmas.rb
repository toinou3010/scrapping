require 'nokogiri'
require 'open-uri'

mail = []
nom = []
url = []
url_var = "http://annuaire-des-mairies.com/"   






nokogiri_object = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
noms = nokogiri_object.xpath('//a[@class="lientxt"]/text()').each{ |c|
nom.push(c.text)
}
cities = nokogiri_object.xpath('//a[@class="lientxt"]/@href').each{ |a|
 url.push(url_var + a.text)
}


url.each{ |b|
open = Nokogiri::HTML(open(b))
email = open.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]')
mail.push(email.text)

}

$hash = Hash[nom.zip(mail)]
puts $hash
