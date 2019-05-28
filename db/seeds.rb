# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = [
   {
       name: 'What is your favourite programming language?',
       expires_at: 1.week.from_now,
       options: %w[Ruby Php Python JavaScript Java C++]
   },
   {
       name: 'Do you like this Docker-Rails project?',
       expires_at: 1.month.from_now,
       options: %w[Yes No]
   },
]

names.each do |params|
  Poll.transaction do
    poll = Poll.new params.slice(:name,:expires_at)
    params[:options].each do |option|
      poll.options << PollOption.new(name: option)
    end
    poll.save!
    puts " => '#{poll.name}' is created"
  end
end