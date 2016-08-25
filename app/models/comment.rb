# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  rank       :integer          default(0)
#  valueable  :integer          default(0)
#  content    :text             not null
#  movie_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_movie_id  (movie_id)
#
# Foreign Keys
#
#  fk_rails_56963e5c80  (movie_id => movies.id)
#

class Comment < ApplicationRecord
  belongs_to :movie
end
