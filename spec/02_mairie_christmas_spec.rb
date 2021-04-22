require 'nokogiri'
require 'open-uri'

def get_townhall_email_city(townhall_url)

    mailS = []
    nameS = []

    townhall_url.each {|url|
    page = Nokogiri::HTML(URI.open(url))

    page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each{ |mail|
        mailS.push(mail.text)
    }
    
    page.xpath('/html/body/div/main/section[1]/div/div/div/h1').each{ |a|
        name = a.text[0,a.text.size-8]
        nameS.push(name)
    }
    }
    repertoire = []
    repertoire = nameS.zip(mailS).map! { |k, v| { k => v } }

    puts repertoire
    return repertoire
end

def get_townhall_urls
    page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))

    townhall_url=[]
    page.xpath('//a[@class="lientxt"]/@href').each{ |a|
        townhall_url.push("https://www.annuaire-des-mairies.com/" + a)
    }
    return townhall_url
end

def perform
    townhall_url = get_townhall_urls
    get_townhall_email_city(townhall_url)
end

perform
