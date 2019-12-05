# FlightDanger-Classic
Adds a tooltip warning to potentially camped Flight Masters.

## How it Works

1. Scans **World Defense** and extracts the city name + timestamp of the message.
2. Stores the entry in a table of recently attacked cities.
3. Modifies the tooltip of the Flight Master window to indicate if a location has had a World Defense message associated with it in the last 5 minutes.

## Plans for Improvement

1. Some cities such as Menethil Harbor have a border that splits common fighting areas, so messages of dock workers being killed will read "Baradin Bay is under attack!". We should associate Baradin Bay and Menethil Harbor and find other such examples.
2. Give a warning if the flight point you're currently flying to has been attacked since you took off. Perhaps prompt to land and fly eslewhere?
3. Provide options such as the ability to set a custom timeframe of say 10 minutes instead of the default 5.
4. More detailed tooltips? Example "Camped X Minutes Ago"
5. Implement cross-player addon communication once more people have the addon installed. This will provide a more accurate event when Flight Masters are found dead.


