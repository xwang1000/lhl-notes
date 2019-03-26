# Feature testing with RSpec and Rails
*W8D2*
`gem install capybara`
`capybara/poltergeist` A PhantomJS driver for Capybara
**headless** no GUI

`vagrant` has a headless interface

DEFAULT:
Rspec => Capybara => Default (non-js)

WE ARE DOING:
Rspec => Capybara (API) 
=> Potergeist (ruby driver for) 
=> PhantomJS (npm)
=> Headless Browser (!Chrome) 

``` ruby
feature do
    scenario 'visiter sees products' do
        visit '/'
        within('main.container') do
            expect(page).to have_text 'Products', count: 1
        end
    end
end
```

don't forget to clean up! 

# Automated Testing with RSpec and Rails
*W8D1*

## Testing
- regression due to lack of automated testing
- prioritize testing on important aspects of business

### Unit Testing
- A unit is the smallest testable part of any software. It usually has one or a few inputs and usually a single output.
- Each function might have multiple scenarios of testing
- Not to be tested: private methods, aren't exposed to the outside world
- *feature testing*, *end-to-end testing*, *integration testing*
- *acceptance testing*: other parts of company (ui...)

## Test-driven environment
- *BDD testing*: Behavior-Driven Development
- *cucumber* library for BDD testing
- *code coverage*

## let's code!
- Add `rspec` to `Gemfile`
- `bundle install` - you know the dealio
- `rails g respec:model NAME`
``` rb
# rspec file
describe '#active' do 
    it 'returns false for upcoming sales' # example (test case), it -> the action '#active'
        # Instantiate a sale 
        sale = Sale.new(starts_on: 'April 10, 2019', ends_on: 'April 20, 2019', percent_off: 10, name: 'Spring sale')
    
    expect(sale.active?).to eq false

    it 'returns true for active sales' 
       sale = Sale.new(starts_on: 'April 4, 2019', ends_on: 'April 20, 2019', percent_off: 10, name: 'Spring sale')
    expect(sale.active?).to eq true
end
```

only run one test
`bin/rspec spec/model/product_spec.rb:18`

### *w5d5 activity - unit testing*

# Nested Resources
*W7D5*

1. `Controller` 
    
    actions: 
    - index 
        - `@name = "Kanye`
        - all passed to the index view
    - new

2. `View`
    - `index.html.erb`
    - has access to the action in controller

3. `Model`
    - `rails generate model name description image`
        - generates migration and model
        - Migration hasn't been run yet
4. `db:migrate`
    - create a table
    - but nothing in it!

5. `migrate/...create_memes`
    - `string name`
    - `string url`
    - ...


**Read Don's Lecture**

# Rails Day 2
*W7D4*


![](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_4th_edition/images/figures/mvc_detailed.png  "MVC")

## Convention over configuration
I don't call the framework, the framework calls the code.

## Rails practice - Adding a store-wide sale
*IMPLEMENT WITH ERRORS*

*brower acess `admin/sales`*
1. ERROR: no routes 
    - Add routes then!
    - Routes: `rake routes | grep sales`
2. ERROR: unitialized controller
    - Generate controller then!
    - **`bin/rails g controller admin/sales`**
4. ERROR: action `index` isn't on the controller
    - `index` is an action / method on the controller, rendered by default
    - Add index in sales controller then!
5. ERROR:  Missing template `admin/sales/index`
    - add index page then!
    - you'll see empty view rendered inside of `main container` at admin/sales/index
    - `layout`
7. Start implementing view!
    - make `admin/sales/index` with `products/index`
    - `<%= render @sales%>` - gonna have a problem! cuz we ain't got sales data
        - equals to `render nil`
    - `<%raise @sales.inspect%>` - throw an error
8. ERROR: (no `@sales` data) can't find `nil` in ActiveModel Object
    - `render` takes the data and renders the view partial
    - `bin/rails g model Sale`: *generates both model and migration*
    - `App/models/Sale` - enough to connect with the database
9. ERROR: PendingMigrationError, migrations are pending
    - `db/migrate/Sale` -> it's empty!
    - Let's make the migration table then! => 
    - `bin/rake deb:migrate` auto generates an empty table with default id, timestamps
10. Rendered! But no Sales rows
    - console `Sale.first`, return `nil`
    - create sales then! *from console*
11. ERROR: Runtime error in admin/index
    - missing partial `admin/sales/_sale`
    - add `admin/sales/_sale`
12. Rendered, not in correct format
    - Add correct data presentation then!
    - `<%= sale.name%>`
    - `<%= sale.starts_on%>`
    - `<%= sale.ends_on%>`
    - `<%= sale.percent_off%>`
    - `<%= STATUS HERE%>`

    ``` erb
    <!-- in index, Not exact syntax -->
    if sales.starts_on > Date.current
        <span class="label label-upcoming">upcoming</span>
    end
    else
        <span class="label label-active">active</span>
    end
    ```

    - `<%=ACTIONS HERE%>`
