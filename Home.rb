require '.\Browser'
include Browser

# A class to represent the Home page.
class Home

    def goto_home_page
        Browser.goto_page('Home')
    end

end