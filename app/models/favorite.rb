class Favorite < ApplicationRecord

  MAX_FAVORITE_COUNT=1

  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :user_id
  validate :favorites_count_must_be_within_limit

  private

   def favorites_count_must_be_within_limit
      errors.add(:favorite, "favorites count limit: #{MAX_FAVORITE_COUNT}") if user.favorites.count >= MAX_FAVORITE_COUNT
   end
end
