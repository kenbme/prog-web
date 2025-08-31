FROM ruby:3.4.5

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

RUN rails db:prepare
CMD ["bash", "-c", "rails db:prepare && rails server -b 0.0.0.0 -p 3000"]
