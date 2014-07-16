require "sinatra"
require "active_record"
require "rack-flash"
require "gschool_database_connection"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :emails
  end

  post '/contact' do
    require 'pony'
    Pony.mail(
        :from => params[:name] + "<" + params[:email] + ">",
        :to => 'daz@gmail.com',
        :subject => params[:name] + " has contacted you",
        :body => params[:message],
        :port => '587',
        :via => :smtp,
        :via_options => {
            :address              => 'smtp.gmail.com',
            :port                 => '587',
            :enable_starttls_auto => true,
            :user_name            => 'daz',
            :password             => 'p@55w0rd',
            :authentication       => :plain,
            :domain               => 'localhost.localdomain'
        })
    redirect '/success'
  end

end