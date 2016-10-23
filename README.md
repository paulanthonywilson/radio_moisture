# RadioMoisture

Project to monitor the moisture level of the soil of the Cultivate office plants. The idea is to have Arduino (actually [Shrimp kit](http://start.shrimping.it)) based moisture meters, which can be tuned to minimise battery usage, and broadcast the readings using [433 mhz transmitters](https://www.amazon.co.uk/gp/product/B00E9OGFLQ).

A PI will receive the readings and both provide a web interface (eventually) and prompt on Slack if a plant needs watering.

That's the plan, anyway.

## Things to investigate

* Will running down the batteries affect the moisture reading? 
* Can we prove that sleeping the Arduino improves battery life?
* What's a good waking up schedule?
* When is the soil too dry? What reading shows this?
* How long after watering does it take for the reading to settle down?
* Can the PI talk directly with the Radio, over VirtualWire, rather than through an intermediary Arduiono?
