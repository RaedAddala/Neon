# Quick Guide To Membrane

Membrane is an Elixir ***multimedia processing*** framework that focuses on reliability, concurrency, and scalability.

It is used to define fault-tolerant, efficient and concurrent multimedia workflows.

## How it is strucutred

***Membrane is an ecosystem of plugins, libraries, formats and codecs.***

Membrane is modular by design and it works through **providing one scaffold that you can plug features in**, whether these plugins are part of the Membrane ecosystem or custom made.

This scaffold is the [Membrane Core](https://github.com/membraneframework/membrane_core) which provides the internal mechanisms and API that allow for preparing the multimedia pipeline in a convenient yet reliable way.
