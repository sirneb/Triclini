Triclini
========


ChangeLog
=========

2012-02-29

  - Added a few more 'Configure' pages
  - Tweaked layout setups
  - added "Event" Button with "Event Calendar" using fullcalendar plugin
     http://arshaw.com/fullcalendar/
  - Dashboard added

2012-02-28

  - started "Configure" pages, have basic layout
  - created "search" portion of the site
  - refactored the modal "reservation creation wizard"'s javascript for reusability


Backend "To Do" List
====================

  - User authentication
  - Reservation load by "date", this should handle the cases of "today, tomorrow, yesterday"
  - New Reservation Wizard data should be loaded with some type of MVC javascript plugin(backbone.js, knockout.js, etc..)
  - Need to write a function to handle inputting a date and club then popping out available events, dining options
  - Write a javascript to handle the first page of the modal reservation creation
  - Implement fullcalendar plugin to work with the app, make it easy to use and intuitive



Subdomain Reminder:  localhost will not work, must use lvh.me or pow to work subdomains
