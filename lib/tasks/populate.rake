
namespace :db do
  desc "Populating db"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Book, Category, Author].each(&:delete_all)

    Category.populate 25 do |category|
      category.name = Populator.words(1..3).titleize
      category.description = Populator.sentences(5..25)
    end

    Author.populate 25 do |a|
      a.name = Faker::Name.name
      a.description = Populator.words(5..25)
    end

    Book.populate 200 do |book|
      book.title = Populator.words(1..5).titleize
      book.description = Populator.sentences(2..10)
      book.year = 1913..Time.now.year
      book.isbn = [*('A'..'Z'),*('0'..'9')].sample(13).join
      book.created_at = 2.years.ago..Time.now
    end

    Book.all.each do |book|
      # Gets up to 3 numbers from 1-25
      # 1.9.3-p374 :013 > (1..25).to_a.sample(rand(3)+1)
      #  => [17]
      # 1.9.3-p374 :014 > (1..25).to_a.sample(rand(3)+1)
      #  => [5, 16]
      # 1.9.3-p374 :015 > (1..25).to_a.sample(rand(3)+1)
      #  => [9, 10, 5]
      # 1.9.3-p374 :016 > (1..25).to_a.sample(rand(3)+1)
      #  => [3, 16]
      rand = (1..25).to_a.sample(rand(3)+1)
      book.authors = Author.find(rand)
      rand = (1..25).to_a.sample(rand(3)+1)
      book.categories = Category.find(rand)
      book.save
    end
  end
end
