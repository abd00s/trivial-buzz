Trivial Buzz
===================
JSON API serving about 200,000 questions from the Jeopardy! gameshow obtained by crawling www.j-archive.com found on reddit[^reddit]. Some functionality includes searching across categories and questions, getting a random question as well as limiting categories and questions by value, air date and popularity.

For proper usage, ensure inclusion of **/api/[version]**/{endpoint} **.json**

The api is documented with swagger and can be explored from the browser.

----------


Local Copy
-------------

If you wish to recreate the app locally, follow these steps:

- `git clone git@github.com:abd00s/trivial-buzz.git`
-  `cd` into `trivial-buzz`
- `bundle` to install all gems and dependencies
- `rake db:setup` with a postgreSQL connection running
 > **Note:**
> `db:setup` will create the database, load the schema, and initialize with the seed data. Keep in mind that there are more than 200,000 records so seeding will take some time.

- `rails c` to enter interactive command line. Once in, `Search.refresh_materialized_view` to make records searcheable. If you add data from outside the provided seeds, this command must be run every time to include the new data in your search results.
- Back in your shell, run `rails s` and point your browser to  http://localhost:3000/

 > **Note:**
> If you wish to run the specs suite, you will need to setup and seed your test db
> - `rake db:setup RAILS_ENV=test`
> - `rails c test`
> - In the test console, run  `Search.refresh_materialized_view`
> - `rake spec`

I'm happy to receive your recommendations and bug reports.








  [^reddit]: Original dataset found on [r/datasets](https://www.reddit.com/r/datasets/comments/1uyd0t/200000_jeopardy_questions_in_a_json_file/)


