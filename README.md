# 1pass [![Build Status](https://travis-ci.org/dlokesh/1pass.png)](https://travis-ci.org/dlokesh/1pass) [![Coverage Status](https://coveralls.io/repos/dlokesh/1pass/badge.png?branch=master)](https://coveralls.io/r/dlokesh/1pass?branch=master)

[1Password] command line client
[1password]: https://agilebits.com/onepassword

## Installation

    $ gem install 1pass

## Command line usage

    $ 1pass --list
    
Display all keychain entries (Master password not required)

    $ 1pass --key mail.google.com
    Enter your master password:  ********
    {"value"=>"my-email-id", "id"=>"Email", "name"=>"Email", "type"=>"E", "designation"=>"username"}
    {"value"=>"my-secret-password", "id"=>"Passwd", "name"=>"Passwd", "type"=>"P", "designation"=>"password"}
    {"value"=>"Sign in", "id"=>"signIn", "name"=>"signIn", "type"=>"I"}

Display all fields for the specified key

    1pass --key mail.google.com --field password
    Enter your master password:  ********
    my-secret-password

    

