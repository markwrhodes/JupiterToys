require '.\Browser'
include Browser

# A class to represent the Cart page.
class Cart

    def initialize
        @page_ids = {
            'cart_li_id'        => 'nav-cart',
            'table_total_css'   => 'strong[class="total ng-binding"]'
        }
    end

    def goto_cart_page
        Browser.click_element_with_id(@page_ids['cart_li_id'])
        Browser.wait_for_element_with_tag(5, 'tbody')
    end

    # Returns the cart table as a two dimensional Array with the table header row as the first row
    # and then the table rows in the order as shown on screen.
    def get_cart_table
        table_array = []

        table_array << Browser.get_table_header_text
        table_row_elements = Browser.get_table_body_table_rows
        table_row_elements.each do |each_tr_element|
            table_array << Browser.get_table_data_text_from_table_row(each_tr_element)
        end
        return table_array
    end

    # Returns the quantity of an item in the cart table.
    def get_item_quantity(item_quantity_to_find)
        cart_table = get_cart_table

        item_index = cart_table[0].find_index("Item")
        quantity_index = cart_table[0].find_index("Quantity")
        cart_table.each do |each_cart_row|
            if each_cart_row[item_index] == item_quantity_to_find
                return each_cart_row[quantity_index].to_i
            end
        end
        return 0
    end

    def get_item_price(item_title_to_find)
        cart_table = get_cart_table

        item_index = cart_table[0].find_index("Item")
        price_index = cart_table[0].find_index("Price")
        cart_table.each do |each_cart_row|
            if each_cart_row[item_index] == item_title_to_find
                price = each_cart_row[price_index]
                return currency_string_to_float(price)
            end
        end
        return 0
    end

    def get_item_subtotal(item_subtotal_to_find)
        cart_table = get_cart_table

        item_index = cart_table[0].find_index("Item")
        subtotal_index = cart_table[0].find_index("Subtotal")
        cart_table.each do |each_cart_row|
            if each_cart_row[item_index] == item_subtotal_to_find
                subtotal = each_cart_row[subtotal_index]
                return currency_string_to_float(subtotal)
            end
        end
        return 0
    end

    def get_sum_of_all_subtotals
        cart_table = get_cart_table
        subtotal_sum = 0
        
        subtotal_index = cart_table[0].find_index("Subtotal")
        cart_table.each do |each_cart_row|
            subtotal = each_cart_row[subtotal_index]
            subtotal_sum += currency_string_to_float(subtotal)
        end
        return subtotal_sum
    end

    def get_cart_table_total
        cart_total = Browser.get_element_text_by_css(@page_ids['table_total_css'])
        cart_total.gsub(/Total: /, '').to_f
    end

    def currency_string_to_float(price)
        price.to_s.gsub(/[$,]/,'').to_f
    end

end