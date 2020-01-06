# ticket-resale-notifier

A script that periodically checks for ticket resales on RA (for private use only)

It checks the link given in the Rakefile and sends a text to notify when a ticket becomes available

It is deployed on Heroku where the Scheduler add-on can be set to run the rake task every hour.
