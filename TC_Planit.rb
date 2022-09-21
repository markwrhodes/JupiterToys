require "minitest/autorun"
require '.\Home'
require '.\Contact'
require '.\Shop'
require '.\Cart'

class TC_Planit < Minitest::Test
    
  def setup
    standard_setup
  end

  def teardown
    standard_teardown
  end

  def test_01_contact_page_error_validation
    contact = Contact.new
    expected_header_error = "We welcome your feedback - but we won't get it unless you complete the form correctly."
    expected_forename_error = "Forename is required"
    expected_email_error = "Email is required"
    expected_message_error = "Message is required"
  
    # 1. From the home page go to contact page
    contact.goto_contact_page

    # 2. Click submit button
    contact.click_contact_submit_button

    # 3. Validate errors
    assert_equal(expected_header_error, contact.get_header_error, "The expected header error was not correct")
    assert_equal(expected_forename_error, contact.get_forename_error, "The expected Forename error was not correct")
    assert_equal(expected_email_error, contact.get_email_error, "The expected Email error was not correct")
    assert_equal(expected_message_error, contact.get_message_error, "The expected Message error was not correct")

    # 4. Populate mandatory fields
    feedback_details = {'forename' => 'Mark', 'email' => 'mark.rhodes@gmail.com', 'message' => 'Test message'}
    contact.add_feedback(feedback_details)

    # 5. Validate errors are gone
    assert_equal(false, contact.contact_submit_errors_present?, "Errors are present after submission.")
  end


  def test_02_contact_page_submission_validation
    contact = Contact.new
    forename = 'Mark'
    expected_successful_submission_message = "Thanks #{forename}, we appreciate your feedback."

    # 1. From the home page go to contact page
    contact.goto_contact_page

    # 2. Populate mandatory fields and click the submit button.
    feedback_details = {'forename' => forename, 'email' => 'mark.rhodes@gmail.com', 'message' => 'Test message'}
    contact.add_feedback(feedback_details)
    
    # 3. Validate successful submission message
    assert_equal(expected_successful_submission_message, contact.get_successful_submission_message, 
                 "Incorrect successful submission message")
  end 

  
  def test_03_product_buy_and_cart_validation
    # 1. From the home page go to shop page
    shop = Shop.new
    shop.goto_shop_page

    # 2. Click buy button 2 times on “Funny Cow”
    shop.click_buy_button_for_product_with_title('Funny Cow')
    shop.click_buy_button_for_product_with_title('Funny Cow')

    # 3. Click buy button 1 time on “Fluffy Bunny”
    shop.click_buy_button_for_product_with_title('Fluffy Bunny')
    
    # 4. Click the cart menu
    cart = Cart.new
    cart.goto_cart_page

    # 5. Verify the items are in the cart.
    assert_equal(2, cart.get_item_quantity('Funny Cow'), 'Incorrect number of Funny Cows in the cart')
    assert_equal(1, cart.get_item_quantity('Fluffy Bunny'), 'Incorrect number of Fluffy Bunnies in the cart')
  end


  def test_04_product_buy_and_price_validation
    shop = Shop.new
    shop.goto_shop_page
    shop_stuffed_frog_price = shop.get_shop_item_price('Stuffed Frog')
    shop_fluffy_bunny_price = shop.get_shop_item_price('Fluffy Bunny')
    shop_valentine_bear_price = shop.get_shop_item_price('Valentine Bear')

    # 1. Buy 2 Stuffed Frog, 5 Fluffy Bunny, 3 Valentine Bear
    shop.buy_product('Stuffed Frog', 2)
    shop.buy_product('Fluffy Bunny', 5)
    shop.buy_product('Valentine Bear', 3)

    # 2. Go to the cart page
    cart = Cart.new
    cart.goto_cart_page    

    # 3. Verify the price for each product on the shop page, equals that on the cart page.
    cart_stuffed_frog_price = cart.get_item_price('Stuffed Frog')
    cart_fluffy_bunny_price = cart.get_item_price('Fluffy Bunny')
    cart_valentine_bear_price = cart.get_item_price('Valentine Bear')
    assert_equal(shop_stuffed_frog_price, cart_stuffed_frog_price, "Incorrect price for Stuffed Frog")
    assert_equal(shop_fluffy_bunny_price, cart_fluffy_bunny_price, "Incorrect price for Fluffy Bunny")
    assert_equal(shop_valentine_bear_price, cart_valentine_bear_price, "Incorrect price for Valentine Bear")

    # 4. Verify that each product’s sub total = product price * quantity
    stuffed_frog_quantity = cart.get_item_quantity('Stuffed Frog')
    stuffed_frog_subtotal = cart.get_item_subtotal('Stuffed Frog')
    assert_equal(stuffed_frog_subtotal, cart_stuffed_frog_price * stuffed_frog_quantity, "Incorrect Subtotal calculation for Stuffed Frog")
    
    fluffy_bunny_quantity = cart.get_item_quantity('Fluffy Bunny')
    fluffy_bunny_subtotal = cart.get_item_subtotal('Fluffy Bunny')
    assert_equal(fluffy_bunny_subtotal, cart_fluffy_bunny_price * fluffy_bunny_quantity, "Incorrect Subtotal calculation for Fluffy Bunny")

    valentine_bear_quantity = cart.get_item_quantity('Valentine Bear')
    valentine_bear_subtotal = cart.get_item_subtotal('Valentine Bear')
    assert_equal(valentine_bear_subtotal, cart_valentine_bear_price * valentine_bear_quantity, "Incorrect Subtotal calculation for Valentine Bear")

    # 5. Verify that total = sum(sub totals)
    sum_of_all_subtotals = cart.get_sum_of_all_subtotals
    table_total = cart.get_cart_table_total
    assert_equal(table_total, sum_of_all_subtotals, "The table total #{table_total} does not equal the sum of all subtotals #{sum_of_all_subtotals}")
  end

end








