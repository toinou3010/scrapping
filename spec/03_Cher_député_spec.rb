require 'nokogiri'
require 'open-uri'

def get_depHall_email_name(depHall_url)

    first_nameS = []
    last_nameS = []
    mailS = []

    depHall_url.each {|url|
    page = Nokogiri::HTML(URI.open(url))

        page.xpath('/html/body/div/div[2]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a').each{ |mail|
            mailS.push(mail.text)
        }
    
        page.xpath('/html/body/div/div[2]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a').each{ |a|
            first_nameS.push(a.text[0, a.text.index('.')].capitalize)
            if a.text[a.text.index('.') + 1, a.text.index('@') - a.text.index('.') - 1] == nil
                last_nameS.push("?")
            else
                last_nameS.push(a.text[a.text.index('.') + 1, a.text.index('@') - a.text.index('.') - 1].capitalize)
            end
        }
    }

    repertoire = []
    repertoire = first_nameS.zip(last_nameS, mailS)
    repertoire.map! { |e| ["first_name", "last_name", "email"].zip(e).to_h }
    
    puts repertoire
    return repertoire
end

def get_depHall_urls
    page = Nokogiri::HTML(URI.open('https://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))

    depHall_url=[]
    page.xpath('/html/body/div/div[2]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a/@href').each{ |a|
        depHall_url.push("https://www2.assemblee-nationale.fr/" + a)
    }
    return depHall_url
end

def perform
    depHall_url = get_depHall_urls
    get_depHall_email_name(depHall_url)
end

perform
