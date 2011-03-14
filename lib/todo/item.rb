module Todo
  class Item
    include CouchPotato::Persistence

    property :text
    view :all_items, :key => :created_at

    def self.all(options = {})
      CouchPotato.database.view self.all_items(options)
    end

    def self.find(id)
      CouchPotato.database.load id
    end

    def destroy
      CouchPotato.database.destroy_document self
    end

    def save
      CouchPotato.database.save_document self
    end
  end
end