14. ERROR: undefined method 'name' 
    - add those columns then!
    - in `/db/migrate`, change `CreateSales` table
    - `def change` -> both `up` and `down` *clever Active Record!*
    - `t.string :name` ...

15. DRY

    ``` erb
    <!-- admin/sales/_sale -->
    <%= render 'sale_status' %>

    <!-- _sale_status -->
    if sale.starts_on > Date.current
        <span class="label label-upcoming">upcoming</span>
    end
    else
        <span class="label label-active">active</span>
    end

    <!-- make the partial better again! -->
    if sale.isUpcoming?
        <span class="label label-upcoming">upcoming</span>
    end
    else
        <span class="label label-active">active</span>
    end
    ```

    - seperation of concerns: models/sale
    ``` rb
        class Sale < ActiveRecord::Base
            def isUpcoming
            def isActive
        end
    ```

15. `link_to new`
- takes array `path = [:admin, :sales, :new]`, `path.join('/')`, 
- creates `<a href='path'>`

16. routes
- only


# Rails
*W7D3*
- When starting the Rails server using `bin/rails server` use the following command instead: `bin/rails s -b 0.0.0.0` otherwise your app will not load in the browser. This is a essentially a Vagrant-specific issue which is why it's not mentioned in their guide. 


## MVC
https://www.railstutorial.org/book/toy_app#fig-mvc_detailed

Model View Control - a design pattern that dictates how you organize an application. Big in the web world.
- Model     
    - getting data from a store
    - store data from a store
    - validation 
    - piecing together data
- View
    - presentation （preparing html, json)
    - piecing together data used for the view
- Control
    - work with HTTP (ex. cookies, form data, http headers, parsing request parameters)
    - Orchestrate working with models and the views

Fat models, Dumb views, Skinny controllers

## REST
### CRUD
``` 
    POST /users             - create a new user
    GET /users/123          - view information about user 123
    PUT or PATCH /USERS/123 - Update the user with ID 123
    DELETE /USERS/123       - Delete user 123
    
    ---
    
    // Supporting resources

    GET /users/new - display some kind of input that will create a new user
    GET /users/123/edit - display a form that allows me to update user 123
    GET /users - display a full or partial list of users 
```

## Controller
### Debugging inside view
`<%=debugg%=> ` -> not accurate syntax 


# Active Record Example
*W7D2 Breakout*

### Active Record Callbacks 
- the object life cycle
`before_validation`, `before_destroy` ...
- Relational callbacks
    - `has_many`

### Active Record Migrations

use `!` 

e.g. **`nancy= User.create! :name => 'Nancy Bobancy'`**

// better for development

``` ruby
class Actor < ActiveRecord::Base
    belongs_to: :show
    say_tagline: 
end
```

``` ruby
class Show < ActiveRecord::Base
    # method call
    has_many: :actors, dependent: :destroy
end
```

### Active Record Validations

# More Ruby
*W7D2* Tuesday, March 19, 2019

## Bundler
`Gemfile` -> like `package.json` in npm

log file  -> this is the version that's currently installed

## Active Record & ORMs

### Active Record
the M in MVC - the model - the layer of the system responsible for representing busienss data and logic
### ORM
- object-relational mapping: mapping an object (class) to a database table
- since we're in OOP land, methods can then be added to each Class (.create .limit .first)
- every row in the database gets returned as an object
- Knex? it is a query builder, ORMs like Bookshelf either offer their own QB functions or 
- database models = database entities 

```
-- ORM (Bookshelf/Squalize) --
    |
-- KNEX (QB) --
    |
-- pg (gem) -- 
    |
-- pg (db) --

DB              ORM
---             ---           
tables          Class (Model)
records/rows    Instances
cols            Attributes

```
## OOP
- prototype-based inheritance or other 

## cOOP
class-based object-oriented programming
- Instances of objects created from classes
- Inheritance

knex is a query builder


# Breakout: Ruby Classes & OOP
Monday, March 18, 2019

## Pokémon! 
![alt text](https://i.pinimg.com/originals/f3/14/17/f314179b48b6184132860d57759ffbac.png "Jigglypuff")

with a Ruby class, you can only access a property that it allows you to. 

``` ruby
attr_reader :name     # read-only
attr_writer :name     # write-only
attr_accessor :name   # both ways
```

### What's a class?
- blueprint, describe what an object has, and what it does

### Instance variables? 
- Ruby's version of `this.<THING>`, making it so that a variable can be accessed/manipulated with different methods in a class
- `@name` instead of `name`

### Inheritance in Ruby classes 
- Don't repeat yourself
- You can have generic types, and more specific types that use the things from the generice types

``` ruby
# in a class
# A method that can be accessed by 
def self.description 

end

```

### Template method pattern
- a behavioral design pattern that defines the program skeleton of an algorithm in an operation, deferring some steps to subclasses. It lets one redfine certain steps of an algorithm without changing the algorithm's structure. 

## Ruby Dealing with data
### Constants Naming
 - ALL CAPS: constant value
 - Camel case: module / class
### Arrays
sort by multiple attributes
  
`people = people.sort_by { |a| [ a.first_name, a.last_name ] }`
