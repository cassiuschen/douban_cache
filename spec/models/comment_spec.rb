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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
