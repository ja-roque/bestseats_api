### Setup
It is a simple rails API

Clone the repo, bundle install and run the rails server.

## Routes
Two routes accepting POSTs were created: `/bestseat/venue` and `bestseat/seats`
The first one returns an array of all seats to render cool grid in FE.
The second one returns an array of the best seats only.

## RSpec
Tests were added to the models to check for the proper and intended parsing methods.
just run `rspec` at the projects root.

### Logic
Two models were created to better handle the corresponding data and statuses of each seat.

## Venue & Seat

The Venue class is instanced with the constraint data and it feeds itself with seats and rows which is basically a 2 dimensional array of Seat objects.

Once the instance is created, 
may now call the method find_best_available_seats which accepts a single arg:  The seat count that the user needs/wants.

The method fetches the best possible seat by getting the seat in the middle of the front row ( rows[0][rows.length-1 /2] )

While finding the best seat, an array of the available seats is created and each seat gets its distance to the best seat calculated and inserted as a property. 

The calculation works as follows: It substracts the row number of the current seat vs the row number of the best seat and the col number of the current seat vs the col number of the best seat. ( I get .abs for this calculations because the value may be negative sometimes. )    The result of these substraction are then added and appended to an array that contains the current seat and the distance [current_seat, distance]

All of these seat-distance arrays are then added to a parent array that sorts them by distance. Et Voila.
I now have the best seats of the available in a sorted array.

## Multiple seats 

To get best seats by groups a new method was added:

***get_best_group***

This method takes 3 args, the sorted seats, all of the seats and the count of wanted seats.

It basically runs through each "good available seat" and checks for the seats at the sides. 
If a seat at a side is available then it keeps adding seats to the potential best seat group.

If the best seat group length matches the count length then it returns the Seat array!

I added two extra arrays for extra efficiency, checked_seat and ungroupable.
If a seat has already been checked, then dont check it again, it has already been determined before that the seats doesnt have enough seats at the sides.

the ungroupable array tells the loop that it shouldnt try to check that seat for availability since it has already been "blacklisted".



