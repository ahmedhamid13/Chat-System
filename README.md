# Prerequisites

You should have `ruby`, `rails`, `redis`, `elasticsearch`, `docker` and `mysql` installed. If you don't, install ruby, rails and mysql from [here](https://gorails.com/setup/ubuntu/20.04).

- Ruby -V 2.7.2
- Rails -V 5.2.6
- Redis -V 5.0.7
- MySQL -V 10.3.32-MariaDB-0ubuntu0.20.04.1
- ElasticSearch -V 7.16.2
- Docker -V 20.10.12
- Ubuntu -V 20.04

# Postman Api

1. PostMan_URL: https://documenter.getpostman.com/view/12318086/UVRGDP8s
2. PostMan_JSON: https://www.postman.com/collections/6ed2730407949c6a8158
## Installing

1. Download the zipped file and unzip it or Clone it
   ```sh
   $ git clone https://github.com/ahmedhamid13/Chat-System
   ```
2. Run this command to install the packages needed
   ```sh
   $ bundle install
   ```
3. Run this command to create the database and migrate tables (After set your credential data in config/database.yml)
   ```sh
   $ rake db:create db:migrate
   ```
4. Run this command to seed the database with data
   ```sh
   $ rake db:seed
   ```
5. Run this command to open the server
   ```sh
   $ rails s
   ```
6. Run this command to run sidekiq workers
   ```sh
   $ bundle exec sidekiq -C ./config/sidekiq.yml
   ```

# Docker

1. Build your application image
   ```sh
   $ docker-compose build
   ```
2. Run Application Container
   ```sh
   $ docker-compose up
   ```
3. Run Docker commands on your application
   ```sh
   $ docker-compose run app rails <>
   ```

# Unit Test (Spec)

1. Testing models
   ```sh
   $ rails test test/models
   ```
2. Testing controllers
   ```sh
   $ rails test test/controllers
   ```

# Erd of ChatSystem

<img src="https://github.com/ahmedhamid13/Chat-System/blob/master/erd_chat_system.png" alt="chat system erd" width="720">

# QR-Code To Deployment web

<img src="https://github.com/ahmedhamid13/Chat-System/blob/master/qrcode.png" alt="chat system qr code" width="200">

### License

MIT License

Copyright (c) 2021 [Ahmed Abdelhamid](https://github.com/ahmedhamid13)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
