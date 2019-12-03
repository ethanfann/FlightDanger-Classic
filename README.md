# FlightDanger-Classic
Adds a tooltip warning to potentially camped flight masters

## How it Works

1. Scans **World Defense** and extracts the city name + timestamp of the message.
2. Stores the entry in a table of recently attacked cities.
3. Modifies the tooltip of the flight master window to indicate if a location has had a World Defense message associated with it in the last 5 minutes.

