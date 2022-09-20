require 'selenium-webdriver'
# include selenium-webdriver


# This module contains all code that interacts with selenium-webdriver.  
# The reason is so any updates are only required in one place.
module Browser    

    def standard_setup
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--start-maximized')
        $driver = Selenium::WebDriver.for :chrome, options: options
        # Open the base URL.
        $driver.get 'http://jupiter.cloud.planittesting.com'
        # $driver.get 'https://jupiter2.cloud.planittesting.com/#/shop'
    end

    def standard_teardown
        if $_args[:no_teardown]
            return true
        end
        $driver.close
    end

    def goto_page(page_link_text)
        click_href_with_text(5, page_link_text)
    end

    def click_element_with_id(element_id)
        $driver.find_element(:id, element_id).click
    end

    def click_href_with_text(timeout, href_text)
        href = wait_for_href_with_text(timeout, href_text)
        href.click
    end

    def get_element_text_by_id(element_id)
        $driver.find_element(:id, element_id).text
    end

    def set_element_text_by_id(element_id, text_to_set)
        $driver.find_element(:id, element_id).send_keys text_to_set
    end

    def get_element_by_tag_name(tag_name)
        $driver.find_element(tag_name: tag_name)
    end

    def get_elements_by_tag_name(tag_name)
        $driver.find_elements(tag_name: tag_name)        
    end

    def get_child_element_by_tag_name(base_element, tag_name)
        base_element.find_element(tag_name: tag_name)
    end

    # Return an ordered Array of the text of table headers on the page.
    def get_table_header_text
        th_text = []
        th_elements = get_elements_text_by_tag_name('th')
        th_elements.each do |each_th|
            th_text << each_th.text
        end
        return th_text
    end

    # Returns an ordered Array of td text from a table row.
    def get_table_data_text_from_table_row(table_row_element)
        table_data_text = []
        td_elements = table_row_element.find_elements(tag_name: 'td')
        td_elements.each do |each_td|
            # The td element may have a sub input element.
            td_input = get_table_data_input(each_td)
            if (td_input != nil)
                table_data_text << td_input.attribute('value')
            else
                table_data_text << each_td.text
            end
        end
        return table_data_text
    end

    # Returns an table data input if it exists, or nil.
    def get_table_data_input(td_element)
        begin
            return td_element.find_element(tag_name: 'input')
        rescue Selenium::WebDriver::Error::NoSuchElementError
            return nil
        end
    end

    # Returns an ordered Array of table rows from the table body on the page.
    def get_table_body_table_rows()
        table_body_element = get_element_by_tag_name('tbody')
        table_body_element.find_elements(tag_name: 'tr')
    end

    def get_elements_text_by_tag_name(tag_name)
        $driver.find_elements(tag_name: tag_name)
    end

    def get_element_text_by_css(css)
        $driver.find_element(css: css).text
    end

    def get_elements_by_css(css)
        $driver.find_elements(css: css)
    end

    def get_child_element_by_css(base_element, css)
        base_element.find_element(css: css)
    end

    def wait_for_href_with_text(timeout, href_text)
        href = nil
        begin
            wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
            wait.until { href = $driver.find_element(:link_text, href_text) }
        rescue Selenium::WebDriver::Error::TimeoutError
            puts "Timeout while waiting for href with text #{href_text}"
        end
        return href
    end
    
    def wait_for_element_with_id(timeout, element_id)
        begin
            wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
            wait.until { $driver.find_element(:id, element_id) }
        rescue Selenium::WebDriver::Error::TimeoutError
            puts "Timeout while waiting for element with id #{element_id}"
        end
    end

    def wait_for_element_with_tag(timeout, tag_name)
        begin
            wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
            wait.until { $driver.find_element(tag_name: tag_name) }
        rescue Selenium::WebDriver::Error::TimeoutError
            puts "Timeout while waiting for element with id #{element_id}"
        end
    end

    def element_displayed?(element_id)
        begin
            return $driver.find_element(:id, element_id).displayed?
        rescue Selenium::WebDriver::Error::NoSuchElementError
            return false
        end
    end


end





# A Parser for command line options.
module ArgParser

    $_args = {
        :no_teardown => false
    }

    for arg in ARGV
        if arg == '-nt'
            $_args[:no_teardown] = true
        end
    end
    
end

# Monkey patching this method so we can avoid stopping the Chrome service as the detach option has a known issue.
# C:\Ruby31-x64\lib\ruby\gems\3.1.0\gems\selenium-webdriver-4.4.0\lib\selenium\webdriver\common\service_manager.rb
module Selenium
    module WebDriver
      class ServiceManager

        def stop
            return if $_args[:no_teardown]
            stop_server
            @process.poll_for_exit STOP_TIMEOUT
          rescue ChildProcess::TimeoutError
            nil
          ensure
            stop_process
        end

      end
    end
end





