# MailRBox

MailRBox is a pair of rudimentary SMTP and POP3 servers. DO NOT use this for
hosting production mail servers.

This was purely created to solve a task of creating an SMTP and POP3 server
using the Ruby Standard Library and a non-blocking event loop. It also comes
with a test suite, and an object oriented and domain driven design.

## Design

![SMTP Class Diagram](https://raw.github.com/andrewferk/mailrbox/master/docs/images/smtp_class_diagram.png)

## Test Suite

To run the test suite, simply execute

    rake test
