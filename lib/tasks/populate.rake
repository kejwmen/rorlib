
namespace :db do
  desc "Populating db"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Book, Category, Author].each(&:delete_all)
    
    Category.populate 25 do |category|
      category.name = Populator.words(1..3).titleize
      category.description = Populator.sentences(5..25)
      Book.populate 1..15 do |book|
        book.title = Populator.words(1..5).titleize
        book.description = Populator.sentences(2..10)
        book.year = 1913..Time.now.year
        book.isbn = [*('A'..'Z'),*('0'..'9')].sample(13).join
        book.created_at = 2.years.ago..Time.now
        book.category_ids = cat.id
      end
    end
    
    Author.populate 25 do |a|
      a.name = Faker::Name.name
      a.description = Populator.words(5..25)
        Book.populate 1..15 do |book|
        book.title = Populator.words(1..5).titleize
        book.description = Populator.sentences(2..10)
        book.year = 1913..Time.now.year
        book.isbn = [*('A'..'Z'),*('0'..'9')].sample(13).join
        book.created_at = 2.years.ago..Time.now
        book.author_id = a.id
      end
    end
    
    Book.populate 1..15 do |book|
      book.title = Populator.words(1..5).titleize
      book.description = Populator.sentences(2..10)
      book.year = 1913..Time.now.year
      book.isbn = [*('A'..'Z'),*('0'..'9')].sample(13).join
      book.created_at = 2.years.ago..Time.now
      book.author_id = author.id
      book.category_id = category.id
    end
  end
end
