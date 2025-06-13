
# Use official Ruby image
FROM ruby:3.1.2

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  curl \
  build-essential \
  libpq-dev \
  postgresql-client \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

# Install bundler
RUN gem install bundler

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy frontend dependencies
COPY package.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose the Rails server port
EXPOSE 3000

# CMD to handle assets, db setup, and server startup
CMD ["bash", "-c", "bundle exec rails assets:precompile && bundle exec rails db:prepare && bundle exec rails s -b 0.0.0.0"]
