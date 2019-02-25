data = JSON.parse(content)

data=data['data']

promotion = data['warehousePromo']['view']['header'].gsub(/<[^<>]+>/, "") rescue  ""

size_info = data['description']
item_size = size_info[/(?<=\.)[^x]+?/]

uom=size_info[/.+?(?=\.)/]
in_pack = size_info[/(?<=x).+?\Z/]
if in_pack.nil?
  in_pack='1'
end

description = ""

data["metaData"]["product_description"].each do |value|

unless value[0] == 'ingredients'

  description = description+value[1]+" . "

end

end
description = description.gsub(/<[^<>]+>/, "").gsub(/[\n\r\s]+/,' ').gsub(/,/,' ').strip

product_details = {
    # - - - - - - - - - - -
    RETAILER_ID: '124',
    RETAILER_NAME: 'tigros',
    GEOGRAPHY_NAME: 'IT',
    # - - - - - - - - - - -
    SCRAPE_INPUT_TYPE: page['vars']['input_type'],
    SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
    SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? 'Bibite analcoliche' : '-',
    SCRAPE_URL_NBR_PRODUCTS: page['vars']['scrape_url_nbr_products'],
    # - - - - - - - - - - -
    SCRAPE_URL_NBR_PROD_PG1: page['vars']['nbr_products_pg1'],
    # - - - - - - - - - - -
    PRODUCT_BRAND: data['vendor']['name'],
    PRODUCT_RANK: page['vars']['product_rank'],
    PRODUCT_PAGE: page['vars']['page'],
    PRODUCT_ID: data['productId'],
    PRODUCT_NAME: data['name'],
    EAN:"",
    PRODUCT_DESCRIPTION: description,
    PRODUCT_MAIN_IMAGE_URL: data['media'][0]['medium'],
    PRODUCT_ITEM_SIZE: item_size,
    PRODUCT_ITEM_SIZE_UOM: uom,
    PRODUCT_ITEM_QTY_IN_PACK: in_pack,
    SALES_PRICE: data['priceDisplay'],
    IS_AVAILABLE: "1",
    PROMOTION_TEXT: promotion,
    EXTRACTED_ON:Time.now.to_s
}

product_details['_collection'] = 'products'

outputs<<product_details

