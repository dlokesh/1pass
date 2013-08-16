# 1pass [![Gem Version](https://badge.fury.io/rb/1pass.png)](http://badge.fury.io/rb/1pass) [![Build Status](https://travis-ci.org/dlokesh/1pass.png)](https://travis-ci.org/dlokesh/1pass) [![Coverage Status](https://coveralls.io/repos/dlokesh/1pass/badge.png?branch=master)](https://coveralls.io/r/dlokesh/1pass?branch=master)

[1Password] command line client
[1password]: https://agilebits.com/onepassword

## Installation

    $ gem install 1pass

## Command line usage

Display all keychain entries (Master password not required). By default, the keychain is looked up at $HOME/Library/Application Support/1Password/1Password.agilekeychain

    $ 1pass --list
    mail.google.com
    github.com
    rubygems.org

    
Display all fields for the specified key    

    $ 1pass --key mail.google.com
    Enter your master password:  ********
    {"value"=>"my-email-id", "id"=>"Email", "name"=>"Email", "type"=>"E", "designation"=>"username"}
    {"value"=>"my-secret-password", "id"=>"Passwd", "name"=>"Passwd", "type"=>"P", "designation"=>"password"}
    {"value"=>"Sign in", "id"=>"signIn", "name"=>"signIn", "type"=>"I"}
    
Display value for the specified field

    1pass --key mail.google.com --field password
    Enter your master password:  ********
    my-secret-password
    
## License & Disclaimer

Licensed under MIT. Please refer to LICENSE file for details.

This project is an unofficial command-line client for [1Password] and is not supported by [AgileBits].
[agilebits]: https://agilebits.com

    

