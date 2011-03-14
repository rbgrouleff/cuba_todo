require 'cuba'
require 'sass'
require 'couch_potato'
require 'todo/item'

CouchPotato::Config.database_name = 'todo'
CouchPotato::Config.validation_framework = :active_model

Cuba.define do
  on '' do
    on get do
      todos = Todo::Item.all
      res.write render('templates/index.html.erb', title: "Todo", todos: todos)
    end
  end

  on 'stylesheets', extension('css') do |file|
    on get do
      res['Content-Type'] = 'text/css'
      res.write render("templates/stylesheets/#{File.basename(file)}.scss")
    end
  end

  on 'todos' do
    on post do
      on param('text') do |text|
        todo = Todo::Item.new text: text
        todo.save
        res.redirect '/'
      end
    end
    on get do
      on ':id/delete' do |id|
        todo = Todo::Item.find id
        todo.destroy
        res.redirect '/'
      end
    end
  end
end
