require 'cgi'
pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://www.tigros.it/ebsn/api/products?page=1&page_size=36&parent_category_id=1270110&timeslotId=0&warehouseId=0',
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}

search_terms = ["Red Bull", "RedBull", "Energy Drink", "Energy Drinks"]
search_terms.each do |search_term|

  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://www.tigros.it/ebsn/api/products?page=1&page_size=24&q=#{CGI.escape(search_term)}&sort=rank&timeslotId=0&warehouseId=0",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end