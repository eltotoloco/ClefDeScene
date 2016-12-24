class Groupe < ApplicationRecord
      scope :by_genre, ->(genre) {where("genre = ?",genre)}

end
