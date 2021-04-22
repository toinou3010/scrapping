require 'nokogiri'
require 'open-uri'


def create_hash()

    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

    symbolS=[]
    page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').each{ |a|
        symbolS.push(a.text)
    }

    priceS=[]
    page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a').each{ |a|
        priceS.push("$" + a.text)
    }

    cryptoS = []
    cryptoS = symbolS.zip(priceS).map! { |k, v| { k => v } }
    

#   cryptoS.count
    puts cryptoS
    return cryptoS
end

create_hash
