# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
* I Used sinatra gem, to handle routes and actions.

- [x] Use ActiveRecord for storing information in a database:
* I Used both activerecord and sqlite by adding the gems to gemfile and its characteristics to controllers, models and environment, also the use of migrations to associate models with the database.

- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
* User.rb
* Expense.rb
* Category.rb

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
* User has_many :categories => categories belong_to :user
* Category has_many :expenses => Expense belong_to :category
* User has_many :expenses => Expense belong_to :user

- [x] Include user accounts
* I included an user model with its controller

- [x] Ensure that users can't modify content created by other users
* User controller was built to only allow current_user to modify its own content by checking its session user id before making any changes.

- [x] Include user input validations
* All parameters inserted in forms are validated before any action, and user is warned and re-routed if invalid data.

- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
* I used flsh-rack to add custom messages in case of any invalid data.

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
