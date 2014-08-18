# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myflix::Application.initialize!

DATABASE_OPERATOR = {
  like_operator: 'LIKE'
}