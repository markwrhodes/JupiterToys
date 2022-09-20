require '.\Browser'
include Browser

# A class to represent the Shop page.
class Shop

    def initialize
        @page_ids = {
            'product_li_css'            => 'li[class="product ng-scope"]',
            'product_price_span_css'    => 'span[class="product-price ng-binding"]'
        }
    end

    def goto_shop_page
        Browser.goto_page('Shop')
        Browser.wait_for_element_with_id(5, 'product-1')
    end

    def click_buy_button_for_product_with_title(product_title)
        product_lis = Browser.get_elements_by_css(@page_ids['product_li_css'])
        # Iterate through the product lis until we find the correct title.  This click the corresponding anchor.
        product_lis.each do |each_product_li|
            if Browser.get_child_element_by_tag_name(each_product_li, 'h4').text == product_title
                Browser.get_child_element_by_tag_name(each_product_li, 'a').click
            end
        end
    end

    def buy_product(product_title, quantity)
        for i in 1..quantity
            click_buy_button_for_product_with_title(product_title)
        end
    end

    def get_shop_item_price(product_title)
        product_lis = Browser.get_elements_by_css(@page_ids['product_li_css'])
        # Iterate through the product lis until we find the correct title.  This click the corresponding span with price.
        product_lis.each do |each_product_li|
            if Browser.get_child_element_by_tag_name(each_product_li, 'h4').text == product_title
                return Browser.get_child_element_by_css(each_product_li, @page_ids['product_price_span_css']).text.gsub(/[$,]/,'').to_f
            end
        end
    end


end