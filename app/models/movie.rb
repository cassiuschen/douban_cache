# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null
#  title        :string
#  info         :hstore           default({})
#  rank         :float
#  douban_id    :string           not null, primary key
#  status       :integer          default("pending")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  genre        :string           is an Array
#  starring     :string           is an Array
#  director     :string           is an Array
#  release_date :date
#  runtime      :integer
#  sum_of_rank  :integer
#
# Indexes
#
#  index_movies_on_director   (director)
#  index_movies_on_douban_id  (douban_id) UNIQUE
#  index_movies_on_genre      (genre)
#  index_movies_on_starring   (starring)
#

class Movie < ApplicationRecord
  self.primary_key = 'douban_id'
  validates :douban_id, presence: true, uniqueness: true

  has_many :comments
  enum status: [:pending, :fetching, :fetched, :error]

  # After Create, Fetching the data from Douban, but it should handled by Sidekiq
  after_create :fetch_data

  def fetch_data
    begin
      #fetching!
      # Open page
      @page = Nokogiri::HTML(open("https://movie.douban.com/subject/#{douban_id}"))

      # Fetch Important Data
      self.title = @page.css("#content h1>span").first.text
      self.director = @page.css("[rel='v:directedBy']").map &:text
      self.starring = @page.css("[rel='v:starring']").map &:text
      self.genre = @page.css("[rel='v:genre']").map &:text
      self.release_date = @page.css("[property='v:initialReleaseDate']").first.attributes["content"].value.to_date
      self.runtime = @page.css("[property='v:runtime']").first.attributes["content"].value.to_i

      # Get additional info
      #info = {}
      #@page.css("#info>span").each do |el|
      #  if el.attributes["class"].value != "pl"
      #    info[el.css('span.pl').text.gsub(':','').gsub('：','')] = el.css("span.attrs").children.map {|ch| ch.text.gsub('更多...','') }.compact.delete_if {|ch| ch == " / "}
      #  end
      #end

      # Calculate Ranking
      ranks = {}
      (1..5).to_a.each {|stars| ranks[stars] = @page.css(".stars#{stars}").first.next_element.next_element.text.to_f}
      self.rank = ranks.map {|k, v| k * v}.sum * 2 / 100

      # Saving
      self.status = :fetched.to_s
      self.save!
    rescue => e
      puts "ERROR!============"
      puts e
      error!
    end
  end
end
