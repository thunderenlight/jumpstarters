class Article < ActiveRecord::Base
	belongs_to :author
	has_many :comments
	has_many :taggings 
	has_many :tags, through: :taggings
	has_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	validates :title, :presence => true, :uniqueness => true
	validates :body, :presence => true

	def tag_list=(tags_string)
		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
		new_or_found_tags = tag_names.collect {|name| Tag.find_or_create_by(name: name) }
		self.tags = new_or_found_tags		
	end
	def tag_list
		tags.collect {|t| t.name}.join(", ")
	end
	def self.search_by_tag_name(tag_name)
		if tag_name.blank?
			[Article.all, nil]
		else
			Tag.find_by_name(tag_name)
			tag ? [tag.articles, tag] : [[], nil]
		end

	end
	def self.generate_samples(quantity = 100)
		tags = Tag.all
		quantity.times do
			article = Fabricate(:article)			
			article.created_at = article.created_at - (rand(300) + 100).hours
			article.tags = tags.sort_by{ rand }.take(3)
			article.save
			rand(2..6).times do
				Fabricate(:comment, :article => article, :created_at => article.created_at + rand(100).hours)	
			end
			yield if block_given?
		end
	end

end
