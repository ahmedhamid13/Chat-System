FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler:2.2.21
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

# RUN rails db:migrate
# RUN rails db:seed
# ADD . /app
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# CMD ["bundle", "exec", "sidekiq", "-C", "./config/sidekiq.yml"]
# CMD ["bundle", "exec", "sidekiq", "-r", "./update_chats_count_worker.rb"]
# CMD ["bundle", "exec", "sidekiq", "-r", "./update_message_count_worker.rb"]
# Configure the main process to run when running the image
EXPOSE 3000
