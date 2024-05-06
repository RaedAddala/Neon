# AuthService
## RSA private/public keys 
Since our architecture is based on microservices, we chose an asymmetric encryption algorithm (RS256) to generate a private/public key pair.      
The private key is used to sign JWTs and the public key is used to verify them. 
The keys are saved in the directory       
```
./priv/keys
|_ public_key.pem
|_ secret_key.pem 
```       
Before starting the server, you have to add these files in your project.   
We have a worker that rotates and updates these keys every ``X hours``. 
## Start Server 
To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
