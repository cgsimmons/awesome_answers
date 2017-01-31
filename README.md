## AWESOME answerawesome

This is a simple Question & Answer web app built on rails. An API is also implemented. Some of the more interesting gems used include:

* omniauth-twitter

* fog

* carrierwave

* active_model_serializers

* cancancan

* simple_form

* and many more...

## Installation

Be suer to copy the file 'config/initializer/app_keys.example.rb' to '/config/initializer/app_keys.rb'. You will then need to uncomment the lines that define the keys. Don't forget to write your own keys into the file. The app currently supports email (for notifications), twitter (for authentication), and AWS S3(for storing images).

Then you can proceed with normal installation.

```bash
rails install
rails db:setup
rails s
```
**Note:** If you don't want to use faker to seed the app, replace 'rails db:setup with the commands below:'

```bash
rails db:create
rails db:migrate
```
