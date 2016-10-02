# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lorem = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'

update_sequence_sql = %Q( SELECT setval(pg_get_serial_sequence('{{TABLE}}', 'id'), max(id)) FROM {{TABLE}}; )
User.create(email: 'karetnikov.kirill@gmail.com', password: 'password')
User.connection.execute(update_sequence_sql.gsub('{{TABLE}}', 'users'))
options = {
  main: "Главная", about: "О нас", activity: "Деятельность", for_parents: "Родителям",
  method: "Методичка", photos: "Фотогаллерея", news: "Новости", login: "Вход"}
options.keys.each do |post_type|
  pt = PostType.create(name: post_type, human_name: options[post_type])
  pt.posts.create([
    {title: 'First post', body: lorem},
    {title: 'Second post', body: lorem}
  ])
  Post.connection.execute(update_sequence_sql.gsub('{{TABLE}}', 'posts'))
  PostType.connection.execute(update_sequence_sql.gsub('{{TABLE}}', 'post_types'))
end
