FROM ruby:2.5.3

WORKDIR /hey_doctor

RUN apt-get update && rm -rf /var/lib/apt/lists/*

COPY . .

RUN echo 'alias rspec="bundle exec rspec"' >> ~/.bashrc && \
    echo 'alias rubocop="bundle exec rubocop"' >> ~/.bashrc && \
    echo 'alias rails="bundle exec rails"' >> ~/.bashrc

RUN gem install bundler && bundle install
