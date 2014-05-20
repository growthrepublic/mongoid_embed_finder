# MongoidEmbedFinder

[![Code Climate](https://codeclimate.com/github/growthrepublic/mongoid_embed_finder.png)](https://codeclimate.com/github/growthrepublic/mongoid_embed_finder)

This simple gem lets you find embedded documents easily. It does not instantiate parent record with a whole bunch of embedded documents. Instead it instantiates found embedded documents first and then sets parent association.

At the moment it allows you to find only one embedded document and assumes relation `embeds_many`.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_embed_finder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_embed_finder

## Usage

Let's say that you have defined two classes as follows:

    class Door
      include Mongoid::Document
      embedded_in :car
    end
    
    class Car
      include Mongoid::Document
      embeds_many :doors
    end

Now you can easily retrieve instances of `Door` class using `finder`:

    finder = MongoidEmbedFinder::Runner.new(Door, :car)
    # first argument is embedded class
    # second is name of the association to the parent

If you have `door_id` at your hands:

    finder.first(id: door_id)
    # => instance of Door class or nil in case not found

If you have `door_id` and `car_id` as well, you can narrow scope of cars:

    finder.first(id: door_id, parent: { id: car_id })
    # => instance of Door class or nil in case not found

In general you can basically pass any set of child's and parent's attributes.
Latter group should be passed under `parent` key. Those attributes are passed down to `Mongoid::Criteria`.

## Contributing

1. Fork it ( https://github.com/growthrepublic/mongoid_embed_finder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
