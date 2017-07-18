require 'bundler/setup'
Bundler.setup

require 'sequel'
require 'sinatra/base'
require 'sinatra/jsonapi'

Sequel.extension :migration

class DemoService < Sinatra::Base
  register Sinatra::JSONAPI

  configure :production, :development do
    DB = Sequel.connect('sqlite://db/dbase.sqlite')
    Sequel::Migrator.run(DB, './db/migrations', use_transactions: true)
  end

  get '/status' do
    { status: 'OK' }
  end

  resource :user do
    helpers do
      def find(id)
        User.find(id: id.to_i)
      end
    end

    index do
      User.all
    end

    show do
      next resource
    end

    create do |attr|
      puts attr
      post = User.create(attr)
      next post.id, post
    end
  end
end

class User < Sequel::Model
end

class UserSerializer
  include JSONAPI::Serializer

  attribute :id
  attribute :name
  attribute :email
end
