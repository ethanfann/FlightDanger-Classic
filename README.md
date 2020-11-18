# FlightDanger-Classic
Adds a tooltip warning to potentially camped Flight Masters.

![Imgur](https://i.imgur.com/7facgPB.png)

## How it Works

1. Scans **World Defense** and extracts the city name + timestamp of the message.
2. Stores the entry in a table of recently attacked cities.
3. Modifies the tooltip of the Flight Master window to indicate if a location has had a World Defense message associated with it in the last 5 minutes.
