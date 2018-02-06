IMDB_URL1 = 'http://www.imdb.com/list/ls072706884/'.freeze
IMDB_URL2 = 'http://www.imdb.com/list/ls074116029/'.freeze
IMDB_NAME = '//div[@class="info"]/b'.freeze
IMDB_DESC = '//div[@class="description" and not(@id="view-list-desc")]'.freeze

NNN2016_URL = 'http://www.newnownext.com/gay-celebrities-coming-out-day/12/2016/'.freeze
NNN2017_URL = 'http://www.newnownext.com/gay-celebrities-coming-out-2017/10/2017/'.freeze
NNN_NAME = '//ol[@class="listicle-container"]/li//h3[@class="heading"]'.freeze
nnn_desc_part_ol  = '//ol[@class="listicle-container"]/li'
nnn_desc_part_div = '/div[@class="description-container"]'
NNN_DESC = "#{nnn_desc_part_ol}#{nnn_desc_part_div}".freeze

MIC_URL  = 'https://mic.com/articles/105180/25-courageous-lgbt-celebrities-who-came-out-of-the-closet-in-2014#.qXvICFizx'.freeze
MIC_NAME = '//div[@class="article-page-body "]//h3'.freeze
mic_desc_part_div = '//div[@class="article-page-body "]'
mic_desc_part_h3  = '//h3/following-sibling::p[not(br)]'
MIC_DESC = "#{mic_desc_part_div}#{mic_desc_part_h3}".freeze

TOKEN = '490305270:AAFPPPp0N91yFfPfJZIQJKwzocN8zI4_mxA'.freeze
# https://api.telegram.org/bot490305270:AAFPPPp0N91yFfPfJZIQJKwzocN8zI4_mxA/
# setWebhook?url=https://4715ae80.ngrok.io/webhooks/telegram_molodechnoisthesaintplace

LEVENSTEIN_SEARCH_DISTANCE = 5
