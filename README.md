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
