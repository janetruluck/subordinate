# Subordinate

Subordinate is a api wrapper for the Jenkins API. It is not exhaustive at the moment and is being built out.

## Installation

Add this line to your application's Gemfile:

    gem 'subordinate'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install subordinate

## Documentation

## Configuration

Configuration allows for specifying your Jenkins instances variables

`domain` - The domain of your Jenkins server i.e. example.com

`subdomain` - The subdomain of your Jenkins server i.e. jenkins

`port` - The port of your Jenkins server i.e. 8080

`ssl` - If you would like to use ssl [Boolean]

Within an initializer `config/initializer/subordinate.rb`

```ruby
Subordinate.configure do |c|
    c.subdomain = "subdomain"
    c.domain    = "domain"
    c.port      = 1234
    c.ssl       = false
end
```

## Examples

### Setting up a new client

```ruby
client = Subordinate::Client.new(:username => "username", :api_token =>"token")
```
or
```ruby
client = Subordinate.new(:username => "username", :api_token =>"token")
```

You can also pass configuration keys such as `domain`, `subdomain`, `port` etc. as well.

### [Jobs](http://rdoc.info/github/jasontruluck/subordinate/Subordinate/Client/Job)

Currently offers the ability to build, delete, enable/disable jobs

```ruby
client.job("Job-Name")
```

### [Builds](http://rdoc.info/github/jasontruluck/subordinate/Subordinate/Client/Build)

Currently can retrieve information, console output, and timestamps

```ruby
client.build("Job-Name", 1)
```

###[System](http://rdoc.info/github/jasontruluck/subordinate/Subordinate/Client/System)

Currently can safe restart, restart, and quiet down

```ruby
client.restart
```

### Using Depth query parameter

For methods that allow you to specify a depth simply pass the depth you want via an option

```ruby
client.job("My-awesome-job", {:depth => 1})
```

The default depth is 0 for all methods.

### Using Tree query parameters

`tree` parameters are more efficient than using depth with exclude. They are available ot any methods that except them via options as well

```ruby
client.root({:tree => "jobs[name],views[name,jobs[name]]"}) 
```

A note from Jenkins: for array-type properties (such as jobs in this example), the name must be given in the original plural, not in the singular as the element would appear in XML (<job>). This will be more natural for e.g. json?tree=jobs[name] anyway: the JSON writer does not do plural-to-singular mangling because arrays are represented explicitly.

Please see the [docs](https://ci.jenkins-ci.org/api/) for more info on tree parameters

## Testing

This gem uses VCR to record requests to the api so you must test using a valid Jenkins server and credentails to test

Add a sample authentications file to your `spec/fixtures` directory:

```ruby
#spec/fixtures/authentications.yml
username:  jasontruluck           # Your Username
token:     12345678901234567890   # Your Jenkins Token (found at jenkins-server/user/your-user-name/configure)
domain:    mydomain.com           # The domain of your Jenkins server
port:      8080                   # The port of your Jenkins Server
subdomain: jenkins                # The subdomain of your Jenkins Server
job:       My-Jenkins-Job         # The job that you want to run tests on
```

A sample is included in the [source](https://github.com/jasontruluck/subordinate/blob/master/spec/fixtures/authentications.yml.sample).

*Note: for tests concerning disabling, deleting, restarting, etc they are mocked explicitly with webmock and will not effect your server*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
