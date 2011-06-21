# Accepts Nested Attributes with Polymorphic Associations and Custom Autosave

This Rails app provides an example for an issue I came across in a
recent app. We have people, addresses, and phone numbers. Addresses and
people could have many phone numbers. However, the default setup for
accepts_nested_attributes is to create a new object for the
nested attribute each time. I wanted the app to check first to see if
the phone number already existed, if it did then I wanted to
use that object, if it didn't then I wanted to create a new object. 

At present the tests work and show how overriding the
autosave_associated_records_for_<class_name>s will allow you to
customize whether to create or use an existing record.

To run the tests:

        $ bundle
        $ bundle exec rake db:setup
        $ bundle exec rake test:units


TODO - add a sample form that shows this creation in a working app.


