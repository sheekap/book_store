# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BookStore.Repo.insert!(%BookStore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias BookStore.Store

titles = elem(File.read("priv/data/book_titles.txt"), 1) |> String.split("\n")
genres = elem(File.read("priv/data/genres.txt"), 1) |> String.split("\n")

Enum.each(1..50, fn _x ->
  title = Enum.random(titles)
  genre = Enum.random(genres)
  price = String.to_float("#{Enum.random(1..200)}.#{Enum.random(1..99)}")

  {:ok, _book} = Store.create_book(%{
    author_first_name: Faker.Person.first_name,
    author_last_name: Faker.Person.last_name,
    description: Faker.Lorem.Shakespeare.En.hamlet(),
    genre: genre,
    isbn: Faker.Code.isbn(),
    price: price,
    title: title,
    year_published: Enum.random(1500..2022)
  })
end)
