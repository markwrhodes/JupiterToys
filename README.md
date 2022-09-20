# JupiterToys

This repository is a small testing framwork and test class for the Juniper Toys website.
The tests are contained within TC_Planit.rb and utilise page objects and a support module.
The tests will run against both of the following application URL's.

http://jupiter.cloud.planittesting.com 
https://jupiter2.cloud.planittesting.com/#/shop

The code is written in Ruby and mainly utilises the selenium-webdriver gem.

## Installation

First install a code editor such as [VS Code](https://code.visualstudio.com/docs/?dv=win).

Then install the [Ruby](https://rubyinstaller.org/downloads/) language.
I am using windows so I downloaded an installer (without the devkit) and ran it. For example [rubyinstaller-3.1.2-1-x64.exe](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.2-1/rubyinstaller-3.1.2-1-x64.exe)

Following the install you will see a Ruby install directory in your C drive.  E.g. C:\Ruby31-x64

You can also check the version you have by running ruby -v in your command line.
```bash
ruby -v
```

Your install will come with a default collection of RubyGems.  These are ruby software packages which contain a Ruby application or library. Gems can be used to extend or modify functionality in Ruby applications.  You can check which you have installed by running the following in the cmd line:
```bash
gem list --local
```

More information can be found at [rubygems.org](https://rubygems.org/)

We now need to install the selenium-webdriver, ffi and minitest gems.  Run the following in the cmd line:
```bash
gem install selenium-webdriver
gem install minitest
gem install ffi
```

[Selenium-webdriver](https://rubygems.org/gems/selenium-webdriver) implements the W3C WebDriver protocol to automate popular browsers. It aims to mimic the behaviour of a real user as it interacts with the application's HTML. It's primarily intended for web application testing, but any web-based task can automated.  [Minitest](https://rubygems.org/gems/minitest) provides a complete suite of testing facilities.

Next download the ChromeDriver binary for Chrome.  This will be used by selenium-webdriver.
[Download](https://chromedriver.storage.googleapis.com/index.html) the version that matches your Chrome install.  For example I am on Version 105.0.5195.127 (Official Build) (64-bit) so I downloaded [105.0.5195.19](https://chromedriver.storage.googleapis.com/105.0.5195.19/chromedriver_win32.zip).

I placed the chromedriver.exe in the following location:
C:\chromedriver\chromedriver.exe
And added C:\chromedriver\ to my PATH environment variable.

## Usage

Place all of the repository files in the same folder and from the command line run the file TC_Planit.rb to run all tests.
```bash
TC_Planit.rb
```

TC_Planit.rb contains the following four tests:
- test_01_contact_page_error_validation
- test_02_contact_page_submission_validation
- test_03_product_buy_and_cart_validation
- test_04_product_buy_and_price_validation

You can run a single test by specifying the cmd line argument -n and a regex of the name.  E.g.
```bash
TC_Planit.rb -n /test_01/
```

If you wish the browser to stay open following test excution use the -nt cmd line argument.  E.g.
```bash
TC_Planit.rb -nt -n /test_01/
```

## Additional Questions
**1. What other possible scenario’s would you suggest for testing the Jupiter Toys application?**
- Testing all navigation links.  E.g. we can get to the shop page from the "Start Shopping" on the home page, the "Shop" link at the top of the page or from the "Shopping" link from the cart.
- Test that on the contact page can we must provide a valid email address.  Also, do the fields have other sensible validation such as message size.
- On the shopping cart page we can test removing items from the cart, or updating the quantity.
- Test emptying the cart.
- Test the checkout process from the shopping cart.
- Test that the shopping cart is emptied after the checkout process has completed.
- Test payment option fields during the checkout process.  E.g. Compulsory fields and valid credit card numbers.
- Check the login functionality.
- Does this site work on a mobile device.  This can be emulated with selenium driver settings.


**1. What approaches could you used to reduce overall execution time?**
- Run the tests in headless mode to reduce execution time.
- Break the tests into multiple testpacks and run them in parallel on separate machines (e.g. separate VM's in a cloud service provider such as AWS or Azure).
- If business logic is performed in the application backend, could we change some of these tests to be API tests rather than browser based.  Or change to back end tests entirely for this business logic.

**3. How will your framework cater for this?**

**4. Describe when to use a BDD approach to automation and when NOT to use BDD**






